import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final c = Get.find<AuthController>();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(height: 16),
            Obx(() {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: c.isLoading.value
                      ? null
                      : () => c.loginWithEmail(
                          email: emailCtrl.text,
                          password: passCtrl.text,
                        ),
                  child: c.isLoading.value
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Entrar'),
                ),
              );
            }),
            const SizedBox(height: 12),
            Obx(() {
              return SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: c.isLoading.value ? null : c.loginWithGoogle,
                  child: const Text('Entrar com Google'),
                ),
              );
            }),

            const SizedBox(height: 12),
            Obx(() {
              final err = c.error.value;
              if (err == null) return const SizedBox.shrink();
              return Text(err, style: const TextStyle(color: Colors.red));
            }),
          ],
        ),
      ),
    );
  }
}
