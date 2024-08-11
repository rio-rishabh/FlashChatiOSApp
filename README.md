# FlashChatiOS
Flash Chat is a messaging application that combines traditional email/password authentication with Google Sign-In functionality. 

## Features

- User authentication (Email/Password and Google Sign-In)
- Real-time messaging
- User-friendly interface with dynamic text effects

## Adaptive UI and Smart Emoji Suggestions

Our chat application now features an intelligent, context-aware interface that adapts to the conversation's tone and user behavior.

### Sentiment-Based Color Adaptation
- The app analyzes the sentiment of messages in real-time.
- Chat bubble colors subtly shift to reflect the overall mood of the conversation:
  - Positive sentiments add a soft green tint
  - Negative sentiments introduce a light red hue
  - Neutral messages maintain the default color scheme

### Dynamic Font Sizing
- Message text size adjusts based on the average length of recent messages.
- Longer messages result in slightly smaller text to maintain readability and conserve space.
- Shorter messages are displayed in a larger, more prominent font.

### Smart Emoji Suggestions
- The app learns from your emoji usage patterns.
- A convenient emoji suggestion bar appears above the keyboard.
- Suggested emojis update in real-time based on:
  - Your most frequently used emojis
  - The context of the current conversation
  - Overall chat sentiment

## Technologies Used

- Swift 5.10.1
- UIKit
- Firebase (Authentication, Firestore)
- Google Sign-In
- CocoaPods
- SPM(Swift Package Manager)

## Prerequisites
- Xcode 12.0 or later
- iOS 13.0 or later
- CocoaPods
- Swift Package Manager


## Installation
1. Clone the repository
2. Install Cocoapods

## Configuration

### Firebase Setup
1. Create a new Firebase project
2. Add an iOS app to the Firebase project
3. Download the GoogleService-Info.plist and add it to the Xcode project
4. Enable Email/Password and Google Sign-In authentication methods in Firebase console

### Google Sign-In Setup
1. Configure your Google Sign-In credentials in the Google Cloud Console
2. Add the reversed client ID to your Xcode project's URL schemes


## Usage

1. Run the app in Xcode
2. On the welcome screen, choose to register or log in
3. Once authenticated, you can send and receive messages in real-time

## Project Structure

- `WelcomeViewController`: Handles the initial screen and Google Sign-In
- `LoginViewController`: Manages user login
- `RegisterViewController`: Handles new user registration
- `ChatViewController`: Main interface for sending and receiving messages

 ## Acknowledgments
- Angela Yu's iOS Development Course
- Firebase Documentation
- Google Sign-In Documentation

## Contact

Your Name - sharma.rishabh@northeastern.edu, rishabhsharma61996@gmail.com

<img width="396" alt="Screenshot 2024-07-31 at 4 28 47 PM" src="https://github.com/user-attachments/assets/637e1b4e-b26a-426b-ad4f-984fc4be89f4">
<img width="360" alt="Screenshot 2024-07-31 at 4 29 17 PM" src="https://github.com/user-attachments/assets/f0976e9c-b376-47b4-9721-61aefbc8c2e9">
<img width="356" alt="Screenshot 2024-07-31 at 4 29 29 PM" src="https://github.com/user-attachments/assets/71a9fd21-702c-41d1-80cf-e246660dddbb">
<img width="366" alt="Screenshot 2024-07-31 at 4 29 39 PM" src="https://github.com/user-attachments/assets/8a64f8b6-7e34-4ce8-9d54-a9d6159a0f6d">
<img width="362" alt="Screenshot 2024-07-31 at 4 30 00 PM" src="https://github.com/user-attachments/assets/964f1926-d7a8-48ef-85b6-c241ca80c0aa">
<img width="378" alt="Screenshot 2024-08-11 at 1 25 59 AM" src="https://github.com/user-attachments/assets/e7260370-407a-40de-b424-b5977ba4dac1">
<img width="363" alt="Screenshot 2024-08-11 at 1 26 16 AM" src="https://github.com/user-attachments/assets/92746540-a0fd-437e-ba78-c5b9557f47f4">
<img width="373" alt="Screenshot 2024-08-11 at 1 26 28 AM" src="https://github.com/user-attachments/assets/452d6234-a1ba-430d-bc28-dcdfc2cc924e">


