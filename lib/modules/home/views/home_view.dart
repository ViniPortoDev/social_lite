import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final c = Get.find<HomeController>();
  final phoneCtrl = TextEditingController();
  final countryCtrl = TextEditingController(text: 'BR');

  @override
  void dispose() {
    phoneCtrl.dispose();
    countryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: phoneCtrl,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Telefone',
                hintText: '+55 88 99999-9999',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: countryCtrl,
              decoration: const InputDecoration(
                labelText: 'Default country (ex: BR)',
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: c.isLoading.value
                      ? null
                      : () => c.validatePhone(
                          phone: phoneCtrl.text.trim(),
                          defaultCountry: countryCtrl.text.trim().isEmpty
                              ? 'BR'
                              : countryCtrl.text.trim(),
                        ),
                  child: c.isLoading.value
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Validar telefone'),
                ),
              );
            }),
            const SizedBox(height: 16),
            Obx(() {
              if (c.error.value != null) {
                return Text(
                  c.error.value!,
                  style: const TextStyle(color: Colors.red),
                );
              }

              final r = c.result.value;
              if (r == null) return const SizedBox.shrink();

              final valid = r.phoneValid == true;
              return Card(
                child: ListTile(
                  title: Text(valid ? 'Válido ✅' : 'Inválido ❌'),
                  subtitle: Text(
                    'País: ${r.countryCode ?? "-"} (+${r.countryPrefix ?? "-"})\n'
                    'Tipo: ${r.phoneType ?? "-"}\n'
                    'Operadora: ${r.carrier ?? "-"}\n'
                    'Número: ${r.phone ?? "-"}',
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
