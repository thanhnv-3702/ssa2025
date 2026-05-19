import 'package:base_core/res/extension.dart';
import 'package:base_core/res/widgets/text.dart';
import 'package:base_core/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TextFieldCs extends StatefulWidget {
  final String hint;
  final String error;
  final Color color;
  final double letterSpacing;
  final double? height;
  final Function()? onSuffixIcon;
  final Function(String)? onChange;
  final Function(String)? onSubmitted;
  final Widget? suffixIcon;
  final List<Widget> suffixPass;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final TextStyle? style;
  final TextStyle? styleHint;
  final TextDecoration textDecoration;
  final TextEditingController controller;
  final Color decorationColor;
  final bool isValid;
  final bool readOnly;
  final Widget preWidget;
  final bool isPassword;
  final TextInputType? keyboard;
  final bool autofocus;
  final bool isDisable;

  const TextFieldCs({
    super.key,
    required this.hint,
    this.error = '',
    this.color = Colors.black,
    this.letterSpacing = 0.0,
    this.height,
    this.isDisable = false,
    this.onChange,
    this.onSubmitted,
    this.inputFormatters,
    this.suffixIcon,
    this.preWidget = const SizedBox(),
    required this.controller,
    this.style,
    this.styleHint,
    this.onSuffixIcon,
    this.suffixPass = const [SizedBox(), SizedBox()],
    this.maxLines = 1,
    this.readOnly = false,
    this.isValid = true,
    this.isPassword = false,
    this.textDecoration = TextDecoration.none,
    this.decorationColor = Colors.black,
    this.textAlign,
    this.keyboard,
    this.autofocus = false,
  });

  @override
  State<TextFieldCs> createState() => _TextFieldCsState();
}

class _TextFieldCsState extends State<TextFieldCs> {
  bool _showPass = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() => setState(() {}));
  }

  /// TextInputFormatter to filter out emoji characters
  static final _emojiFilter = FilteringTextInputFormatter.deny(
    RegExp(
      r'[\u{1F300}-\u{1F9FF}]|[\u{2600}-\u{26FF}]|[\u{2700}-\u{27BF}]|[\u{1F600}-\u{1F64F}]|[\u{1F680}-\u{1F6FF}]|[\u{1F1E0}-\u{1F1FF}]|[\u{1F900}-\u{1F9FF}]|[\u{1FA00}-\u{1FA6F}]|[\u{1FA70}-\u{1FAFF}]',
      unicode: true,
    ),
  );

  /// TextInputFormatter to only allow ASCII alphanumeric and special characters for password
  /// Allows: a-z, A-Z, 0-9, and common special characters: !@#$%^&*(),.?":{}|<>[]\-_=+`~;/
  /// Blocks: Hiragana, Katakana, Kanji, full-width characters, and other non-ASCII characters
  static final _passwordAsciiFilter = FilteringTextInputFormatter.allow(
    RegExp(r'[a-zA-Z0-9!@#$%^&*(),.?":{}|<>\[\]\\\-_=+`~;/]'),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Focus(
          child: Builder(
            builder: (context) {
              final isFocused = Focus.of(context).hasFocus;
              return Container(
                height: widget.height ?? 48.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: widget.isDisable ? AppColors.skyLightest : null,
                  border: Border.all(
                    color: widget.isValid
                        ? (widget.readOnly
                            ? AppColors.skyLight
                            : (isFocused ? AppColors.greenBase : AppColors.skyLight))
                        : AppColors.redBase,
                    width: 1.h,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.r),
                  ),
                ),
                child: Row(
                  children: [
                    widget.preWidget,
                    Expanded(
                      child: TextField(
                        controller: widget.controller,
                        keyboardType: widget.isPassword ? TextInputType.visiblePassword : widget.keyboard,
                        readOnly: widget.readOnly,
                        autofocus: widget.autofocus,
                        textAlignVertical: TextAlignVertical.center,
                        obscureText: widget.isPassword && !_showPass,
                        inputFormatters: widget.isPassword
                            ? [
                                _passwordAsciiFilter,
                                ...?widget.inputFormatters,
                                _emojiFilter,
                              ]
                            : widget.inputFormatters,
                        onChanged: widget.onChange,
                        onSubmitted: widget.onSubmitted,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: widget.readOnly ? null : widget.hint,
                          labelStyle: widget.styleHint,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText: !widget.readOnly && isFocused ? '' : widget.hint,
                          hintStyle: widget.styleHint,
                          suffixIcon:
                              widget.isDisable == false && (widget.readOnly || widget.controller.text.isNotEmpty)
                                  ? (widget.isPassword
                                      ? (widget.suffixPass[_showPass ? 1 : 0].inkWell(onTap: _showHidePass))
                                      : widget.suffixIcon ??
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            icon: Container(
                                              width: 24.w,
                                              height: 24.w,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: widget.styleHint?.color,
                                              ),
                                              child: Icon(
                                                Icons.close,
                                                size: 16,
                                                color: AppColors.white,
                                              ),
                                            ),
                                            onPressed: widget.onSuffixIcon ??
                                                () {
                                                  widget.controller.clear();
                                                },
                                          ))
                                  : null,
                          suffixIconConstraints: BoxConstraints(
                            maxWidth: 24.h,
                            maxHeight: 24.h,
                          ),
                        ),
                        textAlign: widget.textAlign ?? TextAlign.start,
                        maxLines: widget.maxLines,
                        style: widget.style,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        if (widget.error.isNotEmpty && !widget.isValid) Gap(5.h),
        if (widget.error.isNotEmpty && !widget.isValid)
          TextCs(
            text: widget.error,
            style: AppFonts.small500.copyWith(color: AppColors.redBase),
          ),
      ],
    );
  }

  void _showHidePass() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}
