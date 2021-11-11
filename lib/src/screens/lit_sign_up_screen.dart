import 'dart:math';
import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// The [LitSignUpScreen]'s `Localization`.
///
/// Contains the localized strings used on the screen.
class LitSignUpScreenLocalization {
  final String title;
  final String submitLabel;

  /// Creates a [LitSignUpScreenLocalization].
  const LitSignUpScreenLocalization({
    required this.title,
    required this.submitLabel,
  });
}

/// A screen widget allowing the user to submit his core data.
///
/// The mutation of the user edited text on the text fields are handled by
/// `onChange` methods found on the provided [LitTextField] instances.
class LitSignUpScreen extends StatefulWidget {
  final LitSignUpScreenLocalization? localization;

  /// A [List] of [LitTextField]s used for handling the user input.
  ///
  /// The field data objects provide callbacks to set the parent's state and
  /// to receive the user input.
  final List<TextFieldData> data;

  /// States whether the user input has passed the validation. If not, the
  /// `onSubmit` callback is not executed.
  ///
  /// Validation must be performed on the parent state.
  final bool? inputValid;

  /// Handles the `submit` action.
  ///
  /// Additional input validation should be handled on the callback function.
  final void Function() onSubmit;

  /// Creates a [LitSignUpScreen].
  const LitSignUpScreen({
    Key? key,
    this.localization,
    this.data = const [],
    this.inputValid,
    required this.onSubmit,
  }) : super(key: key);

  /// The duration of the background animation.
  static const Duration bgAnimationDuration = const Duration(
    milliseconds: 3000,
  );

  @override
  _LitSignUpScreenState createState() => _LitSignUpScreenState();
}

class _LitSignUpScreenState extends State<LitSignUpScreen>
    with TickerProviderStateMixin {
  /// The background animation.
  late AnimationController _animationControllerBg;

  // /// The appear animation.
  // late AnimationController _animationControllerShort;

  /// Evaluates whether localizations are provided.
  bool get _l10nAvail => widget.localization != null;

  /// Handles the `submit` action.
  void _onSubmit() {
    Future.delayed(LitAnimationDurations.button).then(
      (_) {
        widget.onSubmit();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _animationControllerBg = AnimationController(
      vsync: this,
      duration: LitSignUpScreen.bgAnimationDuration,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationControllerBg.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
      appBar: LitAppBar(
        title: _l10nAvail
            ? widget.localization!.title
            : LeitmotifLocalizations.of(context).signUpLabel,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            LitAnimatedGradientBackground(),
            Stack(
              children: [
                _AnimatedGeometry(
                  animationController: _animationControllerBg,
                ),
                ScrollableColumn(
                  children: [
                    SizedBox(
                      height: _AnimatedGeometry.height / 2.5,
                    ),
                    Center(
                      child: _Form(
                        data: widget.data,
                        l10nAvail: _l10nAvail,
                        localization: widget.localization,
                        inputValid: widget.inputValid,
                        onSubmit: _onSubmit,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A animated geometry displayed on the [LitSignUpScreen].
class _AnimatedGeometry extends StatelessWidget {
  final AnimationController animationController;

  const _AnimatedGeometry({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  /// Returns the background art's transformation which will be depended on the
  /// current animation value.
  Matrix4 get _backgroundArtTransform {
    final double x = 1.0 - ((1.0 - 0.90) * animationController.value);
    final double y = 1.0 - ((1.0 - 0.90) * animationController.value);
    final Matrix4 transformMatrix = Matrix4.translationValues(
      0.0 + (60.0 * animationController.value),
      -height + (-10 * animationController.value),
      0.0,
    );
    return Matrix4.identity()
      ..scale(x, y)
      ..add(transformMatrix);
  }

  double get _angle => (pi / 180) * (-15 + (-5 * animationController.value));

  static const height = 300.0;
  static const width = 500.0;
  static const borderRadius = const BorderRadius.all(
    Radius.circular(
      120.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          return Transform.rotate(
            angle: _angle,
            child: Transform(
              transform: _backgroundArtTransform,
              child: BluredBackgroundContainer(
                blurRadius: 2.0,
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: borderRadius,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// The sign up form containing text input elements.
class _Form extends StatelessWidget {
  final LitSignUpScreenLocalization? localization;
  final bool l10nAvail;
  final List<TextFieldData> data;
  final bool? inputValid;
  final void Function() onSubmit;
  const _Form({
    Key? key,
    required this.localization,
    required this.l10nAvail,
    required this.data,
    required this.inputValid,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: LitForm(
        submitLabel: l10nAvail
            ? localization!.title
            : LeitmotifLocalizations.of(context).submitLabel,
        data: data,
        inputValid: inputValid,
        onSubmit: onSubmit,
      ),
    );
  }
}
