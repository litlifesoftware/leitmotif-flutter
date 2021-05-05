import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';
import 'package:lit_ui_kit/src/controller/calendar_controller.dart';
import 'package:lit_ui_kit/src/widgets/containers/on_value_changed_animated_container.dart';

/// A [Widget] to display the current calendar date on the [AgeConfirmationScreen].

class AgeConfirmationCalendarDateIndicators extends StatefulWidget {
  final AnimationController? parentAnimation;

  final CalendarController calendarController;
  final bool? shouldAnimateMonthTransition;
  final bool? shouldAnimateYearTransition;

  final void Function(bool) toggleShouldAnimateMonthTransitionCallback;
  final void Function(bool) setShouldAnimateYearTransitionCallback;

  /// Creates a [AgeConfirmationCalendarDateIndicators].

  const AgeConfirmationCalendarDateIndicators({
    Key? key,
    required this.parentAnimation,
    required this.calendarController,
    required this.shouldAnimateMonthTransition,
    required this.shouldAnimateYearTransition,
    required this.toggleShouldAnimateMonthTransitionCallback,
    required this.setShouldAnimateYearTransitionCallback,
  }) : super(key: key);

  @override
  _AgeConfirmationCalendarDateIndicatorsState createState() =>
      _AgeConfirmationCalendarDateIndicatorsState();
}

class _AgeConfirmationCalendarDateIndicatorsState
    extends State<AgeConfirmationCalendarDateIndicators>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: Row(
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width - 32) * 0.5,
                child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 8.0,
                    ),
                    child: OnValueChangedAnimatedContainer(
                        shouldAnimate: widget.shouldAnimateMonthTransition,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          child: ClippedText(
                            "${DateFormat.MMMM('${Localizations.localeOf(context).languageCode}').format(widget.calendarController.templateDate!)}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: LitTextStyles.sansSerif.copyWith(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              LitColors.lightPink.withOpacity(0.85),
                              LitColors.lightPink.withOpacity(0.75),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        duration: widget.parentAnimation!.duration,
                        toggleShouldAnimate:
                            widget.toggleShouldAnimateMonthTransitionCallback)
                    // AnimatedBuilder(
                    //     animation: _monthTransition,
                    //     builder: (BuildContext context, Widget child) {
                    //       _animateMonthLabel();
                    //       return FadeInTransformScaleContainer(
                    //         animationController: _monthTransition,
                    //         scale: ((1 - (_monthTransition.value * 0.06125))),
                    //         transform: Matrix4.translationValues(
                    //             0, -5 + (5 * _monthTransition.value), 0),
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //             gradient: LinearGradient(
                    //               begin: Alignment.topCenter,
                    //               end: Alignment.bottomCenter,
                    //               colors: [
                    //                 LitColors.lightPink.withOpacity(0.85),
                    //                 LitColors.lightPink.withOpacity(0.75),
                    //               ],
                    //             ),
                    //             borderRadius: BorderRadius.circular(20.0),
                    //           ),
                    //           child: Padding(
                    //             padding: const EdgeInsets.symmetric(
                    //               vertical: 8.0,
                    //               horizontal: 16.0,
                    //             ),
                    //             child: ClippedText(
                    //               "${DateFormat.MMMM('${Localizations.localeOf(context).languageCode}').format(widget.calendarController.templateDate)}",
                    //               maxLines: 1,
                    //               overflow: TextOverflow.ellipsis,
                    //               textAlign: TextAlign.center,
                    //               style: LitTextStyles.sansSerif.copyWith(
                    //                 fontSize: 20.0,
                    //                 fontWeight: FontWeight.w800,
                    //                 color: Colors.white,
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     })

                    ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 32) * 0.5,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 16.0,
                  ),
                  child: OnValueChangedAnimatedContainer(
                      shouldAnimate: widget.shouldAnimateYearTransition,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: ClippedText(
                          "${DateFormat('yyyy').format(widget.calendarController.templateDate!)}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: LitTextStyles.sansSerif.copyWith(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            LitColors.lightBlue.withOpacity(0.85),
                            LitColors.lightBlue.withOpacity(0.75),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      duration: widget.parentAnimation!.duration,
                      toggleShouldAnimate:
                          widget.setShouldAnimateYearTransitionCallback),

                  // AnimatedBuilder(
                  //     animation: _yearTransition,
                  //     builder: (BuildContext context, Widget child) {
                  //       _animateYearLabel();
                  //       return FadeInTransformScaleContainer(
                  //         animationController: _yearTransition,
                  //         scale: ((1 - (_yearTransition.value * 0.06125))),
                  //         transform: Matrix4.translationValues(
                  //             0, -5 + (5 * _yearTransition.value), 0),
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             gradient: LinearGradient(
                  //               begin: Alignment.topCenter,
                  //               end: Alignment.bottomCenter,
                  //               colors: [
                  //                 LitColors.lightBlue.withOpacity(0.85),
                  //                 LitColors.lightBlue.withOpacity(0.75),
                  //               ],
                  //             ),
                  //             borderRadius: BorderRadius.circular(20.0),
                  //           ),
                  //           child: Padding(
                  //             padding: const EdgeInsets.symmetric(
                  //               vertical: 8.0,
                  //               horizontal: 16.0,
                  //             ),
                  //             child: ClippedText(
                  //               "${DateFormat('yyyy').format(widget.calendarController.templateDate)}",
                  //               maxLines: 1,
                  //               overflow: TextOverflow.ellipsis,
                  //               textAlign: TextAlign.center,
                  //               style: LitTextStyles.sansSerif.copyWith(
                  //                 fontSize: 20.0,
                  //                 fontWeight: FontWeight.w800,
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     })
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
