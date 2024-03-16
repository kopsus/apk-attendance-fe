import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DistroTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final String? initialValue;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function()? onCompleted;

  const DistroTextField({
    super.key, 
    this.controller,
    this.placeholder,
    this.initialValue,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onCompleted
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      initialValue: initialValue,
      obscureText: obscureText,
      onChanged: onChanged,
      onEditingComplete: onCompleted,
      validator: validator,
      style: DistroTypography.bodySmallRegular.copyWith(
        color: DistroColors.tertiary_500
      ),
      cursorColor: DistroColors.primary_500,
      cursorErrorColor: DistroColors.warning_500,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        hintText: placeholder,
        hintStyle: DistroTypography.bodySmallSemiBold.copyWith(
          color: DistroColors.tertiary_300,
        ),
        filled: true,
        fillColor: DistroColors.tertiary_100,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: DistroColors.tertiary_200)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: DistroColors.tertiary_200)
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: DistroColors.warning_500)
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: DistroColors.warning_500)
        ),
        suffixIcon: suffixIcon
      ),
    );
  }
}