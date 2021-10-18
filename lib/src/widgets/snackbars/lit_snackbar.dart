import 'package:flutter/cupertino.dart';
import 'package:leitmotif/leitmotif.dart';

/// A custom snackbar widget.
///
/// The snackbar will resemble a notification which will e.g. be shown on the
/// top right of the device's screen without the need to be shown using the
/// default `showSnackbar` method.
///
/// The default values can be used on its implementations.
abstract class LitSnackbar extends Widget {
  /// The controller providing the show and dismiss logic.
  final LitSnackbarController? controller;

  /// The default alignment is set to `Alignment.topRight`.
  static const Alignment defaultAlignment = Alignment.topRight;

  /// The default height of a snackbar.
  static const double defaultHeight = 80.0;

  /// The default width of a snackbar.
  static const double defaultWidth = 250.0;

  /// [LitSnackbar]s have rounded corners by default.
  static const BorderRadius defaultBorderRadius = const BorderRadius.all(
    Radius.circular(15.0),
  );

  /// The default paddding.
  static const EdgeInsets defaultPadding = const EdgeInsets.symmetric(
    vertical: 8.0,
    horizontal: 8.0,
  );

  /// [LitSnackbar]s have a box shadow by default.
  ///
  /// Keep in mind to avoid boxshadows on transparent [LitSnackbar]
  /// implementations.
  static const List<BoxShadow> defaultBoxShadow = const [
    const BoxShadow(
      blurRadius: 8.0,
      color: const Color(0x42000000),
      offset: const Offset(-3.0, 3.0),
      spreadRadius: -1.0,
    ),
  ];

  /// The default gradient if the snackbar's background should be transparent.
  static const LinearGradient defaultTransparentGradientBackground =
      const LinearGradient(
    colors: const [
      const Color(0x12FFFFFF),
      const Color(0x12FFFFFF),
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: const [0.2, 0.7],
  );

  /// The default gradient if the snackbar's background should be solid.
  static const LinearGradient defaultSolidGradientBackground =
      const LinearGradient(
    colors: const [
      const Color(0xFFFFFFFF),
      const Color(0xFFF8F8F8),
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: const [0.2, 0.7],
  );

  /// Creates a [LitSnackbar].
  ///
  /// Keep in mind, that the [LitSnackbar] is an abstract class and can't be
  /// constructed as a widget. The constructor will describe that the
  /// controller should be provided as a contructor argument on its
  /// implementations.
  const LitSnackbar({required this.controller});
}
