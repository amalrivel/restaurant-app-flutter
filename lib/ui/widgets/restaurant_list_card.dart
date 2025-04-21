import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/restaurant_image_url.dart';
import 'package:restaurant_app/data/models/restaurant.dart';

class RestaurantListCard extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback onTap;

  const RestaurantListCard({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'restaurant-${restaurant.id}',
              child: Image.network(
                RestaurantImageUrl.medium(restaurant.pictureId),
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => Container(
                      height: 160,
                      color: colorScheme.surfaceVariant,
                      child: Icon(
                        Icons.broken_image,
                        size: 60,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                loadingBuilder: (_, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 160,
                    color: colorScheme.surfaceVariant.withOpacity(0.7),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                        value:
                            loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Hero(
                          tag: 'restaurant-name-${restaurant.id}',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              restaurant.name,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Hero(
                        tag: 'restaurant-rating-${restaurant.id}',
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.secondary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: colorScheme.surface,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  restaurant.rating,
                                  style: TextStyle(
                                    color: colorScheme.background,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Hero(
                    tag: 'restaurant-city-${restaurant.id}',
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            restaurant.city,
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    restaurant.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
