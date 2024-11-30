import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String titulo;
  final Function() onPressed;
  final bool? isLoading;

  const CustomOutlinedButton(
      {super.key,
      required this.titulo,
      required this.onPressed,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: const ButtonStyle(),
      child: isLoading!
          ? const CircularProgressIndicator()
          : Text(
              titulo,
              style: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
    );
  }
}
