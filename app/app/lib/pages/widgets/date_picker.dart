import 'dart:math' as math;

import 'package:base_core/common/config.dart';
import 'package:base_core/res/widgets/text.dart';
import 'package:base_core/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as date;

const double _kItemExtent = 32.0;
const double _kPickerWidth = 320.0;
const double _kPickerHeight = 216.0;
const bool _kUseMagnifier = true;
const double _kMagnification = 2.35 / 2.1;
const double _kDatePickerPadSize = 60.0;
const double _kSqueeze = 1;

const TextStyle _kDefaultPickerTextStyle = TextStyle(letterSpacing: -0.83);
const double _kTimerPickerMagnification = 34 / 32;
const double _kTimerPickerMinHorizontalPadding = 30;
const double _kTimerPickerHalfColumnPadding = 4;
const double _kTimerPickerLabelPadSize = 6;
const double _kTimerPickerLabelFontSize = 17.0;

const double _kTimerPickerColumnIntrinsicWidth = 106;

TextStyle _themeTextStyle(BuildContext context, {bool isValid = true}) {
  final TextStyle style = CupertinoTheme.of(context).textTheme.dateTimePickerTextStyle;
  return isValid
      ? style.copyWith(color: CupertinoDynamicColor.maybeResolve(style.color, context))
      : style.copyWith(color: CupertinoDynamicColor.resolve(CupertinoColors.inactiveGray, context));
}

void _animateColumnControllerToItem(FixedExtentScrollController controller, int targetItem) {
  controller.animateToItem(
    targetItem,
    curve: Curves.easeInOut,
    duration: const Duration(milliseconds: 200),
  );
}

const Widget _startSelectionOverlay = CupertinoPickerDefaultSelectionOverlay(capEndEdge: false);
const Widget _centerSelectionOverlay = CupertinoPickerDefaultSelectionOverlay(
  capStartEdge: false,
  capEndEdge: false,
);
const Widget _endSelectionOverlay = CupertinoPickerDefaultSelectionOverlay(capStartEdge: false);

typedef SelectionOverlayBuilder = Widget? Function(
  BuildContext context, {
  required int columnCount,
  required int selectedIndex,
});

class _DatePickerLayoutDelegate extends MultiChildLayoutDelegate {
  _DatePickerLayoutDelegate({
    required this.columnWidths,
    required this.textDirectionFactor,
    required this.maxWidth,
  });

  final List<double> columnWidths;
  final int textDirectionFactor;
  final double maxWidth;

  @override
  void performLayout(Size size) {
    double remainingWidth = maxWidth < size.width ? maxWidth : size.width;

    double currentHorizontalOffset = (size.width - remainingWidth) / 2;

    for (int i = 0; i < columnWidths.length; i++) {
      remainingWidth -= columnWidths[i] + _kDatePickerPadSize * 2;
    }

    for (int i = 0; i < columnWidths.length; i++) {
      final int index = textDirectionFactor == 1 ? i : columnWidths.length - i - 1;

      double childWidth = columnWidths[index] + _kDatePickerPadSize * 2;
      if (index == 0 || index == columnWidths.length - 1) {
        childWidth += remainingWidth / 2;
      }

      assert(() {
        if (childWidth < 0) {
          FlutterError.reportError(
            FlutterErrorDetails(
              exception: FlutterError(
                'Insufficient horizontal space to render the '
                'CupertinoDatePicker because the parent is too narrow at '
                '${size.width}px.\n'
                'An additional ${-remainingWidth}px is needed to avoid '
                'overlapping columns.',
              ),
            ),
          );
        }
        return true;
      }());
      layoutChild(index, BoxConstraints.tight(Size(math.max(0.0, childWidth), size.height)));
      positionChild(index, Offset(currentHorizontalOffset, 0.0));

      currentHorizontalOffset += childWidth;
    }
  }

  @override
  bool shouldRelayout(_DatePickerLayoutDelegate oldDelegate) {
    return columnWidths != oldDelegate.columnWidths || textDirectionFactor != oldDelegate.textDirectionFactor;
  }
}

/// Different display modes of [CupertinoDatePicker].
///
/// See also:
///
///  * [CupertinoDatePicker], the class that implements different display modes
///    of the iOS-style date picker.
///  * [CupertinoPicker], the class that implements a content agnostic spinner UI.
enum CupertinoDatePickerMode {
  dateDDMMYYYY,
}

// Different types of column in CupertinoDatePicker.
enum _PickerColumnType {
  dayOfMonth,
  month,
  year,
  date,
  hour,
  minute,
  dayPeriod,
}

class CupertinoDatePicker extends StatefulWidget {
  CupertinoDatePicker({
    super.key,
    this.mode = CupertinoDatePickerMode.dateDDMMYYYY,
    required this.onDateTimeChanged,
    required this.initialDateTime,
    this.minimumDate,
    this.maximumDate,
    this.minimumYear = 1,
    this.maximumYear,
    this.minuteInterval = 1,
    this.use24hFormat = false,
    this.dateOrder,
    this.backgroundColor,
    this.showDayOfWeek = false,
    this.itemExtent = _kItemExtent,
    this.selectionOverlayBuilder,
  })  : assert(itemExtent > 0, 'item extent should be greater than 0'),
        assert(
          minuteInterval > 0 && 60 % minuteInterval == 0,
          'minute interval is not a positive integer factor of 60',
        ),
        assert(
          (initialDateTime).minute % minuteInterval == 0,
          'initial minute is not divisible by minute interval',
        );

