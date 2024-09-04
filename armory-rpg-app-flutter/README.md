# Armory App: Custom Dice Generator for RPG Games

Armory App is a Flutter application designed to create customized dice for RPG games. The app provides a history of every dice roll, allows users to generate and customize different types of dice, and supports multi-language translations. It integrates with Google AdMob for advertisements and RevenueCat for in-app purchases. The app is currently available on [Google Play](https://play.google.com/store/apps/details?id=com.armory_app&hl=pt_BR) with 100+ downloads.

## Features

- **Custom Dice Generator**: Create and customize different types of dice for RPG games.
- **History Tracking**: Keeps a history of all dice rolls and actions, allowing users to review their past results.
- **Local Storage**: Utilizes `LocalStorageDatabase` for storing user data, including dice configurations and roll history.
- **Multi-Language Support**: Offers translations in English (EN), Spanish (ES), and Portuguese (PT-BR).
- **Ad Integration**: Uses Google AdMob to display advertisements.
- **In-App Purchases**: Integrated with RevenueCat for handling subscriptions and purchases.
- **State Management**: Implemented with the BLoC pattern for efficient state management.

## Getting Started

To get started with the Armory App, follow these steps:

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/yourusername/armory-app.git
   cd armory-app
   ```

2. **Install Dependencies**:

   ```bash
   flutter pub get
   ```

3. **Run the App**:
   ```bash
   flutter run
   ```

## Technologies Used

- **Flutter**: Framework for building the cross-platform mobile app.
- **LocalStorageDatabase**: For local data persistence, storing user settings, dice configurations, and roll history.
- **Google AdMob**: For integrating ads within the app.
- **RevenueCat**: For managing in-app purchases and subscriptions.
- **BLoC Pattern**: State management solution to handle the application's state changes.
- **Localization**: Support for English (EN), Spanish (ES), and Portuguese (PT-BR) using Flutter's localization framework.

## Translations

The app is fully localized to support the following languages:

- English (EN)
- Spanish (ES)
- Portuguese (PT-BR)

Translations have been implemented using Flutter's `intl` package, ensuring that users receive content in their preferred language.

## Known Issues and Areas for Improvement

- **User Interface**: The current interface was created without a design plan, focusing more on functionality rather than aesthetics. A redesign would significantly improve the app's appearance and user experience.
- **Additional Features**: Consider adding more dice customization options or additional RPG tools to enhance the app's value to users.

## Future Enhancements

- **Redesign UI/UX**: Improve the overall look and feel of the app with a professional redesign to make it more appealing and user-friendly.
- **More Customization Options**: Add features like custom dice skins, sounds, or animations.
- **Expand Language Support**: Add support for more languages based on user feedback.

## Contributions

Contributions are welcome! Please feel free to submit a pull request or open an issue to discuss your ideas.

## Feedback and Support

If you encounter any issues or have suggestions for new features, feel free to open an issue in this repository or contact the developer.

## Download

The app is available on [Google Play](https://play.google.com/store/apps/details?id=com.armory_app&hl=pt_BR).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Thank you for checking out Armory App! If you like the app, please consider leaving a review on Google Play. Your feedback helps improve the app for everyone!
