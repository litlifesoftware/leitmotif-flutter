import 'package:flutter/material.dart';
import 'package:lit_ui_kit/buttons.dart';
import 'package:lit_ui_kit/dialogs.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';
import 'package:lit_ui_kit/slider.dart';
import 'package:lit_ui_kit/styles.dart';

/// A dialog widget allowing to edit and create [Color] objects.
///
/// Each color channel will have its own slider.
class LitColorPickerDialog extends StatefulWidget {
  /// Creates a [LitColorPickerDialog].
  const LitColorPickerDialog({
    Key? key,
    this.titleText = "Pick a color",
    this.transparentColorText = "Color is fully transparent",
    this.resetLabel = "reset",
    this.applyLabel = "apply",
    this.initialColor = const Color(0x00000000),
    required this.onApplyColor,
  }) : super(key: key);

  /// The dialog's title text.
  final String titleText;

  /// The text display whenever the currently edited color is fully transparent.
  final String transparentColorText;

  /// The text label on the 'reset' button.
  final String resetLabel;

  /// The text label on the 'apply' button.
  final String applyLabel;

  /// The initial slider values provided as a [Color] object.
  final Color initialColor;

  /// The callback to method to pass the edited [Color] back onto the parent
  /// widget.
  final void Function(Color) onApplyColor;

  @override
  _LitColorPickerDialogState createState() => _LitColorPickerDialogState();
}

