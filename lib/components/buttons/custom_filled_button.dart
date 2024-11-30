import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final String titulo;
  final bool isLoading;
  final Function() onPressed;
  final Color? textColor;
  const CustomFilledButton({
    super.key,
    required this.titulo,
    required this.onPressed,
    this.isLoading = true,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: const ButtonStyle(),
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(
              titulo,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
    );
  }
}
