import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'widgets/feed_post_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        actions: [
          Obx(() {
            final busy = controller.isLoggingOut.value;
            return IconButton.filledTonal(
              onPressed: busy ? null : controller.logout,
              icon: busy
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: scheme.primary,
                      ),
                    )
                  : const Icon(Icons.logout_rounded),
              tooltip: 'Sair',
            );
          }),
          IconButton.filledTonal(
            onPressed: controller.fetchFeed,
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Atualizar feed',
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded),
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
        if (controller.isLoading.value && controller.feed.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.feed.isEmpty) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: scheme.primary.withValues(
                            alpha: 0.12,
                          ),
                          child: Icon(
                            Icons.inbox_outlined,
                            color: scheme.primary,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Nada por aqui',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Puxe para atualizar ou toque em “Atualizar”.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: controller.fetchFeed,
                            icon: const Icon(Icons.refresh_rounded),
                            label: const Text('Atualizar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchFeed,
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
            itemCount: controller.feed.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, i) {
              final item = controller.feed[i];
              return Obx(
                () => FeedPostCard(
                  item: item,
                  liked: controller.isLiked(item.post.id),
                  saved: controller.isSaved(item.post.id),
                  onToggleLike: () => controller.toggleLike(item.post.id),
                  onToggleSave: () => controller.toggleSave(item.post.id),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
