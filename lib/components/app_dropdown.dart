import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/spacer.dart';

class AppDropdown extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.hint,
    required this.label,
    this.autoFocus,
    this.focusNode,
    this.autoValidateMode,
    required this.validator,
    this.defaultValue,
    required this.values,
    required this.onChange,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String hint;
  final String label;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final AutovalidateMode? autoValidateMode;
  final String? Function(String?) validator;
  final String? defaultValue;
  final List<String> values;
  final void Function(String?) onChange;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return _buildDropdown(context);
  }

  Widget _buildDropdown(BuildContext context) {
    var items = values.map((element) {
      return DropdownMenuItem(
        value: element,
        child: Text(
          element,
          style:
              Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
          maxLines: 1,
        ),
      );
    }).toList();

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
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField(
              onChanged: onChange,
              value: defaultValue,
              items: items,
              validator: validator,
              autovalidateMode: autoValidateMode,
              autofocus: autoFocus ?? false,
              focusNode: focusNode,
              isExpanded: true,
              icon: Icon(
                Icons.expand_more_rounded,
                color: Get.theme.iconTheme.color,
              ),
              style: Get.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
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
