## How to Use 

**Step 1:**

Download the source code in your profile => downloads

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

## Generation file

This project uses code generation, execute the following command to generate files:

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

or watch command in order to keep the source code synced automatically:

```
flutter packages pub run build_runner watch
```

## Format code

```
dart format -l 120 lib
```

## Generate Icon
```
flutter pub run flutter_launcher_icons:main
```