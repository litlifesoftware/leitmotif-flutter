import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// The views implement on the [LitDatePicker] for selecting a date, a month or
/// a year.
enum LitCalendarViews { day, month, year }

/// The [LitDatePicker]'s `Localization`.
///
/// Contains the localized strings used on the widget.
class LitDatePickerLocalization {
  /// The localized name of the first day of the week.
  final String dayOfWeek1;

  /// The localized name of the second day of the week.
  final String dayOfWeek2;

  /// The localized name of the third day of the week.
  final String dayOfWeek3;

  /// The localized name of the forth day of the week.
  final String dayOfWeek4;

  /// The localized name of the fith day of the week.
  final String dayOfWeek5;

  /// The localiized name of the sixth day of the week.
  final String dayOfWeek6;

  /// The localized name of the seventh day of the week.
  final String dayOfWeek7;

  /// The localized name of the month `January`.
  final String january;

  /// The localized name of the month `February`
  final String february;

  /// The localized name of the month `March`
  final String march;

  /// The localized name of the month `April`
  final String april;

  /// The localized name of the month `May`
  final String may;

  /// The localized name of the month `June`
  final String june;

  /// The localized name of the month `July`
  final String july;

  /// The localized name of the month `August`
  final String august;

  /// The localized name of the month `September`
  final String september;

  /// The localized name of the month `October`
  final String october;

  /// The localized name of the month `November`
  final String november;

  /// The localized name of the month `December`
  final String december;

  final String cancelButtonLabel;

  const LitDatePickerLocalization({
    required this.dayOfWeek1,
    required this.dayOfWeek2,
    required this.dayOfWeek3,
    required this.dayOfWeek4,
    required this.dayOfWeek5,
    required this.dayOfWeek6,
    required this.dayOfWeek7,
    required this.january,
    required this.february,
    required this.march,
    required this.april,
    required this.may,
    required this.june,
    required this.july,
    required this.august,
    required this.september,
    required this.october,
    required this.november,
    required this.december,
    required this.cancelButtonLabel,
  });
}

/// A Leitmotif `input` widget allowing the user to provide a date input by
/// picking a day on a calendar view.
///
/// The business logic is based on `Hitesh Verma`'s implementation available on
/// [GitHub](https://github.com/Hitesh822/flutter_custom_calendar).
///
/// Returns the picked value by calling the [onSelectDate].
class LitDatePicker extends StatefulWidget {
  /// The localization.
  final LitDatePickerLocalization localization;

  /// The initial date the calendar should start at.
  final DateTime? defaultDate;

  /// States whether to invert the first day of the week.
  ///
  /// In the `ISO 8601` specification, `Sunday` is defined as the last/7th
  /// day of the week, while in some regions it is set to be the first day of
  /// the week.
  ///
  final bool invertFirstDayOfWeek;

  /// Returns the selected date.
  final void Function(DateTime?) onSelectDate;

  const LitDatePicker({
    Key? key,
    this.localization = defaultLocalization,
    this.defaultDate,
    this.invertFirstDayOfWeek = false,
    required this.onSelectDate,
  }) : super(key: key);

  /// The default `LitDatePicker` localization.
  static const LitDatePickerLocalization defaultLocalization =
      LitDatePickerLocalization(
    dayOfWeek1: "Monday",
    dayOfWeek2: "Tuesday",
    dayOfWeek3: "Wednesday",
    dayOfWeek4: "Thursday",
    dayOfWeek5: "Friday",
    dayOfWeek6: "Saturday",
    dayOfWeek7: "Sunday",
    january: "January",
    february: "February",
    march: "March",
    april: "April",
    may: "May",
    june: "June",
    july: "July",
    august: "August",
    september: "September",
    october: "October",
    november: "November",
    december: "December",
    cancelButtonLabel: "Cancel",
  );

  @override
  _LitDatePickerState createState() => _LitDatePickerState();
}

