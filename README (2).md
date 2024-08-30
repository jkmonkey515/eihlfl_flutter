# EIHLFL

## Project Setup

> Download the .env file from the "Deliverables"...
> Add .env file

### Install Flutter Project

> CD into the project directory
> Run `flutter clean` in Terminal
> Run `flutter pub get` in Terminal

Select a device to run the app on

> Run `flutter run`

NOTE: for Mac Arm64 chip users, in order to install the pods you may have to:

> Navigate to the iOS directory
> Run `sudo arch -x86_64 gem install ffi`
> Run `arch -x86_64 pod install`

### Build the Flutter Project for Android

Run the aforementioned setup commands for "Installing Flutter project"

> Run `flutter build apk --release`

Note: Depending on the Firebase compilation / updates, you may have to:

> Manually update com.google.gms:google-service to version "4.3.14" in the AndroidManifest.xml

## Project Structure

### Project Design Approach

Due to a mix of developers and time constraints, there is a current mix of the Bloc architecture with GetX State Management and a rudimentary MVVC architecture using vanilla Flutter State Management.

The developer recommends that at a future time, the entire project is migrarted to use a singular State Management and architecture.

Most likely, the best approach will be to migrate the vanilla Flutter State Management to the Bloc architecture in order to maintain a seperation of concerns and seperate view / controll logic.
