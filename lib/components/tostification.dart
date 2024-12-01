import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast(BuildContext context, Map<String, dynamic> response) {
  ToastificationType type;
  if (response['status_code'] == 200 || response['status_code'] == 201) {
    type = ToastificationType.success;
  } else {
    type = ToastificationType.error;
  }

  toastification.show(
    context: context,
    title: Text(type == ToastificationType.success ? "Successo!" : "Erro!"),
    description: Text(response['data']),
    type: type,
    autoCloseDuration: const Duration(seconds: 3),
    animationDuration: const Duration(milliseconds: 300),
  );
}