class _LitColorPickerDialogState extends State<LitColorPickerDialog>
    with TickerProviderStateMixin {
  /// The controller handling the initial 'appear' animation.
  late AnimationController _appearAnmCon;

  /// The controller handling the slider animation.
  late AnimationController _sliderAnmCon;

  /// The alpha channel value.
  late int a;

  /// The red channel value.
  late int r;

  /// The green chnnel value.
  late int g;

  /// The blue channel value.
  late int b;

  /// Returns a [Color] object based on the current channel state values.
  Color get _currentColor {
    return Color.fromARGB(a, r, g, b);
  }

  /// Returns the current [_appearAnmCon]'s animation value.
  double get _appearAnmVal {
    return _appearAnmCon.value;
  }

  /// Sets the [a] value.
  void _onAChange(double v) {
    setState(() {
      a = v.round();
    });
  }

  /// Sets the [r] value.
  void _onRChange(double v) {
    setState(() {
      r = v.round();
    });
  }

  /// Sets the [g] value.
  void _onGChange(double v) {
    setState(() {
      g = v.round();
    });
  }

  /// Sets the [b] value.
  void _onBChange(double v) {
    setState(() {
      b = v.round();
    });
  }

  /// Resets all color channel state values.
  void _onReset() {
    _sliderAnmCon
        .reverse(from: 1.0)
        .then((_) => setState(() {
              a = 0;
              r = 0;
              g = 0;
              b = 0;
            }))
        .then(
          (__) => _sliderAnmCon.forward(),
        );
  }

  /// Handles the 'apply' action by calling the provided callback.
  void _handleOnApply() {
    widget.onApplyColor(_currentColor);
    LitRouteController(context).closeDialog();
  }

  @override
  void initState() {
    super.initState();
    // Set the initial color channel values.
    a = widget.initialColor.alpha;
    r = widget.initialColor.red;
    g = widget.initialColor.green;
    b = widget.initialColor.blue;
    // Initialize the animation controllers.
    _appearAnmCon = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _sliderAnmCon = AnimationController(
      duration: Duration(milliseconds: 130),
      vsync: this,
    );
    // Play the inital animations.
    _appearAnmCon.forward();
    _sliderAnmCon.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LitTitledDialog(
      titleText: widget.titleText,
      actionButtons: [
        DialogActionButton(
          backgroundColor: LitColors.mediumGrey,
          style: LitSansSerifStyles.button.copyWith(
            color: Colors.white,
          ),
          onPressed: _onReset,
          label: widget.resetLabel,
        ),
        DialogActionButton(
          onPressed: _handleOnApply,
          label: widget.applyLabel,
        )
      ],
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: AnimatedBuilder(
        animation: _appearAnmCon,
        builder: (BuildContext context, Widget? _) {
          return AnimatedOpacity(
            duration: _appearAnmCon.duration!,
            opacity: 0.5 + (_appearAnmVal * 0.5),
            child: Column(
              children: [
                _ColorMixer(
                  a: a,
                  animationController: _sliderAnmCon,
                  b: b,
                  g: g,
                  onAChange: _onAChange,
                  onBChange: _onBChange,
                  onGChange: _onGChange,
                  onRChange: _onRChange,
                  r: r,
                ),
                _ValIndicator(
                  a: a,
                  b: b,
                  g: g,
                  r: r,
                  trnColorText: widget.transparentColorText,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// A widget combining all color channel sliders.
class _ColorMixer extends StatelessWidget {
  /// Creates a [_ColorMixer].
  const _ColorMixer({
    Key? key,
    required this.a,
    required this.r,
    required this.g,
    required this.b,
    required this.onAChange,
    required this.onRChange,
    required this.onGChange,
    required this.onBChange,
    required this.animationController,
  }) : super(key: key);
  final int a;
  final int r;
  final int g;
  final int b;
  final void Function(double) onAChange;
  final void Function(double) onRChange;
  final void Function(double) onGChange;
  final void Function(double) onBChange;
  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ColorSlider(
                    color: Colors.grey,
                    val: (animationController!.value * a).round(),
                    onChange: onAChange,
                  ),
                  _ColorSlider(
                    color: Colors.red,
                    val: (animationController!.value * r).round(),
                    onChange: onRChange,
                  ),
                  _ColorSlider(
                    color: Colors.green,
                    val: (animationController!.value * g).round(),
                    onChange: onGChange,
                  ),
                  _ColorSlider(
                    color: Colors.blue,
                    val: (animationController!.value * b).round(),
                    onChange: onBChange,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

/// A widgets displaying the current color state as a colored container.
class _ValIndicator extends StatelessWidget {
  /// Creates a [_ValIndicator].
  const _ValIndicator({
    Key? key,
    required this.a,
    required this.r,
    required this.g,
    required this.b,
    required this.trnColorText,
  }) : super(key: key);
  final int a;
  final int r;
  final int g;
  final int b;
  final String trnColorText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8.0,
        ),
        child: Stack(
          children: [
            Container(
              height: 32.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    12.0,
                  ),
                ),
                color: Color.fromARGB(
                  a,
                  r,
                  g,
                  b,
                ),
              ),
            ),
            // Display a message whenever the color is fully transparent
            a == 0
                ? Transform(
                    transform: Matrix4.translationValues(0, 0, 0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: BluredBackgroundContainer(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            12.0,
                          ),
                        ),
                        blurRadius: 2.0,
                        child: Container(
                          height: 32.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(11.0),
                            ),
                            color: Colors.black.withAlpha(16),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                trnColorText,
                                style: LitSansSerifStyles.overline,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}

/// A widget allowing to set a specific color channel value based on the
/// boundaries of each channel (0-255/);
class _ColorSlider extends StatelessWidget {
  /// Creates a [_ColorSlider].
  const _ColorSlider({
    Key? key,
    required this.color,
    required this.val,
    required this.onChange,
    this.margin = const EdgeInsets.symmetric(
      vertical: 4.0,
    ),
  }) : super(key: key);
  final Color color;
  final int val;
  final void Function(double) onChange;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Column(
        children: [
          LitSlider(
            min: 0,
            max: 255,
            onChanged: onChange,
            value: val.toDouble(),
            displayRangeBadges: false,
            displayValue: false,
            activeTrackColor: color,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Container(
                height: 8.0,
                width: 8.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      4.0,
                    ),
                  ),
                  color: color,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
