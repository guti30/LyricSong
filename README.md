# lyrics_song

A  application for search lyrics songs.

## Getting Started

This project is a starting point for a Flutter application.



## Command Line Commands For Running the app

Compile only in an Android device or Android simulator
### For Android
1. Run the command flutter pub get to get all the dependencies of the proyect
2. Run the command below to get the list of devices you have available to run the app. Here you would be able to see all the personal devices connected to your PC or simulators you have started at the moment to run this command:
```
flutter devices
```
Command Response:
```
1 connected devices:

sdk gphone x86 • emulator-5554                        • android-x86 • Android 11 (API 30) (emulator)
```
Where in the example below the ```sdk gphone x86 • emulator-5554 ```  are the device Id available
3. Run the command below using any of the ids listed by the step before:
```
flutter run -t lib/main_dev.dart -d sdk gphone x86 • emulator-5554
```
4. if you get this error Gradle does not have execution permission, run the command chmod a+rx android/gradlew and try again the step 3
