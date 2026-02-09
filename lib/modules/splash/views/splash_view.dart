import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              scheme.primary.withValues(alpha: 0.10),
              scheme.surface,
              scheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor:
                                  scheme.primary.withValues(alpha: 0.12),
                              child: Icon(
                                Icons.phone_iphone_rounded,
                                color: scheme.primary,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Phone Validation',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Preparando tudo pra você…',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: scheme.onSurfaceVariant),
                            ),
                            const SizedBox(height: 18),
                            const LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    );
                  }

                  final err = controller.error.value;
                  if (err != null) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor:
                                  scheme.error.withValues(alpha: 0.12),
                              child: Icon(
                                Icons.error_outline_rounded,
                                color: scheme.error,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Ops…',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              err,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: scheme.onSurfaceVariant),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed: controller.retry,
                                icon: const Icon(Icons.refresh_rounded),
                                label: const Text('Tentar novamente'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
