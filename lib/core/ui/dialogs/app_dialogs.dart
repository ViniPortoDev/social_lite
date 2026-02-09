import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialogs {
  void showError({String title = 'Erro', required String message}) {
    if (Get.isDialogOpen == true) Get.back();

    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [TextButton(onPressed: Get.back, child: const Text('OK'))],
      ),
      barrierDismissible: true,
    );
  }

  Future<void> showSuccess({
    String title = 'Sucesso',
    required String message,
    String buttonText = 'OK',
  }) async {
    if (Get.isDialogOpen == true) Get.back();

    await Get.dialog<void>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text(buttonText),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  Future<bool> confirm({
    required String title,
    required String message,
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
  }) async {
    if (Get.isDialogOpen == true) Get.back();

    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: Text(confirmText),
          ),
        ],
      ),
      barrierDismissible: true,
    );

    return result ?? false;
  }
}
