import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/restaurant_detail.dart';

class OverviewTab extends StatelessWidget {
  final RestaurantDetail restaurant;

  const OverviewTab({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Address',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(restaurant.address, style: Theme.of(context).textTheme.bodyMedium),

        const Divider(height: 32),

        Text(
          'Categories',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              restaurant.categories.map((category) {
                return Chip(
                  label: Text(category.name),
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.secondary.withOpacity(0.1),
                  side: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.secondary.withOpacity(0.3),
                  ),
                );
              }).toList(),
        ),

        const Divider(height: 32),

        Text(
          'Description',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          restaurant.description,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
