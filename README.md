# Medicine App

## **Developer(s):**

- Chiekko Red

# Architecture

**`MVVM + Provider` - Model View View Models + Provider**

# Getting Started

- _*First install or upgrade to the latest version of Flutter. Follow these installation* [*guides* ](https://flutter.dev/docs/get-started/install)_

In this tutorial, it is recommended to use Android Studio as you code editor, which can be downloaded [here](https://developer.android.com/studio/?gclid=CjwKCAjwq_D7BRADEiwAVMDdHjI_Lu5xR1whSMHH-WDMO3x6WDQVbBcZxbhN9h6m9SsT6b_wjmuKkhoCbSwQAvD_BwE&gclsrc=aw.ds). You can also use [VSCode](https://docs.flutter.dev/get-started/editor?tab=vscode) to build, compile, and deploy with ease. To complete the iOS deployment steps you will also need to have [Xcode](https://developer.apple.com/xcode/) installed. The last piece you will need to set up before beginning this project is the set up of an [iOS simulator](https://flutter.dev/docs/get-started/install/macos#set-up-the-ios-simulator) as well as an [Android emulator](https://flutter.dev/docs/get-started/install/macos#set-up-the-android-emulator). Once these sets have been completed you are ready to start working with the project!

## Create new directory

Directory folders are already arranged based on its purpose. So make sure to follow and insert your new directory or files on its designated path.

```
assets
 └── fonts
 └── images
 └── svg
lib
 └── core
      └── extensions
      └── models
      └── providers
      └── viewmodels
      └── services
 └── utilities
      └── configs
      └── constants
      └── helpers
 └── views
      └── commons
      └── screens
```

## Create new files inside a directory

`<filename>_<type>.dart`

_example:_

```
sample_model.dart
```

When naming a file, all characters must be in lowercase and separate filename and type with an <span style="color:red;">underscore (\_) </span>. File naming must be in <span style="color:red;"> snake case </span> and to be strictly followed to avoid future conflicts.

## Naming a class

`class <Classname><Type> {}`

_example:_

```
class SampleModel {}
class LoginScreen {}
```

In naming a class, both class name and type must be present. We will use <span style="color:red;"> pascal case </span> to delineate the class name.

## Naming a function

`<return callback> <function name>() {}`

_example:_

```
void sampleFunction() {}
```

Naming a function needs to be in <span style="color:red;"> camel case </span> to be easily used inside a class.

## Naming a variable

`<datatype> <variablename>`

_example:_

```
String testSample;
String _privateTestSample
```

Variable naming must strictly use <span style="color:red;"> camel case </span>. If a variable is private, add an underscore before the name to identify its independency.

## Quoting a String

We will use <span style="color:red;">two quotes</span> in defining a String value;

_example:_

```
String sample = "This is a string";
```

## Comments

Functions must be created with comments.

_example:_

```
/// <Short Descriptive Function Definition>
///
/// `text` <Usage Description>
/// `image` <Usage Description>
void SampleFunction (String text, String image) {}
```

If a code block needs to be explained, consider using // in commenting a short and precised explanation above the code.

_example:_

```
// Get date and time now for timestamp
DateTime now = new DateTime.now();
```

Reference Dart comments here: [Dart Comment Guides](https://dart.dev/guides/language/effective-dart/documentation)

# Directories

## `assets`

Asset files that includes external files.

## `assets/fonts`

Custom imported fonts directory.

## `assets/images`

Custom imported images directory.

## `assets/svg`

Custom imported SVG files directory.

## `lib/core`

Core files that completes the **MVVM Architecture**.

## `lib/core/extensions`

Extending data type methods are created here.

## `lib/core/models`

Data model class are created here.

## `lib/core/providers`

Provider class with ChangeNotifiers are created here.

## `lib/core/viewmodels`

View Model class are created here.

## `lib/core/viewmodels`

This contains functions that fetch from API.

## `lib/utilities`

Utilities such as app configurations for backend and app constants like colors, fonts and icons.

## `lib/utilities/configs`

App Configurations are gathered here for backend and API purposes.

## `lib/utilities/constants`

App constants like color scheme, theming, font styles and other constant values are gathered here.

## `lib/utilities/helpers`

Functions that are reusable in calculating or modifying data are created here.

## `lib/views`

Screens, pages and custom widgets are created here for UI.

## `lib/view/commons`

Reusable and custom widgets are created here.

## `lib/view/screens`

Pages and screen navigations are created here for rendering UI.
