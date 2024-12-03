import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.label,
    this.controller,
    this.hintText,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.labelStyle,
    this.suffixIcon,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.enabled = true,
    this.backgroundColor,
    this.filled = false,
    this.borderColor = Colors.white,
    super.key,
  });

  final bool enabled;
  final TextEditingController? controller;
  final String label;
  final bool obscureText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? hintText;
  final Color? backgroundColor;
  final bool filled;
  final Color borderColor;
  final TextStyle? labelStyle;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      enabled: enabled,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      controller: controller,
      style: theme.textTheme.bodyMedium,
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: theme.colorScheme.onSurface,
      decoration: InputDecoration(
        fillColor: backgroundColor,
        suffixIcon: suffixIcon,
        filled: filled,
        hintText: hintText,
        label: Text(
          label,
          style: labelStyle ??
              theme.textTheme.bodyMedium!.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
        ),
        disabledBorder: theme.inputDecorationTheme.border!.copyWith(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.inverseSurface),
        ),
        border: theme.inputDecorationTheme.border,
        labelStyle: theme.textTheme.bodyMedium,
        focusedBorder: theme.inputDecorationTheme.focusedBorder,
        hintStyle: theme.inputDecorationTheme.hintStyle?.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(0.6),
        ),
      ),
      validator: validator,
    );
  }
}
