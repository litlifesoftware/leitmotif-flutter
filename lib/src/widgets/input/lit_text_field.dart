import 'package:flutter/material.dart';
import 'package:leitmotif/localization.dart';
import 'package:leitmotif/styles.dart';
import 'package:leitmotif/models.dart';
import 'package:leitmotif/utility.dart';

/// A Leitmotif `input` widget allowing to let the user input string values.
class LitTextField extends StatefulWidget {
  /// The data object containing values required to build the field.
  final TextFieldData data;

  /// The field's border radius.
  final BorderRadius borderRadius;

  /// The inputted text's margin.
  final EdgeInsets margin;

  final Duration animationDuration;

  /// Creates a [LitTextField].
  const LitTextField({
    Key? key,
    required this.data,
    this.borderRadius = LitBorderRadius.button,
    this.margin = LitEdgeInsets.button,
    this.animationDuration = LitAnimationDurations.button,
  }) : super(key: key);

  @override
  _LitInputAreaState createState() => _LitInputAreaState();
}

class _LitInputAreaState extends State<LitTextField>
    with TickerProviderStateMixin {
  bool _valid = true;
  final FocusNode _focus = FocusNode();
  final TextEditingController _controller = TextEditingController();
  late AnimationController _animationContrField;
  late AnimationController _animationContrHint;

  TextFieldData get _data => widget.data;

  /// Returns the current text input.
  String get _textInput => _controller.value.text;

  /// Adds an `onChange` listeners on the text editing controller and focus
  /// node to update the parent's state and to play the animation.
  void _registerListeners() {
    _controller.addListener(() {
      _data.onChange(_textInput);
      if (_hintEnabled) {
        // Validation result
        bool result = _data.onValidate!(_textInput);
        if (!result && _valid) _animationContrHint.forward(from: 0.0);

        if (result && !_valid) _animationContrHint.reverse(from: 1.0);

        setState(() {
          _valid = result;
        });

        print("valid: " + _valid.toString());
      }
    });
    _focus.addListener(() {
      if (_focus.hasFocus) {
        _animationContrField.forward(from: 0.0);
      } else {
        _animationContrField.reverse(from: 1.0);
      }
    });
  }

  /// Handles the `onSubmit` action.
  void _onSubmitted(String _textInput) {
    if (_valid) {
      if (_submitEnabled) _data.onSubmitted!(_textInput);
    } else {
      _animationContrHint
          .reverse(
            from: 1.0,
          )
          .then(
            (_) => _animationContrHint.forward(
              from: 0.0,
            ),
          );
    }
  }

  bool get _submitEnabled => _data.onSubmitted != null;

  bool get _hintEnabled => _data.onValidate != null;

  @override
  void initState() {
    _registerListeners();
    _animationContrField = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..forward();

    _animationContrHint = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.animationDuration.inMilliseconds ~/ 2,
      ),
    )..forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationContrField.dispose();
    if (_hintEnabled) {
      _animationContrHint.dispose();
    }
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InputLabel(data: _data),
        SizedBox(height: widget.margin.vertical),
        _Input(
          borderRadius: widget.borderRadius,
          controller: _controller,
          focus: _focus,
          margin: widget.margin,
          obscureText: _data.obscureText,
          animationController: _animationContrField,
          onSubmitted: _onSubmitted,
        ),
        _hintEnabled
            ? _HintText(
                animationController: _animationContrHint,
                text: _data.invalidHint,
                valid: _valid,
                focus: _focus,
              )
            : SizedBox(),
      ],
    );
  }
}

/// The text field's label.
class _InputLabel extends StatelessWidget {
  final TextFieldData data;
  const _InputLabel({
    Key? key,
    required this.data,
  }) : super(key: key);

  bool get _iconEnabled => data.icon != null;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _iconEnabled
            ? _Icon(
                icon: data.icon!,
              )
            : SizedBox(),
        Text(
          data.label.capitalize(),
          style: LitSansSerifStyles.subtitle2,
        ),
      ],
    );
  }
}

class _HintText extends StatelessWidget {
  final AnimationController animationController;
  final FocusNode focus;
  final String? text;
  final bool valid;
  const _HintText({
    Key? key,
    required this.animationController,
    required this.focus,
    required this.text,
    required this.valid,
  }) : super(key: key);

  static const _invalidColor = LitColors.red700;

  double get _opacity => animationController.value;

  Matrix4 get _transform {
    final offset = 4.0;
    return Matrix4.translationValues(
      0,
      offset + -offset * animationController.value,
      0,
    );
  }

  double get _placeholderHeight {
    return (animationController.isAnimating && focus.hasFocus)
        ? animationController.value * 8.0
        : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          text ?? LeitmotifLocalizations.of(context).invalidInputBody,
          style: LitSansSerifStyles.overline.copyWith(
            color: _invalidColor,
            //fontSize: _fontSize,
          ),
        ),
      ),
      builder: (context, child) {
        return AnimatedOpacity(
          duration: animationController.duration!,
          opacity: _opacity,
          child: !valid
              ? Transform(
                  transform: _transform,
                  child: child,
                )
              : SizedBox(
                  height: _placeholderHeight,
                ),
        );
      },
    );
  }
}

class _Input extends StatelessWidget {
  final TextEditingController controller;
  final AnimationController animationController;
  final BorderRadius borderRadius;
  final EdgeInsets margin;
  final FocusNode focus;
  final bool obscureText;
  final void Function(String) onSubmitted;
  const _Input({
    Key? key,
    required this.controller,
    required this.animationController,
    required this.borderRadius,
    required this.margin,
    required this.focus,
    required this.obscureText,
    required this.onSubmitted,
  }) : super(key: key);

  Color get _color {
    final base = LitColors.grey150;
    final highlight = Color.lerp(
      LitColors.grey150,
      LitColors.grey100,
      animationController.value,
    )!;
    return focus.hasFocus ? highlight : base;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: Padding(
        padding: margin,
        child: EditableText(
          cursorColor: LitColors.green500,
          backgroundCursorColor: Colors.transparent,
          controller: controller,
          focusNode: focus,
          textAlign: TextAlign.left,
          cursorRadius: Radius.circular(2.0),
          style: LitSansSerifStyles.subtitle1,
          obscureText: obscureText,
          onSubmitted: onSubmitted,
        ),
      ),
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: _color,
            borderRadius: borderRadius,
          ),
          child: child,
        );
      },
    );
  }
}

class _Icon extends StatelessWidget {
  final IconData icon;
  final double size;
  final EdgeInsets margin;
  const _Icon({
    Key? key,
    required this.icon,
    this.size = 14.0,
    this.margin = const EdgeInsets.all(8.0),
  }) : super(key: key);

  static const BoxDecoration backgroundDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.all(
      Radius.circular(
        12.0,
      ),
    ),
    boxShadow: LitBoxShadows.sm,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: backgroundDecoration,
          child: Padding(
            padding: margin,
            child: Icon(
              icon,
              color: LitColors.grey380,
              size: size,
            ),
          ),
        ),
        SizedBox(width: margin.left + margin.right),
      ],
    );
  }
}
