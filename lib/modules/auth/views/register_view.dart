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

  final controller = Get.find<RegisterController>();

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
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: Get.back,
                      icon: const Icon(Icons.arrow_back_rounded),
                      tooltip: 'Voltar',
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Criar conta',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Preencha seus dados para continuar',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: scheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: AutofillGroup(
                      child: Column(
                        children: [
                          TextField(
                            controller: nameCtrl,
                            keyboardType: TextInputType.name,
                            autofillHints: const [AutofillHints.name],
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'Nome completo',
                              prefixIcon: Icon(Icons.badge_outlined),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: phoneCtrl,
                            keyboardType: TextInputType.phone,
                            autofillHints: const [
                              AutofillHints.telephoneNumber
                            ],
                            textInputAction: TextInputAction.next,
                            inputFormatters: [phoneMask],
                            decoration: const InputDecoration(
                              labelText: 'Telefone',
                              prefixIcon: Icon(Icons.phone_outlined),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: cpfCtrl,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [cpfMask],
                            decoration: const InputDecoration(
                              labelText: 'CPF',
                              prefixIcon: Icon(Icons.numbers_rounded),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: birthCtrl,
                            keyboardType: TextInputType.datetime,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [birthMask],
                            decoration: const InputDecoration(
                              labelText: 'Data de nascimento',
                              hintText: 'dd/MM/aaaa',
                              prefixIcon: Icon(Icons.cake_outlined),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            textInputAction: TextInputAction.next,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.alternate_email_rounded),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: passCtrl,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            autofillHints: const [AutofillHints.newPassword],
                            textInputAction: TextInputAction.done,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: const InputDecoration(
                              labelText: 'Senha',
                              prefixIcon: Icon(Icons.password_rounded),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Obx(() {
                            final busy = controller.isLoading.value;
                            return SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: busy
                                    ? null
                                    : () => controller.register(
                                          name: nameCtrl.text,
                                          phone: phoneCtrl.text,
                                          cpf: cpfCtrl.text,
                                          birthDate: birthCtrl.text,
                                          email: emailCtrl.text,
                                          password: passCtrl.text,
                                        ),
                                child: busy
                                    ? const SizedBox(
                                        height: 18,
                                        width: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text('Criar conta'),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
