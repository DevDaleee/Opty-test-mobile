import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast(BuildContext context, Map<String, dynamic> response) {
  ToastificationType type;

  if (response['success'] == true) {
    type = ToastificationType.success;
  } else {
    type = ToastificationType.error;
  }

  toastification.show(
    context: context,
    title: Text(type == ToastificationType.success ? "Sucesso!" : "Erro!"),
    description: Text(response['message'] ?? "Ocorreu um problema"),
    type: type,
    autoCloseDuration: const Duration(seconds: 3),
    animationDuration: const Duration(milliseconds: 300),
  );
}