  final CupertinoDatePickerMode mode;
  final DateTime initialDateTime;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final int minimumYear;
  final int? maximumYear;
  final int minuteInterval;
  final bool use24hFormat;
  final DatePickerDateOrder? dateOrder;
  final ValueChanged<DateTime> onDateTimeChanged;
  final Color? backgroundColor;
  final bool showDayOfWeek;
  final double itemExtent;
  final Widget? selectionOverlayBuilder;

  @override
  State<StatefulWidget> createState() {
    return switch (mode) {
      CupertinoDatePickerMode.dateDDMMYYYY => _CupertinoDateDDMMYYYPickerDateState(),
    };
  }

  // Estimate the minimum width that each column needs to layout its content.
  static double _getColumnWidth(
    _PickerColumnType columnType,
    CupertinoLocalizations localizations,
    BuildContext context,
    bool showDayOfWeek, {
    bool standaloneMonth = false,
  }) {
    final List<String> longTexts = <String>[];

    switch (columnType) {
      case _PickerColumnType.date:
        for (int i = 1; i <= 12; i++) {
          final String date = localizations.datePickerMediumDate(DateTime(2018, i, 25));
          longTexts.add(date);
        }
      case _PickerColumnType.hour:
        for (int i = 0; i < 24; i++) {
          final String hour = localizations.datePickerHour(i);
          longTexts.add(hour);
        }
      case _PickerColumnType.minute:
        for (int i = 0; i < 60; i++) {
          final String minute = localizations.datePickerMinute(i);
          longTexts.add(minute);
        }
      case _PickerColumnType.dayPeriod:
        longTexts.add(localizations.anteMeridiemAbbreviation);
        longTexts.add(localizations.postMeridiemAbbreviation);
      case _PickerColumnType.dayOfMonth:
        int longestDayOfMonth = 1;
        for (int i = 1; i <= 31; i++) {
          final String dayOfMonth = localizations.datePickerDayOfMonth(i);
          longTexts.add(dayOfMonth);
          longestDayOfMonth = i;
        }
        if (showDayOfWeek) {
          for (int wd = 1; wd < DateTime.daysPerWeek; wd++) {
            final String dayOfMonth = localizations.datePickerDayOfMonth(longestDayOfMonth, wd);
            longTexts.add(dayOfMonth);
          }
        }
      case _PickerColumnType.month:
        for (int i = 1; i <= 12; i++) {
          final String month =
              standaloneMonth ? localizations.datePickerStandaloneMonth(i) : localizations.datePickerMonth(i);
          longTexts.add(month);
        }
      case _PickerColumnType.year:
        longTexts.add(localizations.datePickerYear(2018));
    }

    assert(
      longTexts.isNotEmpty && longTexts.every((String text) => text.isNotEmpty),
      'column type is not appropriate',
    );

    return getColumnWidth(texts: longTexts, context: context);
  }

  /// Returns the width of column in the picker.
  ///
  /// This method is intended for testing only. It calculates the width of the
  /// widest column in the picker based on the provided list of texts and the
  /// given [BuildContext].
  @visibleForTesting
  static double getColumnWidth({
    required List<String> texts,
    required BuildContext context,
    TextStyle? textStyle,
  }) {
    return texts
        .map(
          (String text) => TextPainter.computeMaxIntrinsicWidth(
            text: TextSpan(style: textStyle ?? _themeTextStyle(context), text: text),
            textDirection: Directionality.of(context),
          ),
        )
        .reduce(math.max);
  }
}

typedef _ColumnBuilder = Widget Function(
  double offAxisFraction,
  TransitionBuilder itemPositioningBuilder,
);

class _CupertinoDateDDMMYYYPickerDateState extends State<CupertinoDatePicker> {
  _CupertinoDateDDMMYYYPickerDateState();

  late int textDirectionFactor;
  late CupertinoLocalizations localizations;

  // Alignment based on text direction. The variable name is self descriptive,
  // however, when text direction is rtl, alignment is reversed.
  late Alignment alignCenterLeft;
  late Alignment alignCenterRight;

  // The currently selected values of the picker.
  late int selectedDay;
  late int selectedMonth;
  late int selectedYear;

  // The controller of the day picker. There are cases where the selected value
  // of the picker is invalid (e.g. February 30th 2018), and this dayController
  // is responsible for jumping to a valid value.
  late FixedExtentScrollController dayController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController yearController;

  bool isDayPickerScrolling = false;
  bool isMonthPickerScrolling = false;
  bool isYearPickerScrolling = false;

  bool get isScrolling => isDayPickerScrolling || isMonthPickerScrolling || isYearPickerScrolling;

  // Estimated width of columns.
  Map<int, double> estimatedColumnWidths = <int, double>{};

  @override
  void initState() {
    super.initState();
    selectedDay = widget.initialDateTime.day;
    selectedMonth = widget.initialDateTime.month;
    selectedYear = widget.initialDateTime.year;
    logger.d('NEON selectedDay = $selectedDay');
    logger.d('NEON selectedMonth = $selectedMonth');
    logger.d('NEON selectedYear = $selectedYear');
    dayController = FixedExtentScrollController(initialItem: selectedDay - 1);
    monthController = FixedExtentScrollController(initialItem: selectedMonth - 1);
    yearController = FixedExtentScrollController(initialItem: selectedYear);

    PaintingBinding.instance.systemFonts.addListener(_handleSystemFontsChange);
  }

  void _handleSystemFontsChange() {
    setState(() {
      // System fonts change might cause the text layout width to change.
      _refreshEstimatedColumnWidths();
    });
  }

  @override
  void dispose() {
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();

    PaintingBinding.instance.systemFonts.removeListener(_handleSystemFontsChange);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    textDirectionFactor = Directionality.of(context) == TextDirection.ltr ? 1 : -1;
    localizations = CupertinoLocalizations.of(context);

    alignCenterLeft = textDirectionFactor == 1 ? Alignment.centerLeft : Alignment.centerRight;
    alignCenterRight = textDirectionFactor == 1 ? Alignment.centerRight : Alignment.centerLeft;

    _refreshEstimatedColumnWidths();
  }

