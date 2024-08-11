//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages : [Message] = [
    ]
    
    var emojiView: EmojiSuggestionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = K.appName
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
                self?.adaptInterface()
            }
        setupEmojiSuggestionView()
        loadMessages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let emojiSuggestionView = EmojiSuggestionView()
        // Ensure the emojiSuggestionView is visible
        emojiSuggestionView.isHidden = false
    }

    
    func printViewHierarchy(_ view: UIView, level: Int = 0) {
        let indent = String(repeating: "  ", count: level)
        print("\(indent)\(view.classForCoder): \(view.frame)")
        for subview in view.subviews {
            printViewHierarchy(subview, level: level + 1)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            print("Subviews: \(view.subviews)")
            if let emojiView = view.subviews.first(where: { $0 is EmojiSuggestionView }) {
                print("EmojiSuggestionView frame: \(emojiView.frame)")
            } else {
                print("EmojiSuggestionView not found in subviews")
            }
        }
    @objc func emojiButtonTapped(_ sender: UIButton) {
        guard let emoji = sender.titleLabel?.text else { return }
        messageTextfield.text?.append(emoji)
    }
    
    
    
    @objc func adaptInterface(){
        let analyzer = UserBehaviorAnalyzer.shared
        print("Adapting interface - Sentiment: \(analyzer.sentimentScore), Message Length: \(analyzer.messageLength)")
//        AdaptiveUIManager.shared.updateColorScheme(for: view, basedOn: analyzer.sentimentScore)
        AdaptiveUIManager.shared.updateFontSize(for: messageTextfield, basedOn: analyzer.messageLength)
        
        tableView.visibleCells.forEach{cell in
            if let messageCell = cell as? MessageCell{
                AdaptiveUIManager.shared.updateFontSize(for: messageCell.label, basedOn: analyzer.messageLength)
            }}
        
        tableView.reloadData()
        if let emojiSuggestionView = view.subviews.first(where: { $0 is EmojiSuggestionView }) as? EmojiSuggestionView {
                let mostUsedEmojis = UserBehaviorAnalyzer.shared.getMostUsedEmojis()
                emojiSuggestionView.updateEmojis(mostUsedEmojis)
            }
        
        view.setNeedsLayout()
            view.layoutIfNeeded()
    }
    
    private func setupEmojiSuggestionView(){
        print("Setting up EmojiSuggestionView")
        if  emojiView == nil{
            let emojiSuggestionView = EmojiSuggestionView(frame : CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
            emojiSuggestionView.translatesAutoresizingMaskIntoConstraints = false
            emojiSuggestionView.backgroundColor = UIColor.systemBackground
            view.addSubview(emojiSuggestionView)
            emojiView = emojiSuggestionView
            
            //        view.insertSubview(emojiSuggestionView, belowSubview: messageTextfield)
            NSLayoutConstraint.activate([
                emojiSuggestionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                emojiSuggestionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                emojiSuggestionView.bottomAnchor.constraint(equalTo: messageTextfield.topAnchor, constant: -8),
                emojiSuggestionView.heightAnchor.constraint(equalToConstant: 44)
            ])
            DispatchQueue.main.asyncAfter(deadline: .now()){
                let initialEmojis = ["😊", "👍", "❤️", "😂", "🎉"]
                emojiSuggestionView.updateEmojis(initialEmojis)
            }
        }
    }
    func loadMessages(){
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener(includeMetadataChanges: true){ querySnapshot, error in
            self.messages = []
            if let e = error{
                print("Cannot Fetch the messages, \(e)")
            }
            else{
                if let snapshotDocuments = querySnapshot?.documents{
                    for doc in snapshotDocuments{
                        let data = (doc.data())
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String{
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            UserBehaviorAnalyzer.shared.analyzeMessage(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                self.adaptInterface()
                            }
                        }
                    }
                }
                print("Messages fetched Sucessfully")
            }
        }
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email{
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField : messageSender,
                                                                      K.FStore.bodyField : messageBody,
                                                                      K.FStore.dateField : Date().timeIntervalSince1970]) { (error) in
                if let e = error{
                    print("There is issue saving data to firestone, \(e)")
                }
                else{
                    print("Successfully saved data")
                    DispatchQueue.main.async {
                        let newMessage = Message(sender: messageSender, body: messageBody)
                        UserBehaviorAnalyzer.shared.analyzeMessage(newMessage)
                        self.messageTextfield.text = ""
                        self.adaptInterface()
                    }
                }
            }
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
          try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

extension ChatViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
       
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)as! MessageCell
        cell.label.text = message.body
        
        let sentimentColor = AdaptiveUIManager.shared.updateColorScheme(for: view, basedOn: UserBehaviorAnalyzer.shared.sentimentScore)
        
        //This is the message from the current Loggedin User and So it will have Me as Sender.
        if message.sender == Auth.auth().currentUser?.email{
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)?.blended(with: sentimentColor)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }
        
        // If this is the message from another sender then
        else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lighBlue)?.blended(with: sentimentColor)
            cell.label.textColor = UIColor(named: K.BrandColors.blue)
        }
      
        return cell
    }
}

extension UIColor {
    func blended(with color: UIColor, ratio: CGFloat = 0.5) -> UIColor {
        let ratio = max(0, min(1, ratio))
        guard ratio != 0 else { return self }
        guard ratio != 1 else { return color }
        
        var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        return UIColor(red: CGFloat(r1 * (1 - ratio) + r2 * ratio),
                       green: CGFloat(g1 * (1 - ratio) + g2 * ratio),
                       blue: CGFloat(b1 * (1 - ratio) + b2 * ratio),
                       alpha: CGFloat(a1 * (1 - ratio) + a2 * ratio))
    }
}

