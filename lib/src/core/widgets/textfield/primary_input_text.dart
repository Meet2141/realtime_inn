import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/color_constants.dart';
import '../../constants/size_constants.dart';
import '../../utils/enums.dart';

typedef InputValidator = String? Function(String?)?;

class PrimaryInputText extends StatelessWidget {
  const PrimaryInputText({
    super.key,
    this.labelText,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.isEnabled = true,
    this.isDense = false,
    this.readOnly = false,
    this.inputBorder = InputBorderType.outline,
    this.contentPadding,
    this.borderRadius = SizeConstants.medium / 2,
    this.borderWidth = 1,
    this.height,
    this.focusedBorderColor,
    this.fillColor,
    this.inputColor,
    this.labelColor,
    this.enabledBorderColor,
    this.onTap,
  });

  final String? labelText;
  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final InputValidator validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool isEnabled;
  final bool isDense;
  final bool readOnly;
  final InputBorderType inputBorder;
  final EdgeInsetsGeometry? contentPadding;
  final double borderRadius;
  final double borderWidth;
  final double? height;
  final Color? focusedBorderColor;
  final Color? fillColor;
  final Color? inputColor;
  final Color? labelColor;
  final Color? enabledBorderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        enabled: isEnabled,
        readOnly: readOnly,
        onTap: onTap,
        style: TextStyle(
          fontSize: SizeConstants.small,
          color: isEnabled ? inputColor : ColorConstants.black,
        ),
        decoration: InputDecoration(
          isDense: isDense,
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(
                vertical: SizeConstants.extraLarge / 2,
                horizontal: SizeConstants.medium,
              ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: SizeConstants.small,
            color: isEnabled ? labelColor : ColorConstants.secondary,
          ),
          fillColor: fillColor,
          filled: fillColor != null,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: getInputBorder(inputBorder, ColorConstants.primary),
          enabledBorder: getInputBorder(inputBorder, enabledBorderColor ?? ColorConstants.secondary),
          focusedBorder: getInputBorder(inputBorder, focusedBorderColor ?? ColorConstants.primary),
          errorBorder: getInputBorder(inputBorder, ColorConstants.red),
          focusedErrorBorder: getInputBorder(inputBorder, ColorConstants.red),
          errorStyle: const TextStyle(color: ColorConstants.red),
        ),
      ),
    );
  }

  InputBorder getInputBorder(InputBorderType inputBorderType, Color color) {
    switch (inputBorderType) {
      case InputBorderType.none:
        return InputBorder.none;
      case InputBorderType.underline:
        return UnderlineInputBorder(
          borderSide: BorderSide(width: borderWidth, color: color),
        );
      case InputBorderType.outline:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(width: borderWidth, color: color),
        );
    }
  }
}
