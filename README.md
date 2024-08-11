# CodeBrewer Frontend

Welcome to the CodeBrewer frontend repository! CodeBrewer is an interactive platform designed for coding enthusiasts to solve programming problems, participate in contests, and use an integrated IDE to run their code. This repository contains the code for the frontend, built using Flutter.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Usage](#usage)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [Contact](#contact)

## Features

- **Online IDE**: Integrated code editor and compiler supporting multiple programming languages.
- **Problem Solving**: Access to a wide range of coding challenges with varying difficulty levels.
- **Contests**: Create and participate in coding contests with live leaderboards.
- **User Authentication**: Secure sign-up and login functionality using Firebase.
- **Responsive Design**: Optimized for both web and mobile platforms.
- **Real-time Feedback**: Immediate results for code submissions.

## Getting Started

To get started with CodeBrawler frontend, ensure you have Flutter installed on your system. Follow the instructions below to set up the project locally.

### Prerequisites

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Dart SDK: Included with Flutter.
- Firebase: [Firebase Setup](https://firebase.google.com/docs/flutter/setup)

### Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/yourusername/codebrawler-frontend.git
   cd codebrawler-frontend
   ```

2. **Install Dependencies:**

   ```bash
   flutter pub get
   ```

3. **Set Up Firebase:**

   - Add your `google-services.json` for Android in `android/app`.
   - Add your `GoogleService-Info.plist` for iOS in `ios/Runner`.
   - Ensure `firebase_options.dart` is properly configured.

4. **Environment Variables:**

   - Create a `.env` file in the root directory.
   - Add your Firebase keys and other environment variables.

   Example:

   ```env
   FIREBASE_API_KEY=your_firebase_api_key
   AUTH_DOMAIN=your_project_id.firebaseapp.com
   PROJECT_ID=your_project_id
   STORAGE_BUCKET=your_project_id.appspot.com
   MESSAGING_SENDER_ID=your_sender_id
   APP_ID=your_app_id
   ```

5. **Run the App:**

   ```bash
   flutter run
   ```

## Project Structure

```
lib/
│
├── main.dart                   # Entry point of the application
├── screens/                    # Contains all the screen widgets
│   ├── authentication/         # Authentication-related screens
│   ├── home/                   # Home page and related widgets
│   └── contest/                # Contest-related screens
│
├── models/                     # Data models used in the application
│
├── providers/                  # Riverpod providers for state management
│
├── widgets/                    # Reusable widgets
│
└── services/                   # Firebase and API service classes
```

## Usage

- **Authentication**: Users can sign up or log in using their email and password. Firebase authentication is integrated to manage user sessions.
- **IDE and Compiler**: The integrated IDE allows users to write code, compile, and run it in real-time. Multiple programming languages are supported.
- **Problem Solving**: Users can browse through problems of different difficulty levels, submit solutions, and get instant feedback.
- **Contests**: Users can participate in or create coding contests. The platform supports live leaderboards and real-time scoring.

## Screenshots

_Add screenshots of your application here to visually demonstrate the features._

## Contributing

We welcome contributions from the community! If you'd like to contribute, please fork the repository and create a pull request with your changes.

1. Fork the repository.
2. Create your feature branch: `git checkout -b feature/YourFeature`.
3. Commit your changes: `git commit -m 'Add some feature'`.
4. Push to the branch: `git push origin feature/YourFeature`.
5. Open a pull request.

## Contact

For any questions or support, please contact us:

- **Ketan Verma**: ketanverma1511@gmail.com
- **Judal Raj**: judalraj0@gmail.com

---

This README provides a comprehensive overview of the CodeBrawler frontend project, guiding users through the setup process, project structure, and usage. Feel free to adjust any sections as needed!