class _LitDatePickerState extends State<LitDatePicker> {
  late LitCalendarController _controller = LitCalendarController();

  /// States which view is currently displayed.
  LitCalendarViews _currentView = LitCalendarViews.day;

  /// The date on which the calendar days are based on.
  late DateTime _templateDate;
  DateTime? _selectedDate;
  List<LitCalendarDate> _sequentialDates = [];

  /// The year, the sequential years (displayed on the year grid) are based on.
  int? _medianYear;
  late List<String> _weekDays;
  late List<String> _monthNames;

  void _initState() {
    _controller = LitCalendarController();

    if (widget.defaultDate != null) {
      _templateDate = DateTime(
        widget.defaultDate!.year,
        widget.defaultDate!.month,
      );
      _selectedDate = DateTime(
        widget.defaultDate!.year,
        widget.defaultDate!.month,
        widget.defaultDate!.day,
      );
    } else {
      final now = DateTime.now();
      _templateDate = DateTime(now.year, now.month);
    }
    _renewSeqentialDates();
  }

  /// Creates an abbreviated day of week label.
  String _abbrDayOfWeek(String label, {int length = 2}) {
    return label.substring(0, length);
  }

  /// Initializes the localization.
  void _initLocalization() {
    _weekDays = [
      _abbrDayOfWeek(widget.localization.dayOfWeek1),
      _abbrDayOfWeek(widget.localization.dayOfWeek2),
      _abbrDayOfWeek(widget.localization.dayOfWeek3),
      _abbrDayOfWeek(widget.localization.dayOfWeek4),
      _abbrDayOfWeek(widget.localization.dayOfWeek5),
      _abbrDayOfWeek(widget.localization.dayOfWeek6),
      _abbrDayOfWeek(widget.localization.dayOfWeek7),
    ];
    _monthNames = [
      widget.localization.january,
      widget.localization.february,
      widget.localization.march,
      widget.localization.april,
      widget.localization.may,
      widget.localization.june,
      widget.localization.july,
      widget.localization.august,
      widget.localization.september,
      widget.localization.october,
      widget.localization.november,
      widget.localization.december,
    ];
  }

  /// Selects a view mode.
  void _selectViewMode(LitCalendarViews view) {
    setState(() {
      _currentView = view;
    });
  }

  /// Selects the `year` view.
  void _selectYearView() {
    _selectViewMode(LitCalendarViews.year);
  }

  /// Selects the `month` view.
  void _selectMonthView() {
    _selectViewMode(LitCalendarViews.month);
  }

  /// Selects the `date` view.
  void _selectDateView() {
    _selectViewMode(LitCalendarViews.day);
  }

  /// Handles the `next year` action on the `year` view.
  void _onNextYears() {
    setState(() {
      _medianYear =
          (_medianYear == null) ? _templateDate.year + 9 : _medianYear! + 9;
    });
  }

  /// Handles the `previous year` action on the `year` view.
  void _onPreviousYears() {
    setState(() {
      _medianYear =
          (_medianYear == null) ? _templateDate.year - 9 : _medianYear! - 9;
    });
  }

  /// Handles the `next month` action on the `date` view
  void _getNextMonth() {
    setState(() {
      if (_templateDate.month == 12) {
        _templateDate = DateTime(_templateDate.year + 1, 1);
      } else {
        _templateDate = DateTime(_templateDate.year, _templateDate.month + 1);
      }
      _renewSeqentialDates();
    });
  }

  /// Handles the `previous month` action on the `date` view
  void _getPrevMonth() {
    setState(() {
      if (_templateDate.month == 1) {
        _templateDate = DateTime(_templateDate.year - 1, 12);
      } else {
        _templateDate = DateTime(_templateDate.year, _templateDate.month - 1);
      }
      _renewSeqentialDates();
    });
  }

