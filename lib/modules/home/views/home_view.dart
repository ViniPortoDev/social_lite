import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          Obx(() {
            final busy = controller.isLoggingOut.value;
            return IconButton(
              onPressed: busy ? null : controller.logout,
              icon: busy
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.logout),
              tooltip: 'Sair',
            );
          }),
          IconButton(
            onPressed: controller.fetchPosts,
            icon: const Icon(Icons.refresh),
            tooltip: 'Atualizar posts',
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'immediate':
                  controller.testImmediateNotification();
                  break;
                case 'scheduled':
                  controller.testScheduledNotification();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'immediate',
                child: Row(
                  children: [
                    Icon(Icons.notifications_active),
                    SizedBox(width: 8),
                    Text('Notificação Imediata'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'scheduled',
                child: Row(
                  children: [
                    Icon(Icons.schedule),
                    SizedBox(width: 8),
                    Text('Agendar em 10s'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.posts.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.fetchPosts,
          child: ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: controller.posts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, i) {
              final p = controller.posts[i];
              return Card(
                child: ListTile(
                  title: Text(p.title),
                  subtitle: Text(
                    p.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
