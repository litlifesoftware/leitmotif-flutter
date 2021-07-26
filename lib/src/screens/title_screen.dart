import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A screen widget to display animated opening credits.
///
/// The app creator's logo is displayed alongside its credit
/// text.

class TitleScreen extends StatefulWidget {
  final Duration animationDuration;
  final String? titleImageName;
  final String credits;

  /// Creates a [TitleScreen] widget.
  ///
  /// If no [titleImageName] is provided, no image will be
  /// displayed.
  const TitleScreen({
    Key? key,
    required this.animationDuration,
    this.titleImageName,
    required this.credits,
  }) : super(key: key);
  @override
  _TitleScreenState createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  Duration get animationDuration {
    return Duration(milliseconds: widget.animationDuration.inMilliseconds ~/ 2);
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: animationDuration, vsync: this);
    _animationController
        .forward(from: 0.0)
        .then((value) => _animationController.reverse(from: 1.0));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return AnimatedOpacity(
                duration: animationDuration,
                opacity: _animationController.value,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Color.lerp(
                      Colors.white, Colors.black, _animationController.value),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.titleImageName != null
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Container(
                                  child: Image.asset(
                                    "${widget.titleImageName}",
                                  ),
                                ),
                              )
                            : SizedBox(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                          ),
                          child: Text(
                            "${widget.credits}",
                            style: LitTextStyles.sansSerif.copyWith(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w800,
                                color: LitColors.mediumGrey.withOpacity(0.5)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
