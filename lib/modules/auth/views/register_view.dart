import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../controllers/register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final phoneMask = MaskTextInputFormatter(mask: '(##) #####-####');
  final cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');
  final birthMask = MaskTextInputFormatter(mask: '##/##/####');

  final c = Get.find<RegisterController>();

  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final cpfCtrl = TextEditingController();
  final birthCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    cpfCtrl.dispose();
    birthCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar conta')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Nome completo'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneCtrl,
              keyboardType: TextInputType.phone,
              inputFormatters: [phoneMask],
              decoration: const InputDecoration(labelText: 'Telefone'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: cpfCtrl,
              keyboardType: TextInputType.number,
              inputFormatters: [cpfMask],
              decoration: const InputDecoration(labelText: 'CPF'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: birthCtrl,
              keyboardType: TextInputType.datetime,
              inputFormatters: [birthMask],
              decoration: const InputDecoration(
                labelText: 'Data de nascimento',
              ),
            ),
            const SizedBox(height: 12),
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
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: c.isLoading.value
                      ? null
                      : () => c.register(
                          name: nameCtrl.text,
                          phone: phoneCtrl.text,
                          cpf: cpfCtrl.text,
                          birthDate: birthCtrl.text,
                          email: emailCtrl.text,
                          password: passCtrl.text,
                        ),
                  child: c.isLoading.value
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Criar conta'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
