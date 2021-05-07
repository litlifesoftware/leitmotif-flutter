import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class LitSignUpScreen extends StatefulWidget {
  final String title;
  final String onSubmitButtonText;
  final List<LitInputArea> inputFields;
  final Duration backgroundAnimationDuration;
  final Duration appearAnimationDuration;
  final void Function(String)? onUsernameChange;
  final void Function(String)? onPasswordChange;
  final void Function(String)? onPasswordConfirmChange;
  final void Function(int?)? onPINChange;
  final void Function() onSubmit;
  const LitSignUpScreen({
    Key? key,
    this.title = 'Sign up',
    required this.onSubmit,
    this.onSubmitButtonText = 'Submit',
    this.inputFields = const [],
    this.backgroundAnimationDuration = const Duration(milliseconds: 3000),
    this.appearAnimationDuration = const Duration(milliseconds: 230),
    this.onUsernameChange,
    this.onPasswordChange,
    this.onPasswordConfirmChange,
    this.onPINChange,
  }) : super(key: key);
  @override
  _LitSignUpScreenState createState() => _LitSignUpScreenState();
}

class _LitSignUpScreenState extends State<LitSignUpScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundArtAnimation;
  late AnimationController _appearAnimation;
  void _unfocus() {
    FocusScope.of(context).unfocus();
  }

  Matrix4 get _backgroundArtTransform {
    final double x = 1.02 - ((1.02 - 0.95) * _backgroundArtAnimation.value);
    final double y = 1.02 - ((1.02 - 0.95) * _backgroundArtAnimation.value);
    final Matrix4 transformMatrix = Matrix4.translationValues(
      0.0 + (50.0 * _backgroundArtAnimation.value),
      -230.0 + (-10 * _backgroundArtAnimation.value),
      0.0,
    );
    return Matrix4.identity()
      ..scale(x, y)
      ..add(transformMatrix);
  }

  @override
  void initState() {
    super.initState();
    _backgroundArtAnimation = AnimationController(
      vsync: this,
      duration: widget.backgroundAnimationDuration,
    );
    _appearAnimation = AnimationController(
      vsync: this,
      duration: widget.appearAnimationDuration,
    );
    _backgroundArtAnimation.repeat(reverse: true);
    _appearAnimation.forward();
  }

  @override
  void dispose() {
    _backgroundArtAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            InkWell(
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: _unfocus,
              child: LitAnimatedGradientBackground(),
            ),
            AnimatedBuilder(
              animation: _appearAnimation,
              builder: (context, _) {
                return AnimatedOpacity(
                  duration: _appearAnimation.duration!,
                  opacity: 0.2 + (0.8 * _appearAnimation.value),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedBuilder(
                          animation: _backgroundArtAnimation,
                          builder: (context, _) {
                            return Transform.rotate(
                              angle: (pi / 180) *
                                  (-15 + (-5 * _backgroundArtAnimation.value)),
                              child: Transform(
                                transform: _backgroundArtTransform,
                                child: SizedBox(
                                  height: 300.0,
                                  width: 500.0,
                                  child: LitGradientCard(
                                    begin: Alignment.bottomRight,
                                    end: Alignment.bottomLeft,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 12.0,
                                        color: Colors.black12,
                                        offset: Offset(
                                          _backgroundArtAnimation.value * -8,
                                          _backgroundArtAnimation.value * 2,
                                        ),
                                        spreadRadius:
                                            _backgroundArtAnimation.value * 3.0,
                                      ),
                                    ],
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(
                                        120.0,
                                      ),
                                      bottomLeft: Radius.circular(
                                        120.0,
                                      ),
                                      topLeft: Radius.circular(
                                        120.0,
                                      ),
                                      topRight: Radius.circular(
                                        120.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 30.0,
                          ),
                          child: Container(
                            height: 220.0,
                            width: 220.0,
                            child: ClippedText(
                              widget.title,
                              maxLines: 3,
                              style: LitTextStyles.sansSerif.copyWith(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                  color: HexColor('#979797'),
                                  letterSpacing: 0.25),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(
                            left: 30.0,
                            right: 30.0,
                            top: 100.0,
                            bottom: 80.0,
                          ),
                          physics: BouncingScrollPhysics(),
                          child: InkWell(
                            onTap: _unfocus,
                            child: LitGradientCard(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24.0)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 30.0,
                                  //horizontal: 15.0,
                                ),
                                child: Builder(
                                  builder: (context) {
                                    final List<Widget> children = [];
                                    for (LitInputArea input
                                        in widget.inputFields) {
                                      children.add(input);
                                      if (children.length <
                                          widget.inputFields.length) {
                                        children.add(LitDivider());
                                      }
                                    }
                                    return Column(
                                      children: children,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0),
                          child: LitPushedThroughButton(
                            borderRadius: 16.0,
                            margin: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 30.0,
                            ),
                            child: Text(
                              widget.onSubmitButtonText.toUpperCase(),
                              style: LitTextStyles.sansSerif.copyWith(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w800,
                                color: HexColor('#8A8A8A'),
                                letterSpacing: 0.8,
                              ),
                            ),
                            onPressed: widget.onSubmit,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LitInputArea extends StatefulWidget {
  final String label;
  final bool initialObsureTextValue;
  final bool allowObscuredText;
  final IconData? icon;
  final Function(String value) onChange;
  const LitInputArea({
    Key? key,
    required this.label,
    this.initialObsureTextValue = false,
    this.allowObscuredText = false,
    this.icon,
    required this.onChange,
  }) : super(key: key);

  @override
  _LitInputAreaState createState() => _LitInputAreaState();
}

class _LitInputAreaState extends State<LitInputArea> {
  final FocusNode _focus = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  String get _textInput {
    return _textEditingController.value.text;
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      widget.onChange(_textInput);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              widget.icon != null
                  ? Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                8.0,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(-2, 2),
                                color: Colors.black26,
                                blurRadius: 4.0,
                                spreadRadius: -2,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              widget.icon,
                              color: LitColors.beigeGrey,
                              size: 17.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                      ],
                    )
                  : SizedBox(),
              Text(
                "${widget.label}".toUpperCase(),
                style: LitTextStyles.sansSerif.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#A9A8A8'),
                  letterSpacing: 0.25,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.06),
                borderRadius: BorderRadius.circular(8.0)),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: EditableText(
                cursorColor: Colors.grey,
                backgroundCursorColor: Colors.black,
                controller: _textEditingController,
                focusNode: _focus,
                textAlign: TextAlign.left,
                cursorRadius: Radius.circular(2.0),
                style: LitTextStyles.sansSerif.copyWith(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  color: HexColor('#444444'),
                  letterSpacing: 1.25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
