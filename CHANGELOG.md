## 2.1.2

- Fix missing `AnimationController` dispose call on `LitToggleButton`

## 2.1.1

- Allow alternative navigation using `tapToNavigate` on `IndexedPageView`

## 2.1.0
- Add `FilePathPreview`
- Adjust styling on `LitBackButton`
- Apply mini library concept on `widgets` library
- Remove part directive
- See https://dart.dev/guides/libraries/create-library-packages

## 2.0.3
- Improve gradient background on `LitUserIcon`
- Improve color contrast on `LitDeleteButton`
- Improve styling on `CollapseOnScrollActionButton`
- Change text styles on `DiscardDraftDialog` and `ConfirmDeleteDialog`

## 2.0.2
- Add `ConfirmDeleteDialog`, a dialog widget to confirm a delete action.
- Add additional localizations.
- Refactor a variety of widgets and classes.

## 2.0.1

- Add `LitDeleteButton`, a red-themed button to delete content.
- Fix stack overflow previously occuring on the `LitNavigationButton`.
- Standardize spacings on several widgets.

## 2.0.0

- Implement `LeitmotifLocalizations` to provide localized strings by default.
- Add `LitSettingCard` to toggle values.
- Relabel `LitColors` using utility labels.
- Replace the `VT323` monospace font with `CourierPrime`
- Implement updated design and API on several screens and widgets.
- Refactor several libraries.
- Remove deprecated widgets.

## 1.4.3

- Add `formatAsLocalizedDateTime` on `LocalizedDateTime` extension.
- Create `titles` library.
- Add `LitScreenTitle` and `LitCardTitle` widgets to `titles` library.
- Add `LitTitledActionCard`.
- Improve scale animation on `LitPushedThroughButton`.
- Improve button sizing on `LitCalendarNavigation`.
- Add `displayBackButton` option to hide and display navigation buttons on 'fixed on scroll' app bars.
- Add `LitDescriptionTextBox`, a Flutter widget displaying an `Icon` alongside the provided description.
- Add `LitGradients` library.

## 1.4.2

- Migrated from the deprecated package_info plugin to package_info_plus (provided by [lscbot](https://lscbot.com/)).
- Add support for Windows and Linux platforms.

## 1.4.1

- Fix missing clipping on `LitBottomNavigation`.
- Fix layout issues on `DiscardDraftDialog`.
- Fix padding issues on `LitCreditsScreen`.
- Decrease default width on `LitScrollbar`.
- Fix unnecessary safe area on `LitScaffold` when using `FixedOnScrollAppbar`.
- Add a `blurred` option on `CollapseOnScrollActionButton` and `LitGradientButton`.

## 1.4.0

- Replace the `child` member with a simple `title` member on `FixedOnScrollAppbar`.
- Add a `gradientColors` member on `LitFooter` to customize its background gradient.
- Add a `contrastColor` member on `LitUserIcon` to customize its background gradient.
- Rename `lit_ui_kit` package to `leitmotif`.
- Add `FixedOnScrollTitledAppbar`.
- Revert changes on `FixedOnScrollAppbar` to accept a `child` property.
- Refactor and document `LitDraggable`.
- Decrease `LitBackButton` default width to avoid overflow.

## 1.3.0

- Rename `AboutAppDialog` to `LitAboutDialog`.
- Add `LitInfoIcon` to `art` library.
- Add `LitStaticLoadingScreen` to `screens` library.
- Improve error handling when calling `dispose` on several custom controller classes.
- Update `LitSansSerifStyles` type system according to `Material Design` Guidelines ([https://material.io/design/typography/the-type-system.html#type-scale](https://material.io/design/typography/the-type-system.html#type-scale)).
- Add customizable `initialTabIndex` and `transitionListener` members on `LitTabView`.

## 1.2.0

- Fix overflow on `LitPrivacyPolicyScreen`.
- Allow custom padding on `LitOnboardingScreen`.
- Add `LitTextPageView` widget to display a list of cards using a transition animation.
- Add `LitPrivacyDisclaimerScreen`.
- Add `LitBoxShadows`, a collection of styled box shadows.
- Rename `ConfirmAgeScreen` to `LitConfirmAgeScreen`.
- Remove `url_launcher` dependency.

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