  /// Creates a new [_sequentialDates] list based on the current
  /// [_templateDate].
  void _renewSeqentialDates() {
    _sequentialDates = _controller.getCalendarDates(
      _templateDate.month,
      _templateDate.year,
      firstDayOfWeek: widget.invertFirstDayOfWeek
          ? FirstDayOfTheWeek.sunday
          : FirstDayOfTheWeek.monday,
    );
  }

  /// Unselects the currently selected date.
  void _unselectDates() {
    setState(() {
      _selectedDate = null;
      widget.onSelectDate(null);
    });
  }

  /// Selects the provided [calendarDate].
  void _onSelect(LitCalendarDate calendarDate) {
    if (_selectedDate != calendarDate.date) {
      if (calendarDate.nextMonth) {
        _getNextMonth();
      } else if (calendarDate.prevMonth) {
        _getPrevMonth();
      }
      setState(() {
        _selectedDate = calendarDate.date;
        widget.onSelectDate(calendarDate.date);
      });
    } else {
      _unselectDates();
    }
  }

  @override
  void initState() {
    super.initState();
    _initState();
    _initLocalization();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 0.0),
      child: Builder(
        builder: (context) {
          switch (_currentView) {
            // Dates view
            case LitCalendarViews.day:
              return _DateGridView(
                invertFirstDayOfWeek: widget.invertFirstDayOfWeek,
                monthLabels: _monthNames,
                onChangeViewMode: _selectMonthView,
                onPressedNext: _getNextMonth,
                onPressedPrevious: _getPrevMonth,
                onSelect: _onSelect,
                selectedDate: _selectedDate,
                sequentialDates: _sequentialDates,
                templateDate: _templateDate,
                weekDays: _weekDays,
              );
            // Month view
            case LitCalendarViews.month:
              return _MonthListView(
                monthNames: _monthNames,
                templateDate: _templateDate,
                onSelect: (index) {
                  _templateDate = DateTime(_templateDate.year, index + 1);
                  _renewSeqentialDates();
                  _selectDateView();
                },
                onChangeViewMode: _selectYearView,
              );
            // Year view
            case LitCalendarViews.year:
              return _YearGridView(
                localization: widget.localization,
                medianYear: _medianYear ?? _templateDate.year,
                onNext: _onNextYears,
                onPrevious: _onPreviousYears,
                onSelect: (thisYear) {
                  _templateDate = DateTime(thisYear, _templateDate.month);
                  _renewSeqentialDates();
                  _selectMonthView();
                },
                templateDate: _templateDate,
                onChangeViewMode: _selectDateView,
              );

            default:
              throw UnimplementedError(
                "This view type has not been implemented",
              );
          }
        },
      ),
    );
  }
}

/// The date picker's date view displaying a grid of all days of a calendar
/// month.
class _DateGridView extends StatelessWidget {
  final DateTime templateDate;
  final DateTime? selectedDate;
  final List<LitCalendarDate> sequentialDates;
  final List<String> monthLabels;
  final List<String> weekDays;
  final bool invertFirstDayOfWeek;
  final void Function() onChangeViewMode;
  final void Function() onPressedNext;
  final void Function() onPressedPrevious;
  final void Function(LitCalendarDate) onSelect;
  const _DateGridView({
    Key? key,
    required this.invertFirstDayOfWeek,
    required this.monthLabels,
    required this.onChangeViewMode,
    required this.onPressedNext,
    required this.onPressedPrevious,
    required this.onSelect,
    required this.selectedDate,
    required this.sequentialDates,
    required this.templateDate,
    required this.weekDays,
  }) : super(key: key);

