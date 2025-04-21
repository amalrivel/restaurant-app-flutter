import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/restaurant_detail.dart';

class MenuTab extends StatelessWidget {
  final Menus menus;

  const MenuTab({super.key, required this.menus});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildMenuSection(
          context,
          title: 'Foods',
          icon: Icons.restaurant,
          items: menus.foods,
          color: Theme.of(context).colorScheme.primary,
        ),

        const Divider(height: 32),

        _buildMenuSection(
          context,
          title: 'Drinks',
          icon: Icons.local_cafe,
          items: menus.drinks,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ],
    );
  }

  Widget _buildMenuSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<MenuItem> items,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: color.withOpacity(0.2),
                  child: Icon(icon, color: color),
                ),
                title: Text(items[index].name),
              ),
            );
          },
        ),
      ],
    );
  }
}
