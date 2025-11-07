# GitView - GitHub Repository Viewer

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge\&logo=flutter\&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge\&logo=dart\&logoColor=white)](https://dart.dev/)
[![GetX](https://img.shields.io/badge/GetX-DD1133?style=for-the-badge\&logo=getx\&logoColor=white)](https://getx.dev/)

A modern, feature-rich Flutter application that allows users to explore GitHub repositories with a beautiful UI and smooth user experience.

> **Note:** This project is submitted as an assignment .

## 📱 Screenshots


<img src="https://github.com/user-attachments/assets/620dbec8-3376-4da8-a48c-6cbbb35aa7c1" height="200">
<img src="https://github.com/user-attachments/assets/46279416-3436-4817-bd53-18eeff936675"  height="200">
<img src="https://github.com/user-attachments/assets/2c55ee69-597a-476e-8579-fcee03a36966"  height="200">
<img src="https://github.com/user-attachments/assets/91390b18-1d0b-4762-a546-36db2223b5ed"  height="200">
<img src="https://github.com/user-attachments/assets/71bf6cb6-8431-4ee3-b2a1-48eebe26a716"  height="200">
<img src="https://github.com/user-attachments/assets/2c788117-2d1e-4bdf-8b14-776341bafa93"  height="200">
<img src="https://github.com/user-attachments/assets/0ef74526-2404-4da4-88be-9543d8d48872"  height="200">



## ✨ Features

* 🔍 **Search GitHub Users**: Enter any GitHub username to explore their repositories
* 👥 **Popular Developer Suggestions**: Quick access to profiles of renowned Flutter developers
* 📊 **Repository Views**: Switch between list and grid views for better visualization
* 🔧 **Advanced Filtering**: Filter repositories by name and sort by various criteria
* 📱 **Responsive Design**: Optimized for mobile, tablet, and desktop screens
* 🌙 **Theme Support**: Toggle between light and dark themes
* ⚡ **Modern UI**: Material 3 design with smooth animations and transitions
* 📈 **Detailed Repository Information**: Comprehensive view of repository stats and metadata
* 🚀 **Performance**: Efficient state management with GetX and optimized API calls

## 🏗️ Architecture

This app follows Clean Architecture principles with Domain-Driven Design (DDD) to ensure scalability, maintainability, and testability.

### Project Structure

```
main.dart

core/
├── constants/
│   └── app_constants.dart
├── di/
│   └── dependency_injection.dart
├── errors/
│   └── failures.dart
├── network/
│   └── dio_client.dart
├── routes/
│   └── app_pages.dart
├── utils/
│   ├── app_colors.dart
│   ├── app_text.dart
│   ├── app_theme.dart
│   ├── date_formatter.dart
│   └── responsive.dart
└── widgets/

data/
├── models/
│   ├── repository_model.dart
│   └── user_model.dart
├── repositories/
│   └── github_repository_impl.dart
└── services/
    └── github_api_service.dart

domain/
├── entities/
│   ├── repository.dart
│   └── user.dart
├── repositories/
│   └── github_repository.dart
└── usecases/
    ├── get_repository_details_usecase.dart
    ├── get_user_repositories_usecase.dart
    └── get_user_usecase.dart

presentation/
├── controllers/
│   ├── home_controller.dart
│   ├── repository_details_controller.dart
│   ├── theme_controller.dart
│   └── user_input_controller.dart
├── models/
│   └── repository_details_args.dart
├── pages/
│   ├── home_page.dart
│   ├── repository_details_page.dart
│   ├── splash_screen.dart
│   └── user_input_page.dart
└── widgets/
    ├── loading_widget.dart
    ├── repository_grid_item.dart
    └── repository_list_item.dart
```

### Architecture Layers

1. **Presentation Layer**: UI components and controllers using GetX for state management
2. **Domain Layer**: Business logic, entities, and use cases
3. **Data Layer**: Models, repository implementations, and API services

## 🛠️ Technologies Used

* **Flutter**: Latest version with Material 3 design
* **GetX**: State management, dependency injection, and navigation
* **Dio**: HTTP client for API requests with error handling
* **Get Storage**: Local storage for theme and view preferences
* **Dartz**: Functional programming with Either type for error handling
* **Intl**: Date formatting and internationalization
* **Cached Network Image**: Efficient image loading and caching
* **Flutter Staggered Grid View**: Responsive grid layouts
* **Shimmer**: Loading animations

## 🚀 Getting Started

### Prerequisites

* Flutter SDK (latest version)
* Dart SDK
* An IDE such as VS Code or Android Studio

### Installation

1. Clone the repository:

```bash
git clone https://github.com/ReturajProshad/gitview.git
cd gitview
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

## 📖 Usage

* **Launch the App**: Start with a beautiful animated splash screen
* **Enter a Username**: Input any GitHub username or select from popular Flutter developers
* **Explore Repositories**: View repositories in list or grid format
* **Filter & Sort**: Apply filters and sort repositories by name, stars, or date
* **View Details**: Tap on any repository to see detailed information
* **Customize Experience**: Toggle between light and dark themes

## 🔧 Configuration

The app uses the GitHub REST API for fetching data. No API key is required for basic usage, but you may encounter rate limits if making too many requests.

## 🧪 Testing

To run the tests:

```bash
flutter test
```

## 📱 Build & Release

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 🙏 Acknowledgments

* Flutter for the amazing cross-platform framework
* GetX for the powerful state management solution
* GitHub REST API for providing the data
* The Flutter community for all the amazing packages and resources

## 👨‍💻 Author

**Returaj Proshad**

* GitHub: [@ReturajProshad](https://github.com/ReturajProshad)
* LinkedIn: [Returaj Proshad](https://www.linkedin.com/in/returaj-proshad/)
* Email: [returajsumon0808@gmail.com](mailto:returajsumon0808@gmail.com)

⭐ If you like this project, please give it a star!
