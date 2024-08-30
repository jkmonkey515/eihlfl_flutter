import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/spacer.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.hint,
    required this.label,
    this.autoFocus,
    this.focusNode,
    this.autoValidateMode,
    required this.controller,
    required this.validator,
    this.onFieldSubmitted,
    this.textInputType,
    this.textInputAction,
    this.textDirection,
    this.textAlign,
    this.maxLength,
    this.maxLine,
    this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String hint;
  final String label;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final AutovalidateMode? autoValidateMode;
  final TextEditingController controller;
  final String? Function(String?) validator;
  // final void Function(String)? onChanged;
  // final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final int? maxLength;
  final int? maxLine;
  final bool? obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style:
                Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
          ),
          6.0.verticalSpacer,
          TextFormField(
            autocorrect: true,
            autofocus: autoFocus ?? false,
            focusNode: focusNode,
            showCursor: true,
            cursorWidth: 2.0,
            cursorHeight: 20.0,
            cursorColor: Get.theme.colorScheme.primary,
            autovalidateMode: autoValidateMode ?? AutovalidateMode.disabled,
            maxLines: maxLine ?? 1,
            obscureText: obscureText ?? false,
            controller: controller,
            validator: validator,
            onFieldSubmitted: onFieldSubmitted,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            textDirection: textDirection ?? TextDirection.ltr,
            keyboardType: textInputType ?? TextInputType.text,
            textInputAction: textInputAction ?? TextInputAction.done,
            style:
                Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            inputFormatters: [
              if (maxLength != null)
                LengthLimitingTextInputFormatter(maxLength),
            ],
            decoration: InputDecoration(
              isDense: false,
              isCollapsed: false,
              filled: true,
              fillColor: Get.theme.cardColor,
              prefixIcon: prefixIcon,
              // prefixIconColor: const Color(0xff2D2D2D),
              // prefixIconConstraints: BoxConstraints.loose(const Size.square(20.0)),
              suffixIcon: suffixIcon,
              // suffixIconColor: const Color(0xff2D2D2D),
              // suffixIconConstraints: BoxConstraints.loose(const Size.square(20.0)),
              alignLabelWithHint: true,
              // floatingLabelBehavior: FloatingLabelBehavior.always,
              // floatingLabelStyle: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
              // labelText: label,
              // labelStyle: Get.textTheme.bodyLarge?.copyWith(
              //   color: Get.textTheme.bodyLarge?.color?.withOpacity(0.4),
              //   fontWeight: FontWeight.w400,
              // ),
              hintText: hint,
              hintStyle: Get.textTheme.bodyLarge?.copyWith(
                color: Get.textTheme.bodyLarge?.color?.withOpacity(0.4),
                fontWeight: FontWeight.w400,
              ),
              errorMaxLines: 2,
              errorStyle: Get.textTheme.bodySmall
                  ?.copyWith(color: Get.theme.colorScheme.error),
              border: _buildInputBorderEnable(),
              enabledBorder: _buildInputBorderEnable(),
              disabledBorder: _buildInputBorderEnable(),
              focusedBorder: _buildInputBorderEnable(),
              errorBorder: _buildInputBorderEnable(),
              focusedErrorBorder: _buildInputBorderEnable(),
              contentPadding: const EdgeInsets.all(16.0),
            ),
          ),
        ]);
  }

  InputBorder _buildInputBorderEnable() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: BorderSide(
        color: Get.theme.dividerColor,
        width: 1.0,
      ),
    );
  }
}
