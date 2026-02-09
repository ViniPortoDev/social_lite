import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/feed_post_model.dart';

class FeedPostCard extends StatelessWidget {
  const FeedPostCard({
    super.key,
    required this.item,
    required this.liked,
    required this.saved,
    required this.onToggleLike,
    required this.onToggleSave,
  });

  final FeedPostModel item;
  final bool liked;
  final bool saved;
  final VoidCallback onToggleLike;
  final VoidCallback onToggleSave;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final comments = item.comments.take(2).toList(growable: false);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: item.profilePhoto.thumbnailUrl,
                  imageBuilder: (context, provider) => CircleAvatar(
                    radius: 18,
                    backgroundColor: scheme.primary.withValues(alpha: 0.12),
                    backgroundImage: provider,
                  ),
                  placeholder: (context, url) => CircleAvatar(
                    radius: 18,
                    backgroundColor: scheme.primary.withValues(alpha: 0.12),
                    child: Icon(
                      Icons.person_rounded,
                      size: 18,
                      color: scheme.primary,
                    ),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: 18,
                    backgroundColor: scheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.person_off_outlined,
                      size: 18,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.user.username.isEmpty
                            ? item.user.name
                            : item.user.username,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Text(
                        item.user.name,
                        style: TextStyle(
                          color: scheme.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(
              imageUrl: item.postPhoto.url,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: scheme.surfaceContainerHighest,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: scheme.surfaceContainerHighest,
                child: Icon(
                  Icons.broken_image_outlined,
                  color: scheme.onSurfaceVariant,
                  size: 32,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: onToggleLike,
                      icon: Icon(
                        liked
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: liked ? scheme.error : null,
                      ),
                      tooltip: 'Curtir',
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.mode_comment_outlined),
                      tooltip: 'Comentar',
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: onToggleSave,
                      icon: Icon(
                        saved
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded,
                        color: saved ? scheme.primary : null,
                      ),
                      tooltip: 'Salvar',
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  item.post.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(
                  item.post.body,
                  style: TextStyle(color: scheme.onSurfaceVariant),
                ),
                if (comments.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text(
                    'Comentários',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 6),
                  for (final c in comments)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text: c.email.split('@').first,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const TextSpan(text: '  '),
                            TextSpan(
                              text: c.body,
                              style: TextStyle(color: scheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
