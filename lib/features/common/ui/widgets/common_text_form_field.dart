import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../extensions/build_context_extension.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme.dart';
import '../../../../theme/gaps.dart';
import 'common_text_form_view.dart';

class CommonTextFormField extends StatefulWidget {
  final String? label;
  final String? titleLabel;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? errorText;
  final bool isPassword;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool enable;
  final String? initialValue;
  final int? maxLines;
  final Color? bgColor;

  const CommonTextFormField(
      {super.key,
      this.label,
      this.titleLabel,
      this.controller,
      this.validator,
      this.errorText,
      this.isPassword = false,
      this.keyboardType,
      this.suffixIcon,
      this.enable = true,
      this.initialValue,
      this.maxLines,
      this.bgColor});

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  bool _isObscure = false;
  String? _errorText;
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isPassword;
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.titleLabel != null) ...[
            Text(widget.titleLabel!,
                style: AppTheme.titleExtraSmall14.copyWith(
                    color: context.isDarkMode
                        ? AppColors.mono60
                        : AppColors.mono90)),
            gap0_5
          ],
          widget.enable
              ? TextFormField(
                  initialValue: widget.initialValue,
                  // enabled: widget.enable,
                  // onTap: widget.enable ? null : (){},
                  controller: widget.controller,
                  validator: widget.validator,
                  obscureText: _isObscure,
                  keyboardType: widget.keyboardType,
                  maxLines: _isObscure ? 1 : widget.maxLines,
                  decoration: InputDecoration(
                    fillColor:
                        context.isDarkMode ? AppColors.mono90 : AppColors.mono0,
                    isDense: true,
                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                    // Keep the label at the top
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.sp),
                      ),
                    ),
                    alignLabelWithHint: true,
                    filled: true,
                    // fillColor: Colors.white,
                    labelText: widget.label,
                    labelStyle: AppTheme.bodyLarge16.copyWith(
                      color: context.isDarkMode
                          ? AppColors.mono20
                          : AppColors.mono90,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.sp),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.mono40),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.sp),
                      ), // Normal state
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.blueberry100, width: 2.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.sp),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.sp),
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.sp),
                      ),
                    ),
                    suffixIcon: widget.isPassword
                        ? IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: context.isDarkMode
                                  ? AppColors.mono20
                                  : AppColors.mono90,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          )
                        : widget.suffixIcon,
                    errorText:
                        widget.enable ? (widget.errorText ?? _errorText) : null,
                    errorStyle: AppTheme.bodySmall12
                        .copyWith(color: AppColors.rambutan100),
                  ),
                  onChanged: (value) {
                    final error =
                        widget.validator?.call(widget.controller?.text);
                    if (error == null) {
                      setState(() {
                        _errorText = null;
                      });
                    }
                  },
                  focusNode: _focus,
                  style: widget.enable
                      ? TextStyle(
                          color: context.isDarkMode
                              ? AppColors.mono0
                              : Colors.black,
                        )
                      : null,
                )
              : CommonTextFormView(
                  text: widget.initialValue ?? widget.controller?.text ?? "",
                  bgColor: widget.bgColor,
                  maxLines: widget.maxLines,
                )
        ],
      ),
    );
  }

  void _onFocusChange() {
    if (!_focus.hasFocus) {
      if (!widget.isPassword && widget.controller != null) {
        widget.controller!.text = widget.controller!.text.trim();
      }
      setState(() {
        _errorText = widget.validator?.call(widget.controller?.text);
      });
    }
  }
}
