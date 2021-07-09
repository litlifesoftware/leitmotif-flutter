## 1.2.0

- Fix overflow on `LitPrivacyPolicyScreen`.
- Allow custom padding on `LitOnboardingScreen`.

## 1.1.0

- Move `LitSliderCard` to `slider` library.
- Add `LitColorPickerDialog` to edit and create `Color` objects.
- Alter `LitSlider`'s default styling.
- Fix unclean box shadow rendering on `LitSliderThumb`.
- Make `ConfirmAgeScreen` return the submitted date using a callback method.
- Add `addListener` member on `LitSettingsPanelController` to call custom callbacks on each action.
- Add optional `hide` flag on `LitBottomNavigation` to hide the `LitBottomNavigation` if needed.
- Add `addListener` member on `LitSnackbarController` to call custom callbacks on each action.
- Replace `Column` with `Stack` to display grouped notifications on `LitNotificationContainer`.
- Add customization options on `LitBottomNavigation`.
- Add `LitUserIcon` to display the username as an acronym on a colored background.
- Alter default styling on `LitSlider` and `LitSliderCard`.
- Add `LitSettingsFooter` to implement a minimalist settings section.
- Constrain `LitFooter`'s width on landscape mode.

## 1.0.5

- Shorten the pubspec.yaml description's length to increase the pub score.
- Add animation and adjust styling on LitLockIcon.
- Refactor the ApplicationLicensesScreen.
- Add styling members to app bar widgets.
- Add `nextButtonLabel` member on `LitOnboardingScreen`.
- Make labels uppercase on `LitPrivacyScreen`.
- Add opacity animation on `LitSnackbar` widgets.
- Add alternative animation behavior (`SnackbarAnimationType`) on `LitSnackbarController`.
- Refactor `LitCreditsScreen` and adjust default styling.
- Add `DialogActionButton`, a button primarily designed to be used on the `LitTitledDialog`.
- Constrain the action buttons on `LitTitledDialog`.
- Alter button styling on `LitDatePicker`.
- Alter `LitCreditsScreen`'s back button color.
- Add `resizeToAvoidBottomInset` member on `LitTabView` to enforce overlapping according to [Material Design's guidelines](https://material.io/components/app-bars-bottom#behavior).
- Implement `DialogActionButton` on `DiscardDraftDialog`.

## 1.0.4

- Remove `CustomInfoBar`, `DummyInfoBar` and `TransparentInfoBar`. Please use the existing `LitSnackbar` widgets to display feedback messages.
- Replace the default `SlidingSnackbar` with the `LitBaseSnackbar`, which implements a solid background decoration.
- Add `LitTransparentSnackbar` to resemble the previous `SlidingSnackbar`'s decoration.
- Add `LitTransparentIconSnackbar` to resemble the previous `LitIconSnackbar`'s decoration.
- Unify the `LitSnackbarController` member variable naming on all `LitSnackbar` widgets.
- Add missing documentation on `LitSnackbar` widgets.
- Extract the sans serif styles on `LitTextStyles` into seperate `LitSansSerifStyles` class.
- Extract the serif styles on `LitTextStyles` into seperate `LitSerifStyles` class.
- Add `upperCase` member on text widgets for easier text formatting on button labels.
- Refactor `Example` app's homescreen to fit on the `main.dart` file.
- Update Readme's image assets using new logo design and screenshots.

## 1.0.3

- Reorganize source code by creating independent sub libraries
- Adjust default styling on several widgets
- Add an alternative way to use the sans serif `TextStyle` classes by accessing a `List` using a style identifier
- Reimplement the `LitOnboardingScreen` and add interactive animations
- Reimplement the `ConfirmAgeScreen` using the `LitDatePickerDialog` to handle user input
- Add the `LitStartupScreen`, a screen widget showing the app creator's logo and name on the first app startup
- Replace the `LitRoundedOutlinedButton` widgets on the Example app using `LitRoundedElevatedButton` widgets
- Add utitity functions using extensions on default classes
- Update the `package_info` package to `^2.0.2`
- Update the `url_launcher` package to `^6.0.4`

## 1.0.2

- Migrate to null safety

## 1.0.1

- Add several new widgets and screens
- Fix several bugs and glitches

## 1.0.0

- Initial release
- LitUIKit - LitUIKit enables you to create unique user interfaces in less time.
