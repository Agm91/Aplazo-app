# aplazo_app

This application needs [the AplazoBackend Repository](https://github.com/Agm91/AplazoBackend) for it to work.

The application flow begins with a **User Registration** screen, where users are required to enter their name and date of birth.

Next, the **List of Purchases** screen displays all recorded purchases.

Following this, users can navigate to the **Register Purchase** screen to input new purchase details.

Finally, the **Success** screen confirms the successful registration of a purchase.

It has **en** and **es** languages.

## Prerequisites

Make sure you have the following installed before you start:

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) or **[VS Code](https://code.visualstudio.com/)**
- A configured emulator (**Android** or iOS)

## Instructions

### Step 1: Clone the Repository

First, clone this repository to your local.

### Step 2: Follow Instructions from AplazoBackend Repository

Refer to [AplazoBackend Repository](https://github.com/Agm91/AplazoBackend) for additional setup instructions.

### Step 3: Set Up Your Emulator
Make sure you have an emulator set up.

### Step 4: lib/config.dart

Create a file containing:

```sh
class Config {
  static const String apiUrl = 'http://10.0.2.2:8080'; //normally for a emulator
}
```

### Step 5: Run the Flutter Application

Ensure that your emulator is running.

In your terminal, navigate to the root directory of your project.
Run the following command to get the required dependencies:

```sh
flutter pub get
```

Once the dependencies are installed, run the app:

```sh
flutter run
```

To run the tests:

```sh
flutter tests
```

To run the tests with coverage:

```sh
flutter pub global activate test_cov_console
```

You should be able to see an image like:

![Test Coverage](https://github.com/Agm91/Aplazo-app/blob/main/testCoverage.png)

## Video

Functionality [here](https://drive.google.com/drive/folders/1wHZ1NmDKr3DqPVN5ZFT-IOUlbbEOh27C?usp=sharing).

## Considerations

Definitely too much to be done here but I decided to focus on speed. 

 - Improve the Clean arquitecture to make it more testable.
 - Language improvement with dictionary download with online services.
 - Improve UI/UX

## Thank you

I wanted to express my gratitude for letting me participate for the role. I hope we can work together and build great things for millions of people!

**Best!**