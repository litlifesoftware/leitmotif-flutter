import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class ConfirmAgeScreen extends StatefulWidget {
  @override
  _ConfirmAgeScreenState createState() => _ConfirmAgeScreenState();
}

class _ConfirmAgeScreenState extends State<ConfirmAgeScreen> {
  Size get _deviceSize {
    return MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
      body: Container(
        height: _deviceSize.height,
        width: _deviceSize.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFE8E8E8),
            ],
          ),
        ),
        child: ScrollableColumn(
          constrained: false,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 42.0,
                bottom: 36.0,
                left: 24.0,
                right: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Confirm your Age",
                    style: LitTextStyles.sansSerifHeader.copyWith(
                      color: Color(0xFF848484),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Are you 13 years old or older?",
                      style: LitTextStyles.sansSerifBody.copyWith(
                        color: Color(0xFF848484),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            LitElevatedCard(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                children: [
                  LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.65,
                          child: Text(
                            "YOUR AGE",
                            style: LitTextStyles.sansSerifSubHeader.copyWith(
                              color: Color(0xFFAFAFAF),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.35,
                          child: Container(
                            height: 38.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14.0)),
                              color: Color(0xFFFAFFF5),
                              border: Border.all(
                                color: Color(0xFFCBCACA),
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "13",
                                style: LitTextStyles.sansSerifHeader.copyWith(
                                  color: Color(0xFF5B5B5B),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(
                    height: 16.0,
                  ),
                  LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.65,
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.35,
                          child: LitPushedThroughButton(
                            borderRadius: 16.0,
                            onPressed: () => {},
                            child: Center(
                              child: Text(
                                "SET",
                                style:
                                    LitTextStyles.sansSerifSubHeader.copyWith(
                                  color: Color(0xFF5B5B5B),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(
                    height: 16.0,
                  ),
                  LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.78,
                          child: Text(
                            "VALID",
                            style: LitTextStyles.sansSerifSubHeader.copyWith(
                              color: Color(0xFFAFAFAF),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.22,
                          child: Container(
                            height: constraints.maxWidth * 0.22,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
