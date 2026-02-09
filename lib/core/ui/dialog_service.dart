import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogService {
  void showError({
    String title = 'Erro',
    required String message,
  }) {
    if (Get.isDialogOpen == true) Get.back();

    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text('OK'),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }
}
