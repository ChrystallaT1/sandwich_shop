# Sandwich Shop App

Welcome to the **Sandwich Shop App**, a Flutter application designed to help users customize and manage their sandwich orders. This app allows users to select sandwich types, bread types, add notes for special requests, and adjust the quantity of sandwiches dynamically.

---

## Project Description

The Sandwich Shop App provides an intuitive interface for users to:

- Choose between **six-inch** and **footlong** sandwiches.
- Select the type of bread (white, wheat, or wholemeal).
- Add special notes to their order (e.g., "no onions", "extra pickles").
- Dynamically adjust the quantity of sandwiches using "Add" and "Remove" buttons.
- View a summary of their order, including sandwich type, bread type, quantity, and notes.

The app is built using **Flutter** and follows modern UI design principles to ensure a smooth user experience.

---

## Installation and Setup Instructions

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK**: Comes bundled with Flutter.
- **Android Studio** or **Visual Studio Code**: Recommended IDEs for Flutter development.
- A physical or virtual device (emulator) to run the app.

### Steps to Install and Run the App

1. Clone the repository:

   ```bash
   git clone https://github.com/ChrystallaT1/sandwich_shop.git

   ```

2. Navigate to the project directory:
   cd sandwich-shop

3. Install dependencies:
   flutter pub get

4. Run the app:
   flutter run
   Ensure you have a connected device or emulator running.

### Usage Instructions

Features

1. Sandwich Type Selection:
   Use the toggle switch to choose between six-inch and footlong sandwiches.

2. Bread Type Selection:
   Select the bread type from the dropdown menu (white, wheat, or wholemeal).
3. Add Notes:
   Use the text field to add special notes to your order (e.g., "no onions").

4. Adjust Quantity:
   Use the "Add" and "Remove" buttons to increase or decrease the quantity of sandwiches.
   Buttons are disabled when limits are reached (e.g., quantity cannot exceed the maximum or go below zero).

5. Order Summary:
   View a summary of your order, including sandwich type, bread type, quantity, and notes.

Screenshots
Include screenshots of the app interface to showcase its functionality (optional).

Project Structure
sandwich_shop/
├── lib/
│ ├── main.dart # Main entry point of the app
│ ├── views/
│ │ ├── app_styles.dart # Contains text styles for the app
│ ├── repositories/
│ │ ├── order_repository.dart # Placeholder for order-related logic
├── pubspec.yaml # Dependency configuration

Contact Information
For questions, suggestions, or contributions, feel free to reach out:

Name: Chrystalla Tampouri
Email: up2257593@myport.ac.uk
GitHub: ChrystallaT1
