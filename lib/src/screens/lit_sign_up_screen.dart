import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class LitSignUpScreen extends StatefulWidget {
  final String title;
  final void Function() onSubmit;
  final bool showUsernameInput;
  final bool showPasswordInput;
  final bool showPasswordConfirmInput;
  final bool showPinInput;
  final String usernameLabel;
  final String passwordLabel;
  final String passwordConfirmLabel;
  final String pinLabel;
  final String onSubmitButtonText;
  final void Function(String)? onUsernameChange;
  final void Function(String)? onPasswordChange;
  final void Function(String)? onPasswordConfirmChange;
  final void Function(int?)? onPINChange;
  const LitSignUpScreen({
    Key? key,
    this.title = 'Sign up',
    required this.onSubmit,
    this.showUsernameInput = true,
    this.showPasswordInput = true,
    this.showPasswordConfirmInput = true,
    this.showPinInput = true,
    this.usernameLabel = 'Username',
    this.passwordLabel = 'Password',
    this.passwordConfirmLabel = 'Confirm Password',
    this.pinLabel = 'PIN',
    this.onSubmitButtonText = 'Submit',
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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordConfirmFocus = FocusNode();
  final FocusNode _pinFocus = FocusNode();
  late AnimationController _animationController;

  String get _usernameText {
    return _usernameController.value.text;
  }

  String get _passwordText {
    return _passwordController.value.text;
  }

  String get _passwordConfirmText {
    return _passwordConfirmController.value.text;
  }

  int? get _pinValue {
    return int.tryParse(_pinController.value.text);
  }

  void _unfocus() {
    FocusScope.of(context).unfocus();
  }

  Matrix4 get _backgroundArtTransform {
    final double _x = 1.02 - ((1.02 - 0.95) * _animationController.value);
    final double _y = 1.02 - ((1.02 - 0.95) * _animationController.value);
    return Matrix4.identity()
      ..scale(_x, _y)
      ..add(
        Matrix4.translationValues(0.0 + (50.0 * _animationController.value),
            -230.0 + (-10 * _animationController.value), 0.0),
      );
    // return Matrix4.translationValues(
    //   15.0 + (15.0 * _animationController.value),
    //   -115.0 + (-10 * _animationController.value),
    //   0.0,
    // );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 3000,
      ),
    );
    _animationController.repeat(reverse: true);
    if (widget.onUsernameChange != null) {
      _usernameController.addListener(() {
        widget.onUsernameChange!(_usernameText);
      });
    }
    if (widget.onPasswordChange != null) {
      _passwordController.addListener(() {
        widget.onPasswordChange!(_passwordText);
      });
    }
    if (widget.onPasswordConfirmChange != null) {
      _passwordConfirmController.addListener(() {
        widget.onPasswordConfirmChange!(_passwordConfirmText);
      });
    }
    if (widget.onPINChange != null) {
      _pinController.addListener(() {
        widget.onPINChange!(_pinValue);
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
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
            Align(
              alignment: Alignment.topLeft,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, _) {
                  return Transform.rotate(
                    angle:
                        (pi / 180) * (-15 + (-5 * _animationController.value)),
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
                                _animationController.value * -8,
                                _animationController.value * 2,
                              ),
                              spreadRadius: _animationController.value * 3.0,
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
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30.0,
                        horizontal: 15.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            children: [
                              widget.showUsernameInput
                                  ? LitInputArea(
                                      textEditingController:
                                          _usernameController,
                                      focusNode: _usernameFocus,
                                      label: widget.usernameLabel,
                                      icon: LitIcons.person_solid,
                                    )
                                  : SizedBox(),
                              widget.showPasswordInput
                                  ? LitInputArea(
                                      textEditingController:
                                          _passwordController,
                                      focusNode: _passwordFocus,
                                      label: widget.passwordLabel,
                                      icon: Icons.lock,
                                    )
                                  : SizedBox(),
                              widget.showPasswordConfirmInput
                                  ? LitInputArea(
                                      textEditingController:
                                          _passwordConfirmController,
                                      focusNode: _passwordConfirmFocus,
                                      label: widget.passwordConfirmLabel,
                                      icon: Icons.lock_outline_sharp,
                                    )
                                  : SizedBox(),
                              widget.showPinInput
                                  ? LitInputArea(
                                      textEditingController: _pinController,
                                      focusNode: _pinFocus,
                                      label: widget.pinLabel,
                                      icon: Icons.phonelink_lock_outlined,
                                      showDivider: false,
                                    )
                                  : SizedBox(),
                            ],
                          )
                        ],
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
      ),
    );
  }
}

class LitInputArea extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final String label;
  final bool initialObsureTextValue;
  final bool allowObscuredText;
  final IconData? icon;
  final bool showDivider;
  const LitInputArea({
    Key? key,
    required this.textEditingController,
    required this.focusNode,
    required this.label,
    this.initialObsureTextValue = false,
    this.allowObscuredText = false,
    this.icon,
    this.showDivider = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              icon != null
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
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              icon,
                              color: LitColors.beigeGrey,
                              size: 17.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                      ],
                    )
                  : SizedBox(),
              Text(
                "$label".toUpperCase(),
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
                controller: textEditingController,
                focusNode: focusNode,
                textAlign: TextAlign.left,
                cursorRadius: Radius.circular(2.0),
                style: LitTextStyles.sansSerif.copyWith(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    color: HexColor('#444444'),
                    letterSpacing: 1.25),
              ),
            ),
          ),
          showDivider
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                    height: 2.0,
                    decoration: BoxDecoration(
                      color: HexColor('#C9C9C9'),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
