import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked_annotations.dart';

import '../localization/localization_service.dart';

extension FirstWhereExt<T> on List<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

/// 小部件扩展
extension WidgetExtension on Widget {
  Widget sizedBox({double? height, double? width}) {
    return SizedBox(height: height, width: width, child: this);
  }

  Widget opacity(double value) {
    return Opacity(opacity: value, child: this);
  }

  Widget clipRRect({BorderRadius radius = BorderRadius.zero}) {
    return ClipRRect(
      borderRadius: radius,
      child: this,
    );
  }

  Widget nullWidget<T>(
    T? value, {
    Widget placeHolder = const SizedBox(),
    bool Function(T)? predict,
  }) {
    return NullWidget<T>(
      value,
      builder: (_, __) {
        return this;
      },
      predict: predict,
      placeHolder: placeHolder,
    );
  }

  Widget gestureDetector({void Function()? onTap}) {
    return GestureDetector(onTap: onTap, child: this);
  }

  Widget inkWell({void Function()? onTap}) {
    return InkWell(
      onTap: onTap, child: this, splashColor: Colors.transparent, //去掉水波纹效果
      highlightColor: Colors.transparent, //去掉长按效果
    );
  }

  Widget safeArea({
    bool left = true,
    bool top = true,
    bool right = true,
    bool bottom = true,
    EdgeInsets minimum = EdgeInsets.zero,
    bool maintainBottomViewPadding = false,
  }) {
    return SafeArea(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      minimum: minimum,
      maintainBottomViewPadding: maintainBottomViewPadding,
      child: this,
    );
  }

  Widget get center => Center(child: this);

  Widget position({
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? width,
    double? height,
  }) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      width: width,
      height: height,
      child: this,
    );
  }

  Widget positionFill({
    double? left = 0,
    double? top = 0,
    double? right = 0,
    double? bottom = 0,
  }) {
    return Positioned.fill(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: this,
    );
  }

  Widget padding({required EdgeInsetsGeometry padding}) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  Widget expanded({int flex = 1}) {
    return Expanded(
      flex: flex,
      child: this,
    );
  }

  Widget get flexible => Flexible(child: this);

  SliverToBoxAdapter get sliverToBoxAdapter => SliverToBoxAdapter(child: this);

  Widget singleScrollView({
    ScrollController? controller,
    ScrollPhysics? physics,
    Axis scrollDirection = Axis.vertical,
  }) {
    return SingleChildScrollView(
      scrollDirection: scrollDirection,
      physics: physics,
      controller: controller,
      child: this,
    );
  }

  Widget get ignorePointer => IgnorePointer(child: this);

  Widget get offstage => Offstage(offstage: true, child: this);

  Widget cupertinoButton({
    VoidCallback? onTap,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double? miniSize,
  }) {
    return CupertinoButton(
      onPressed: onTap,
      child: this,
      padding: padding,
      minSize: miniSize,
    );
  }

  Widget transformScaleX(double scale) {
    return Transform(
      transform: Matrix4.diagonal3Values(scale, 1.0, 1.0),
      child: this,
    );
  }

  Widget transformScaleY(double scale) {
    return Transform(
      transform: Matrix4.diagonal3Values(1.0, scale, 1.0),
      child: this,
    );
  }

  Widget transformScale(double scale) {
    return Transform.scale(scale: scale, child: this);
  }
}

class NullWidget<T> extends StatelessWidget {
  const NullWidget(
    this.value, {
    super.key,
    required this.builder,
    this.placeHolder = const SizedBox(),
    this.predict,
  });

  final T? value;
  final Widget Function(BuildContext, T) builder;
  final Widget placeHolder;
  final bool Function(T)? predict;

  @override
  Widget build(BuildContext context) {
    if (value == null || (predict?.call(this.value as T) ?? false)) {
      return placeHolder;
    } else {
      return builder(context, value as T);
    }
  }
}

/// add Padding Property to widget
extension WidgetPaddingX on Widget {
  Widget paddingAll(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);

  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
        ),
        child: this,
      );

  Widget get paddingZero => Padding(padding: EdgeInsets.zero, child: this);
}

/// Add margin property to widget
extension WidgetMarginX on Widget {
  Widget marginAll(double margin) =>
      Container(margin: EdgeInsets.all(margin), child: this);

  Widget marginSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget marginOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Container(
        margin: EdgeInsets.only(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
        ),
        child: this,
      );

  Widget get marginZero => Container(margin: EdgeInsets.zero, child: this);
}

/// Allows you to insert widgets inside a CustomScrollView
extension WidgetSliverBoxX on Widget {
  Widget get sliverBox => SliverToBoxAdapter(child: this);
}

extension IntExt on int? {
  DateTime? toDate() {
    return this == null ? null : DateTime.fromMillisecondsSinceEpoch(this!);
  }
}

/// Resolves app locale for date/time formatting (e.g. "en", "en_US"). Returns null if not available.
String? _dateFormatLocale() {
  try {
    return StackedLocator.instance<LocalizationService>().locale.toString();
  } catch (_) {
    return null;
  }
}

extension DateExt on DateTime? {
  String? toFullDisplay() {
    if (this == null) return null;
    final formatter =
        DateFormat("EEE, d MMM yyyy 'at' h:mm a", _dateFormatLocale());
    final utc = this!.toUtc();
    return formatter.format(utc);
  }

  String? toDate({bool isUTC = false}) {
    if (this == null) return null;
    final formatter = DateFormat('d MMM yyyy h:mm a', _dateFormatLocale());
    final utc = isUTC ? this!.toUtc() : this!;
    return formatter.format(utc);
  }

  String? toDateEEEdMMMYYYDisplay({bool isUTC = false}) {
    if (this == null) return null;
    final formatter = DateFormat('EEE, d MMM yyyy', _dateFormatLocale());
    final utc = isUTC ? this!.toUtc() : this!;
    return formatter.format(utc);
  }

  String? toDateDMMMYYYYDisplay({bool isUTC = false, String? locale}) {
    if (this == null) return null;
    final formatter = DateFormat('d MMM yyyy', locale ?? _dateFormatLocale());
    final utc = isUTC ? this!.toUtc() : this!;
    return formatter.format(utc);
  }

  String? toDDMMMYYYYDisplay({bool isUTC = false}) {
    if (this == null) return null;
    final formatter = DateFormat('dd/MMM/yyyy', _dateFormatLocale());
    final utc = isUTC ? this!.toUtc() : this!;
    return formatter.format(utc);
  }

  String? toTimeDisplay({bool isUTC = false}) {
    if (this == null) return null;
    final formatter = DateFormat('h:mm a', _dateFormatLocale());
    final utc = isUTC ? this!.toUtc() : this!;
    return formatter.format(utc);
  }
}