  String get _monthLabel {
    return monthLabels[templateDate.month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 8.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // prev month button
            LitNavigationButton(
              mode: LitLinearNavigationMode.previous,
              onPressed: onPressedPrevious,
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  onTap: onChangeViewMode,
                  child: Container(
                    decoration: BoxDecoration(
                      color: LitColors.lightGrey.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          _monthLabel.toUpperCase() +
                              " " +
                              templateDate.year.toString(),
                          style: LitSansSerifStyles.button,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // next month button
            LitNavigationButton(
              mode: LitLinearNavigationMode.next,
              onPressed: onPressedNext,
            ),
          ],
        ),
        SizedBox(height: 4.0),
        _CalendarGridBuilder(
          invertFirstDayOfWeek: invertFirstDayOfWeek,
          onSelect: onSelect,
          selectedDateTime: selectedDate,
          sequentialDates: sequentialDates,
          weekDays: weekDays,
        ),
        SizedBox(height: 4.0),
      ],
    );
  }
}

/// The date picker's month view displaying all months of a calendar year.
class _MonthListView extends StatelessWidget {
  final DateTime templateDate;
  final List<String> monthNames;
  final void Function(int index) onSelect;
  final void Function() onChangeViewMode;
  const _MonthListView({
    Key? key,
    required this.templateDate,
    required this.monthNames,
    required this.onSelect,
    required this.onChangeViewMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 4.0,
        ),
        InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          onTap: onChangeViewMode,
          child: Container(
            height: 42.0,
            // color: Colors.black12,
            decoration: BoxDecoration(
              color: LitColors.lightGrey.withOpacity(0.1),
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Center(
                child: Text(
                  templateDate.year.toString(),
                  style: LitSansSerifStyles.button,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 384.0,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            // padding: EdgeInsets.zero,
            itemCount: monthNames.length,
            itemBuilder: (context, index) {
              return _MonthListItem(
                index: index,
                monthNames: monthNames,
                onSelect: onSelect,
                templateDate: templateDate,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CalendarGridBuilder extends StatelessWidget {
  final List<LitCalendarDate> sequentialDates;

  final DateTime? selectedDateTime;
  final List<String> weekDays;
  final bool invertFirstDayOfWeek;
  final void Function(LitCalendarDate) onSelect;

  const _CalendarGridBuilder({
    Key? key,
    required this.sequentialDates,
    required this.selectedDateTime,
    required this.weekDays,
    required this.invertFirstDayOfWeek,
    required this.onSelect,
  }) : super(key: key);

  bool isSelected(int index) {
    return sequentialDates[index - 7].date == selectedDateTime;
  }

  String _getHeaderLabelAt(int index) {
    if (invertFirstDayOfWeek) {
      return weekDays[index != 0 ? (index - 1) : (weekDays.length - 1)];
    } else {
      return weekDays[index];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (sequentialDates.length == 0) return Container();
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: sequentialDates.length + 7,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 4,
        crossAxisCount: 7,
        crossAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        if (index < 7)
          return Center(
            child: Text(
              _getHeaderLabelAt(index),
              style: LitSansSerifStyles.caption,
            ),
          );

        return LayoutBuilder(
          builder: (context, constraints) {
            return _CalendarGridItem(
              isSelected: isSelected(index),
              borderRadius: BorderRadius.all(
                Radius.circular(constraints.maxWidth / 2.5),
              ),
              calendar: sequentialDates[index - 7],
              onPressed: () => onSelect(
                sequentialDates[index - 7],
              ),
            );
          },
        );
        //_calendarDates(_sequentialDates[index - 7]);
      },
    );
  }
}

class _MonthListItem extends StatelessWidget {
  final int index;
  final DateTime templateDate;
  final void Function(int) onSelect;
  final List<String> monthNames;
  const _MonthListItem({
    Key? key,
    required this.index,
    required this.templateDate,
    required this.onSelect,
    required this.monthNames,
  }) : super(key: key);

  bool get _isSelected {
    return (index == templateDate.month - 1);
  }

  void _onSelect() {
    onSelect(index);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: _isSelected ? Colors.black12 : null,
      onTap: _onSelect,
      title: Center(
        child: Text(
          monthNames[index].toUpperCase(),
          style: LitSansSerifStyles.button.copyWith(
            color: _isSelected
                ? LitSansSerifStyles.defaultColor
                : LitSansSerifStyles.defaultColor.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}

class _CalendarGridItem extends StatelessWidget {
  final isSelected;
  final LitCalendarDate calendar;
  final BorderRadius borderRadius;
  final void Function() onPressed;
  const _CalendarGridItem({
    Key? key,
    required this.isSelected,
    required this.calendar,
    required this.borderRadius,
    required this.onPressed,
  }) : super(key: key);

  List<Color> get _gradientColors {
    return (calendar.thisMonth)
        ? [Color(0xFFef93a1), Color(0xFFb2b2b2)]
        : [Color(0xFFe3e3e3), Color(0xFFe7e7e7)];
  }

  Color get _textColor {
    return (calendar.thisMonth)
        ? isSelected
            ? Colors.white
            : Color(0xFF7a7a7a)
        : Color(0xFF7a7a7a).withOpacity(0.45);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
                boxShadow: LitBoxShadows.xs,
                gradient: LinearGradient(
                  colors: _gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.2, 0.9],
                ),
                borderRadius: borderRadius,
              )
            : BoxDecoration(),
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onPressed,
          child: Center(
            child: ScaledDownText(
              calendar.date.day.toString(),
              style: LitSansSerifStyles.subtitle1.copyWith(
                color: _textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The date picker's year view displaying a grid of multiple years for easier
/// access.
class _YearGridView extends StatelessWidget {
  final DateTime templateDate;
  final LitDatePickerLocalization localization;
  final int medianYear;
  final void Function() onChangeViewMode;
  final void Function() onNext;
  final void Function() onPrevious;
  final void Function(int thisYear) onSelect;
  const _YearGridView({
    Key? key,
    required this.localization,
    required this.medianYear,
    required this.onChangeViewMode,
    required this.onNext,
    required this.onPrevious,
    required this.onSelect,
    required this.templateDate,
  }) : super(key: key);

  /// The grid's outer padding.
  static const EdgeInsets padding = const EdgeInsets.symmetric(
    vertical: 8.0,
    horizontal: 8.0,
  );

  /// States whether the year displayed on the grid is currently selected.
  bool _isSelected(year) {
    return (year == templateDate.year);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 4.0),
        Row(
          children: [
            LitNavigationButton(
              mode: LitLinearNavigationMode.previous,
              onPressed: onPrevious,
            ),
            Expanded(
              child: Padding(
                padding: padding,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  onTap: onChangeViewMode,
                  child: Container(
                    //width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: LitColors.lightGrey.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: padding,
                        child: Text(
                          localization.cancelButtonLabel.toUpperCase(),
                          style: LitSansSerifStyles.button,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            LitNavigationButton(
              mode: LitLinearNavigationMode.next,
              onPressed: onNext,
            ),
          ],
        ),
        SizedBox(
          height: 324.0,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              int thisYear;
              if (index < 4) {
                thisYear = medianYear - (4 - index);
              } else if (index > 4) {
                thisYear = medianYear + (index - 4);
              } else {
                thisYear = medianYear;
              }
              return LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                    padding: padding,
                    child: InkWell(
                      borderRadius: BorderRadius.all(
                        Radius.circular(constraints.maxWidth / 4),
                      ),
                      onTap: () => onSelect(thisYear),
                      child: Container(
                        decoration: BoxDecoration(
                          color: _isSelected(thisYear)
                              ? Color(0xFFebebeb)
                              : Color(0xFFfbfbfb),
                          boxShadow: LitBoxShadows.md,
                          borderRadius: BorderRadius.all(
                            Radius.circular(constraints.maxWidth / 4),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            thisYear.toString(),
                            style: LitSansSerifStyles.button.copyWith(
                              color: _isSelected(thisYear)
                                  ? LitSansSerifStyles.defaultColor
                                  : LitSansSerifStyles.defaultColor
                                      .withOpacity(0.65),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