  void _refreshEstimatedColumnWidths() {
    estimatedColumnWidths[_PickerColumnType.dayOfMonth.index] = CupertinoDatePicker._getColumnWidth(
      _PickerColumnType.dayOfMonth,
      localizations,
      context,
      widget.showDayOfWeek,
    );
    estimatedColumnWidths[_PickerColumnType.month.index] = CupertinoDatePicker._getColumnWidth(
      _PickerColumnType.month,
      localizations,
      context,
      widget.showDayOfWeek,
    );
    estimatedColumnWidths[_PickerColumnType.year.index] = CupertinoDatePicker._getColumnWidth(
      _PickerColumnType.year,
      localizations,
      context,
      widget.showDayOfWeek,
    );
  }

  // The DateTime of the last day of a given month in a given year.
  // Let `DateTime` handle the year/month overflow.
  DateTime _lastDayInMonth(int year, int month) => DateTime(year, month + 1, 0);

  Widget _buildDayPicker(
    double offAxisFraction,
    TransitionBuilder itemPositioningBuilder,
  ) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollStartNotification) {
          isDayPickerScrolling = true;
        } else if (notification is ScrollEndNotification) {
          isDayPickerScrolling = false;
          _pickerDidStopScrolling();
        }

        return false;
      },
      child: CupertinoPicker(
        scrollController: dayController,
        offAxisFraction: offAxisFraction,
        itemExtent: widget.itemExtent,
        useMagnifier: _kUseMagnifier,
        diameterRatio: 1000,
        backgroundColor: widget.backgroundColor,
        squeeze: _kSqueeze,
        onSelectedItemChanged: (int index) {
          selectedDay = index + 1;
          if (_isCurrentDateValid) {
            widget.onDateTimeChanged(DateTime(selectedYear, selectedMonth, selectedDay));
          }
        },
        looping: true,
        selectionOverlay: SizedBox(),
        children: List<Widget>.generate(31, (int index) {
          final int day = index + 1;
          return Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            child: TextCs(
              text: '$day',
              style: AppFonts.large500,
              color: AppColors.inkBase,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildMonthMMPicker(
    double offAxisFraction,
    TransitionBuilder itemPositioningBuilder,
  ) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollStartNotification) {
          isMonthPickerScrolling = true;
        } else if (notification is ScrollEndNotification) {
          isMonthPickerScrolling = false;
          _pickerDidStopScrolling();
        }

        return false;
      },
      child: CupertinoPicker(
        scrollController: monthController,
        offAxisFraction: offAxisFraction,
        itemExtent: widget.itemExtent,
        useMagnifier: _kUseMagnifier,
        backgroundColor: widget.backgroundColor,
        squeeze: _kSqueeze,
        diameterRatio: 1000,
        onSelectedItemChanged: (int index) {
          selectedMonth = index + 1;
          if (_isCurrentDateValid) {
            widget.onDateTimeChanged(DateTime(selectedYear, selectedMonth, selectedDay));
          }
        },
        looping: true,
        selectionOverlay: SizedBox(),
        children: List<Widget>.generate(12, (int index) {
          final int month = index + 1;
          final String localeName = Localizations.localeOf(context).toString();
          final String short = date.DateFormat('MMM', localeName).format(DateTime(2000, month, 1));
          return Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            child: TextCs(
              text: short,
              style: AppFonts.large500,
              color: AppColors.inkBase,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildYearPicker(
    double offAxisFraction,
    TransitionBuilder itemPositioningBuilder,
  ) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollStartNotification) {
          isYearPickerScrolling = true;
        } else if (notification is ScrollEndNotification) {
          isYearPickerScrolling = false;
          _pickerDidStopScrolling();
        }

        return false;
      },
      child: CupertinoPicker.builder(
        scrollController: yearController,
        itemExtent: widget.itemExtent,
        offAxisFraction: offAxisFraction,
        useMagnifier: _kUseMagnifier,
        squeeze: _kSqueeze,
        diameterRatio: 1000,
        backgroundColor: widget.backgroundColor,
        onSelectedItemChanged: (int index) {
          selectedYear = index;
          if (_isCurrentDateValid) {
            widget.onDateTimeChanged(DateTime(selectedYear, selectedMonth, selectedDay));
          }
        },
        itemBuilder: (BuildContext context, int year) {
          if (year < widget.minimumYear) {
            return null;
          }

          if (widget.maximumYear != null && year > widget.maximumYear!) {
            return null;
          }
          return Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            child: TextCs(
              text: '$year',
              style: AppFonts.large500,
              color: AppColors.inkBase,
            ),
          );
        },
        selectionOverlay: SizedBox(),
      ),
    );
  }

  bool get _isCurrentDateValid {
    // The current date selection represents a range [minSelectedData, maxSelectDate].
    final DateTime minSelectedDate = DateTime(selectedYear, selectedMonth, selectedDay);
    final DateTime maxSelectedDate = DateTime(selectedYear, selectedMonth, selectedDay + 1);

    final bool minCheck = widget.minimumDate?.isBefore(maxSelectedDate) ?? true;
    final bool maxCheck = widget.maximumDate?.isBefore(minSelectedDate) ?? false;

    return minCheck && !maxCheck && minSelectedDate.day == selectedDay;
  }

  // One or more pickers have just stopped scrolling.
  void _pickerDidStopScrolling() {
    // Call setState to update the greyed out days/months/years, as the currently
    // selected year/month may have changed.
    setState(() {});

    if (isScrolling) {
      return;
    }

    // Whenever scrolling lands on an invalid entry, the picker
    // automatically scrolls to a valid one.
    final DateTime minSelectDate = DateTime(selectedYear, selectedMonth, selectedDay);
    final DateTime maxSelectDate = DateTime(selectedYear, selectedMonth, selectedDay + 1);

    final bool minCheck = widget.minimumDate?.isBefore(maxSelectDate) ?? true;
    final bool maxCheck = widget.maximumDate?.isBefore(minSelectDate) ?? false;

    if (!minCheck || maxCheck) {
      // We have minCheck === !maxCheck.
      final DateTime targetDate = minCheck ? widget.maximumDate! : widget.minimumDate!;
      _scrollToDate(targetDate);
      return;
    }

    // Some months have less days (e.g. February). Go to the last day of that month
    // if the selectedDay exceeds the maximum.
    if (minSelectDate.day != selectedDay) {
      final DateTime lastDay = _lastDayInMonth(selectedYear, selectedMonth);
      _scrollToDate(lastDay);
    }
  }

  void _scrollToDate(DateTime newDate) {
    SchedulerBinding.instance.addPostFrameCallback(
      (Duration timestamp) {
        if (selectedYear != newDate.year) {
          _animateColumnControllerToItem(yearController, newDate.year);
        }

        if (selectedMonth != newDate.month) {
          _animateColumnControllerToItem(monthController, newDate.month - 1);
        }

        if (selectedDay != newDate.day) {
          _animateColumnControllerToItem(dayController, newDate.day - 1);
        }
      },
      debugLabel: 'DatePicker.scrollToDate',
    );
  }

  @override
  Widget build(BuildContext context) {
    List<_ColumnBuilder> pickerBuilders = <_ColumnBuilder>[];
    List<double> columnWidths = <double>[];

    pickerBuilders = <_ColumnBuilder>[_buildDayPicker, _buildMonthMMPicker, _buildYearPicker];
    columnWidths = <double>[
      estimatedColumnWidths[_PickerColumnType.year.index]!,
      estimatedColumnWidths[_PickerColumnType.year.index]!,
      estimatedColumnWidths[_PickerColumnType.year.index]!,
    ];

    final List<Widget> pickers = <Widget>[];
    double totalColumnWidths = 4 * _kDatePickerPadSize;
    Widget? selectionOverlay = _centerSelectionOverlay;

    if (widget.selectionOverlayBuilder != null) {
      selectionOverlay = widget.selectionOverlayBuilder;
    }

    for (final (int i, double width) in columnWidths.indexed) {
      final (bool firstColumn, bool lastColumn) = (i == 0, i == columnWidths.length - 1);
      final double offAxisFraction = (i - 1) * 0.3 * textDirectionFactor;

      EdgeInsets padding = const EdgeInsets.only(right: _kDatePickerPadSize);
      if (textDirectionFactor == -1) {
        padding = const EdgeInsets.only(left: _kDatePickerPadSize);
      }
      totalColumnWidths += width + (2 * _kDatePickerPadSize);

      pickers.add(
        LayoutId(
          id: i,
          child: pickerBuilders[i](
            offAxisFraction,
            (BuildContext context, Widget? child) {
              return Padding(
                padding: firstColumn ? EdgeInsets.zero : padding,
                child: Align(
                  alignment: lastColumn ? alignCenterLeft : alignCenterRight,
                  child: SizedBox(
                    width: width + _kDatePickerPadSize,
                    child: Align(
                      alignment: firstColumn ? alignCenterLeft : alignCenterRight,
                      child: child,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }

    final double maxPickerWidth = totalColumnWidths > _kPickerWidth ? totalColumnWidths : _kPickerWidth;

    return MediaQuery.withNoTextScaling(
      child: DefaultTextStyle.merge(
        style: _kDefaultPickerTextStyle,
        child: Stack(
          alignment: Alignment.center,
          children: [
            selectionOverlay ?? SizedBox(),
            selectionOverlay ?? SizedBox(),
            CustomMultiChildLayout(
              delegate: _DatePickerLayoutDelegate(
                columnWidths: columnWidths,
                textDirectionFactor: textDirectionFactor,
                maxWidth: maxPickerWidth,
              ),
              children: pickers,
            ),
            Positioned(
              child: Container(
                height: 32.h,
                color: AppColors.white.withValues(
                  alpha: 0.5,
                ),
              ),
              top: 5.h,
              left: 0,
              right: 0,
            ),
            Positioned(
              child: Container(
                height: 32.h,
                color: AppColors.white.withValues(
                  alpha: 0.5,
                ),
              ),
              bottom: 3.h,
              left: 0,
              right: 0,
            ),
          ],
        ),
      ),
    );
  }
}

enum CupertinoTimerPickerMode {
  hm,
  ms,
  hms,
}

class CupertinoTimerPicker extends StatefulWidget {
  CupertinoTimerPicker({
    super.key,
    this.mode = CupertinoTimerPickerMode.hms,
    this.initialTimerDuration = Duration.zero,
    this.minuteInterval = 1,
    this.secondInterval = 1,
    this.alignment = Alignment.center,
    this.backgroundColor,
    this.itemExtent = _kItemExtent,
    required this.onTimerDurationChanged,
    this.selectionOverlayBuilder,
  })  : assert(initialTimerDuration >= Duration.zero),
        assert(initialTimerDuration < const Duration(days: 1)),
        assert(minuteInterval > 0 && 60 % minuteInterval == 0),
        assert(secondInterval > 0 && 60 % secondInterval == 0),
        assert(initialTimerDuration.inMinutes % minuteInterval == 0),
        assert(initialTimerDuration.inSeconds % secondInterval == 0),
        assert(itemExtent > 0, 'item extent should be greater than 0');

  final CupertinoTimerPickerMode mode;
  final Duration initialTimerDuration;
  final int minuteInterval;
  final int secondInterval;
  final ValueChanged<Duration> onTimerDurationChanged;
  final AlignmentGeometry alignment;
  final Color? backgroundColor;
  final double itemExtent;
  final SelectionOverlayBuilder? selectionOverlayBuilder;

  @override
  State<StatefulWidget> createState() => _CupertinoTimerPickerState();
}

class _CupertinoTimerPickerState extends State<CupertinoTimerPicker> {
  late TextDirection textDirection;
  late CupertinoLocalizations localizations;

  int get textDirectionFactor => switch (textDirection) {
        TextDirection.ltr => 1,
        TextDirection.rtl => -1,
      };

  // The currently selected values of the picker.
  int? selectedHour;
  late int selectedMinute;
  int? selectedSecond;

  // On iOS the selected values won't be reported until the scrolling fully stops.
  // The values below are the latest selected values when the picker comes to a full stop.
  int? lastSelectedHour;
  int? lastSelectedMinute;
  int? lastSelectedSecond;

  final TextPainter textPainter = TextPainter();
  final List<String> numbers = List<String>.generate(10, (int i) => '${9 - i}');
  late double numberLabelWidth;
  late double numberLabelHeight;
  late double numberLabelBaseline;

  late double hourLabelWidth;
  late double minuteLabelWidth;
  late double secondLabelWidth;

  late double totalWidth;
  late double pickerColumnWidth;

  FixedExtentScrollController? _hourScrollController;
  FixedExtentScrollController? _minuteScrollController;
  FixedExtentScrollController? _secondScrollController;

  @override
  void initState() {
    super.initState();

    selectedMinute = widget.initialTimerDuration.inMinutes % 60;

    if (widget.mode != CupertinoTimerPickerMode.ms) {
      selectedHour = widget.initialTimerDuration.inHours;
    }

    if (widget.mode != CupertinoTimerPickerMode.hm) {
      selectedSecond = widget.initialTimerDuration.inSeconds % 60;
    }

    PaintingBinding.instance.systemFonts.addListener(_handleSystemFontsChange);
  }

  void _handleSystemFontsChange() {
    setState(() {
      // System fonts change might cause the text layout width to change.
      textPainter.markNeedsLayout();
      _measureLabelMetrics();
    });
  }

  @override
  void dispose() {
    PaintingBinding.instance.systemFonts.removeListener(_handleSystemFontsChange);
    textPainter.dispose();

    _hourScrollController?.dispose();
    _minuteScrollController?.dispose();
    _secondScrollController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CupertinoTimerPicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    assert(
      oldWidget.mode == widget.mode,
      "The CupertinoTimerPicker's mode cannot change once it's built",
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    textDirection = Directionality.of(context);
    localizations = CupertinoLocalizations.of(context);

    _measureLabelMetrics();
  }

  void _measureLabelMetrics() {
    textPainter.textDirection = textDirection;
    final TextStyle textStyle = _textStyleFrom(context, _kTimerPickerMagnification);

    double maxWidth = double.negativeInfinity;
    String? widestNumber;

    // Assumes that:
    // - 2-digit numbers are always wider than 1-digit numbers.
    // - There's at least one number in 1-9 that's wider than or equal to 0.
    // - The widest 2-digit number is composed of 2 same 1-digit numbers
    //   that has the biggest width.
    // - If two different 1-digit numbers are of the same width, their corresponding
    //   2 digit numbers are of the same width.
    for (final String input in numbers) {
      textPainter.text = TextSpan(text: input, style: textStyle);
      textPainter.layout();

      if (textPainter.maxIntrinsicWidth > maxWidth) {
        maxWidth = textPainter.maxIntrinsicWidth;
        widestNumber = input;
      }
    }

    textPainter.text = TextSpan(text: '$widestNumber$widestNumber', style: textStyle);

    textPainter.layout();
    numberLabelWidth = textPainter.maxIntrinsicWidth;
    numberLabelHeight = textPainter.height;
    numberLabelBaseline = textPainter.computeDistanceToActualBaseline(TextBaseline.alphabetic);

    minuteLabelWidth = _measureLabelsMaxWidth(localizations.timerPickerMinuteLabels, textStyle);

    if (widget.mode != CupertinoTimerPickerMode.ms) {
      hourLabelWidth = _measureLabelsMaxWidth(localizations.timerPickerHourLabels, textStyle);
    }

    if (widget.mode != CupertinoTimerPickerMode.hm) {
      secondLabelWidth = _measureLabelsMaxWidth(localizations.timerPickerSecondLabels, textStyle);
    }
  }

  // Measures all possible time text labels and return maximum width.
  double _measureLabelsMaxWidth(List<String?> labels, TextStyle style) {
    double maxWidth = double.negativeInfinity;
    for (int i = 0; i < labels.length; i++) {
      final String? label = labels[i];
      if (label == null) {
        continue;
      }

      textPainter.text = TextSpan(text: label, style: style);
      textPainter.layout();
      textPainter.maxIntrinsicWidth;
      if (textPainter.maxIntrinsicWidth > maxWidth) {
        maxWidth = textPainter.maxIntrinsicWidth;
      }
    }

    return maxWidth;
  }

  // Builds a text label with scale factor 1.0 and font weight semi-bold.
  // `pickerPadding ` is the additional padding the corresponding picker has to apply
  // around the `Text`, in order to extend its separators towards the closest
  // horizontal edge of the encompassing widget.
  Widget _buildLabel(String text, EdgeInsetsDirectional pickerPadding) {
    final EdgeInsetsDirectional padding = EdgeInsetsDirectional.only(
      start: numberLabelWidth + _kTimerPickerLabelPadSize + pickerPadding.start,
    );

    return IgnorePointer(
      child: Padding(
        padding: padding.resolve(textDirection),
        child: Align(
          alignment: AlignmentDirectional.centerStart.resolve(textDirection),
          child: SizedBox(
            height: numberLabelHeight,
            child: Baseline(
              baseline: numberLabelBaseline,
              baselineType: TextBaseline.alphabetic,
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: _kTimerPickerLabelFontSize,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                softWrap: false,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // The picker has to be wider than its content, since the separators
  // are part of the picker.
  Widget _buildPickerNumberLabel(String text, EdgeInsetsDirectional padding) {
    return SizedBox(
      width: _kTimerPickerColumnIntrinsicWidth + padding.horizontal,
      child: Padding(
        padding: padding.resolve(textDirection),
        child: Align(
          alignment: AlignmentDirectional.centerStart.resolve(textDirection),
          child: SizedBox(
            width: numberLabelWidth,
            child: Align(
              alignment: AlignmentDirectional.centerEnd.resolve(textDirection),
              child: Text(text, softWrap: false, maxLines: 1, overflow: TextOverflow.visible),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHourPicker(EdgeInsetsDirectional additionalPadding, Widget? selectionOverlay) {
    _hourScrollController ??= FixedExtentScrollController(initialItem: selectedHour!);
    return CupertinoPicker(
      scrollController: _hourScrollController,
      magnification: _kMagnification,
      offAxisFraction: _calculateOffAxisFraction(additionalPadding.start, 0),
      itemExtent: widget.itemExtent,
      backgroundColor: widget.backgroundColor,
      squeeze: _kSqueeze,
      onSelectedItemChanged: (int index) {
        setState(() {
          selectedHour = index;
          widget.onTimerDurationChanged(
            Duration(hours: selectedHour!, minutes: selectedMinute, seconds: selectedSecond ?? 0),
          );
        });
      },
      selectionOverlay: selectionOverlay,
      children: List<Widget>.generate(24, (int index) {
        final String label = localizations.timerPickerHourLabel(index) ?? '';
        final String semanticsLabel = textDirectionFactor == 1
            ? localizations.timerPickerHour(index) + label
            : label + localizations.timerPickerHour(index);

        return Semantics(
          label: semanticsLabel,
          excludeSemantics: true,
          child: _buildPickerNumberLabel(localizations.timerPickerHour(index), additionalPadding),
        );
      }),
    );
  }

  Widget _buildHourColumn(EdgeInsetsDirectional additionalPadding, Widget? selectionOverlay) {
    additionalPadding = EdgeInsetsDirectional.only(
      start: math.max(additionalPadding.start, 0),
      end: math.max(additionalPadding.end, 0),
    );

    return Stack(
      children: <Widget>[
        NotificationListener<ScrollEndNotification>(
          onNotification: (ScrollEndNotification notification) {
            setState(() {
              lastSelectedHour = selectedHour;
            });
            return false;
          },
          child: _buildHourPicker(additionalPadding, selectionOverlay),
        ),
        _buildLabel(
          localizations.timerPickerHourLabel(lastSelectedHour ?? selectedHour!) ?? '',
          additionalPadding,
        ),
      ],
    );
  }

  Widget _buildMinutePicker(EdgeInsetsDirectional additionalPadding, Widget? selectionOverlay) {
    _minuteScrollController ??= FixedExtentScrollController(
      initialItem: selectedMinute ~/ widget.minuteInterval,
    );
    return CupertinoPicker(
      scrollController: _minuteScrollController,
      magnification: _kMagnification,
      offAxisFraction: _calculateOffAxisFraction(
        additionalPadding.start,
        widget.mode == CupertinoTimerPickerMode.ms ? 0 : 1,
      ),
      itemExtent: widget.itemExtent,
      backgroundColor: widget.backgroundColor,
      squeeze: _kSqueeze,
      looping: true,
      onSelectedItemChanged: (int index) {
        setState(() {
          selectedMinute = index * widget.minuteInterval;
          widget.onTimerDurationChanged(
            Duration(
              hours: selectedHour ?? 0,
              minutes: selectedMinute,
              seconds: selectedSecond ?? 0,
            ),
          );
        });
      },
      selectionOverlay: selectionOverlay,
      children: List<Widget>.generate(60 ~/ widget.minuteInterval, (int index) {
        final int minute = index * widget.minuteInterval;
        final String label = localizations.timerPickerMinuteLabel(minute) ?? '';
        final String semanticsLabel = textDirectionFactor == 1
            ? localizations.timerPickerMinute(minute) + label
            : label + localizations.timerPickerMinute(minute);

        return Semantics(
          label: semanticsLabel,
          excludeSemantics: true,
          child: _buildPickerNumberLabel(
            localizations.timerPickerMinute(minute),
            additionalPadding,
          ),
        );
      }),
    );
  }

  Widget _buildMinuteColumn(EdgeInsetsDirectional additionalPadding, Widget? selectionOverlay) {
    additionalPadding = EdgeInsetsDirectional.only(
      start: math.max(additionalPadding.start, 0),
      end: math.max(additionalPadding.end, 0),
    );

    return Stack(
      children: <Widget>[
        NotificationListener<ScrollEndNotification>(
          onNotification: (ScrollEndNotification notification) {
            setState(() {
              lastSelectedMinute = selectedMinute;
            });
            return false;
          },
          child: _buildMinutePicker(additionalPadding, selectionOverlay),
        ),
        _buildLabel(
          localizations.timerPickerMinuteLabel(lastSelectedMinute ?? selectedMinute) ?? '',
          additionalPadding,
        ),
      ],
    );
  }

  Widget _buildSecondPicker(EdgeInsetsDirectional additionalPadding, Widget? selectionOverlay) {
    _secondScrollController ??= FixedExtentScrollController(
      initialItem: selectedSecond! ~/ widget.secondInterval,
    );
    return CupertinoPicker(
      scrollController: _secondScrollController,
      magnification: _kMagnification,
      offAxisFraction: _calculateOffAxisFraction(
        additionalPadding.start,
        widget.mode == CupertinoTimerPickerMode.ms ? 1 : 2,
      ),
      itemExtent: widget.itemExtent,
      backgroundColor: widget.backgroundColor,
      squeeze: _kSqueeze,
      looping: true,
      onSelectedItemChanged: (int index) {
        setState(() {
          selectedSecond = index * widget.secondInterval;
          widget.onTimerDurationChanged(
            Duration(hours: selectedHour ?? 0, minutes: selectedMinute, seconds: selectedSecond!),
          );
        });
      },
      selectionOverlay: selectionOverlay,
      children: List<Widget>.generate(60 ~/ widget.secondInterval, (int index) {
        final int second = index * widget.secondInterval;
        final String label = localizations.timerPickerSecondLabel(second) ?? '';
        final String semanticsLabel = textDirectionFactor == 1
            ? localizations.timerPickerSecond(second) + label
            : label + localizations.timerPickerSecond(second);

        return Semantics(
          label: semanticsLabel,
          excludeSemantics: true,
          child: _buildPickerNumberLabel(
            localizations.timerPickerSecond(second),
            additionalPadding,
          ),
        );
      }),
    );
  }

  Widget _buildSecondColumn(EdgeInsetsDirectional additionalPadding, Widget? selectionOverlay) {
    additionalPadding = EdgeInsetsDirectional.only(
      start: math.max(additionalPadding.start, 0),
      end: math.max(additionalPadding.end, 0),
    );

    return Stack(
      children: <Widget>[
        NotificationListener<ScrollEndNotification>(
          onNotification: (ScrollEndNotification notification) {
            setState(() {
              lastSelectedSecond = selectedSecond;
            });
            return false;
          },
          child: _buildSecondPicker(additionalPadding, selectionOverlay),
        ),
        _buildLabel(
          localizations.timerPickerSecondLabel(lastSelectedSecond ?? selectedSecond!) ?? '',
          additionalPadding,
        ),
      ],
    );
  }

  // Returns [CupertinoTextThemeData.pickerTextStyle] and magnifies the fontSize
  // by [magnification].
  TextStyle _textStyleFrom(BuildContext context, [double magnification = 1.0]) {
    final TextStyle textStyle = CupertinoTheme.of(context).textTheme.pickerTextStyle;
    return textStyle.copyWith(
      color: CupertinoDynamicColor.maybeResolve(textStyle.color, context),
      fontSize: textStyle.fontSize! * magnification,
    );
  }

  // Calculate the number label center point by padding start and position to
  // get a reasonable offAxisFraction.
  double _calculateOffAxisFraction(double paddingStart, int position) {
    final double centerPoint = paddingStart + (numberLabelWidth / 2);

    // Compute the offAxisFraction needed to be straight within the pickerColumn.
    final double pickerColumnOffAxisFraction = 0.5 - centerPoint / pickerColumnWidth;
    // Position is to calculate the reasonable offAxisFraction in the picker.
    final double timerPickerOffAxisFraction = 0.5 - (centerPoint + pickerColumnWidth * position) / totalWidth;
    return (pickerColumnOffAxisFraction - timerPickerOffAxisFraction) * textDirectionFactor;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // The timer picker can be divided into columns corresponding to hour,
        // minute, and second. Each column consists of a scrollable and a fixed
        // label on top of it.
        List<Widget> columns;

        if (widget.mode == CupertinoTimerPickerMode.hms) {
          // Pad the widget to make it as wide as `_kPickerWidth`.
          pickerColumnWidth = _kTimerPickerColumnIntrinsicWidth + (_kTimerPickerHalfColumnPadding * 2);
          totalWidth = pickerColumnWidth * 3;
        } else {
          // The default totalWidth for 2-column modes.
          totalWidth = _kPickerWidth;
          pickerColumnWidth = totalWidth / 2;
        }

        if (constraints.maxWidth < totalWidth) {
          totalWidth = constraints.maxWidth;
          pickerColumnWidth = totalWidth / (widget.mode == CupertinoTimerPickerMode.hms ? 3 : 2);
        }

        final double baseLabelContentWidth = numberLabelWidth + _kTimerPickerLabelPadSize;
        final double minuteLabelContentWidth = baseLabelContentWidth + minuteLabelWidth;

        switch (widget.mode) {
          case CupertinoTimerPickerMode.hm:
            // Pad the widget to make it as wide as `_kPickerWidth`.
            final double hourLabelContentWidth = baseLabelContentWidth + hourLabelWidth;
            double hourColumnStartPadding = pickerColumnWidth - hourLabelContentWidth - _kTimerPickerHalfColumnPadding;
            if (hourColumnStartPadding < _kTimerPickerMinHorizontalPadding) {
              hourColumnStartPadding = _kTimerPickerMinHorizontalPadding;
            }

            double minuteColumnEndPadding =
                pickerColumnWidth - minuteLabelContentWidth - _kTimerPickerHalfColumnPadding;
            if (minuteColumnEndPadding < _kTimerPickerMinHorizontalPadding) {
              minuteColumnEndPadding = _kTimerPickerMinHorizontalPadding;
            }

            Widget? hourSelectionOverlay = _startSelectionOverlay;
            Widget? minuteSelectionOverlay = _endSelectionOverlay;

            if (widget.selectionOverlayBuilder != null) {
              hourSelectionOverlay = widget.selectionOverlayBuilder!(
                context,
                selectedIndex: 0,
                columnCount: 2,
              );
              minuteSelectionOverlay = widget.selectionOverlayBuilder!(
                context,
                selectedIndex: 1,
                columnCount: 2,
              );
            }

            columns = <Widget>[
              _buildHourColumn(
                EdgeInsetsDirectional.only(
                  start: hourColumnStartPadding,
                  end: pickerColumnWidth - hourColumnStartPadding - hourLabelContentWidth,
                ),
                hourSelectionOverlay,
              ),
              _buildMinuteColumn(
                EdgeInsetsDirectional.only(
                  start: pickerColumnWidth - minuteColumnEndPadding - minuteLabelContentWidth,
                  end: minuteColumnEndPadding,
                ),
                minuteSelectionOverlay,
              ),
            ];
          case CupertinoTimerPickerMode.ms:
            final double secondLabelContentWidth = baseLabelContentWidth + secondLabelWidth;
            double secondColumnEndPadding =
                pickerColumnWidth - secondLabelContentWidth - _kTimerPickerHalfColumnPadding;
            if (secondColumnEndPadding < _kTimerPickerMinHorizontalPadding) {
              secondColumnEndPadding = _kTimerPickerMinHorizontalPadding;
            }

            double minuteColumnStartPadding =
                pickerColumnWidth - minuteLabelContentWidth - _kTimerPickerHalfColumnPadding;
            if (minuteColumnStartPadding < _kTimerPickerMinHorizontalPadding) {
              minuteColumnStartPadding = _kTimerPickerMinHorizontalPadding;
            }

            Widget? minuteSelectionOverlay = _startSelectionOverlay;
            Widget? secondSelectionOverlay = _endSelectionOverlay;

            if (widget.selectionOverlayBuilder != null) {
              minuteSelectionOverlay = widget.selectionOverlayBuilder!(
                context,
                selectedIndex: 0,
                columnCount: 2,
              );
              secondSelectionOverlay = widget.selectionOverlayBuilder!(
                context,
                selectedIndex: 1,
                columnCount: 2,
              );
            }

            columns = <Widget>[
              _buildMinuteColumn(
                EdgeInsetsDirectional.only(
                  start: minuteColumnStartPadding,
                  end: pickerColumnWidth - minuteColumnStartPadding - minuteLabelContentWidth,
                ),
                minuteSelectionOverlay,
              ),
              _buildSecondColumn(
                EdgeInsetsDirectional.only(
                  start: pickerColumnWidth - secondColumnEndPadding - minuteLabelContentWidth,
                  end: secondColumnEndPadding,
                ),
                secondSelectionOverlay,
              ),
            ];
          case CupertinoTimerPickerMode.hms:
            final double hourColumnEndPadding =
                pickerColumnWidth - baseLabelContentWidth - hourLabelWidth - _kTimerPickerMinHorizontalPadding;
            final double minuteColumnPadding = (pickerColumnWidth - minuteLabelContentWidth) / 2;
            final double secondColumnStartPadding =
                pickerColumnWidth - baseLabelContentWidth - secondLabelWidth - _kTimerPickerMinHorizontalPadding;

            Widget? hourSelectionOverlay = _startSelectionOverlay;
            Widget? minuteSelectionOverlay = _centerSelectionOverlay;
            Widget? secondSelectionOverlay = _endSelectionOverlay;

            if (widget.selectionOverlayBuilder != null) {
              hourSelectionOverlay = widget.selectionOverlayBuilder!(
                context,
                selectedIndex: 0,
                columnCount: 3,
              );
              minuteSelectionOverlay = widget.selectionOverlayBuilder!(
                context,
                selectedIndex: 1,
                columnCount: 3,
              );
              secondSelectionOverlay = widget.selectionOverlayBuilder!(
                context,
                selectedIndex: 2,
                columnCount: 3,
              );
            }

            columns = <Widget>[
              _buildHourColumn(
                EdgeInsetsDirectional.only(
                  start: _kTimerPickerMinHorizontalPadding,
                  end: math.max(hourColumnEndPadding, 0),
                ),
                hourSelectionOverlay,
              ),
              _buildMinuteColumn(
                EdgeInsetsDirectional.only(start: minuteColumnPadding, end: minuteColumnPadding),
                minuteSelectionOverlay,
              ),
              _buildSecondColumn(
                EdgeInsetsDirectional.only(
                  start: math.max(secondColumnStartPadding, 0),
                  end: _kTimerPickerMinHorizontalPadding,
                ),
                secondSelectionOverlay,
              ),
            ];
        }

        Widget contents = SizedBox(
          width: totalWidth,
          height: _kPickerHeight,
          child: DefaultTextStyle(
            style: _textStyleFrom(context),
            child: Row(
              children: columns.map((Widget child) => Expanded(child: child)).toList(growable: false),
            ),
          ),
        );
        final Color? color = CupertinoDynamicColor.maybeResolve(widget.backgroundColor, context);
        if (color != null) {
          contents = ColoredBox(color: color, child: contents);
        }

        final CupertinoThemeData themeData = CupertinoTheme.of(context);

        // Text scaling is fixed to match the native iOS date picker.
        return MediaQuery.withNoTextScaling(
          child: CupertinoTheme(
            data: themeData.copyWith(
              textTheme: themeData.textTheme.copyWith(
                pickerTextStyle: _textStyleFrom(context, _kTimerPickerMagnification),
              ),
            ),
            child: Align(alignment: widget.alignment, child: contents),
          ),
        );
      },
    );
  }
}
