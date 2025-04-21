import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text('Settings'),
          elevation: 2,
          backgroundColor: Theme.of(context).colorScheme.primary,
          automaticallyImplyLeading: false,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Consumer<ThemeProvider>(
                  builder: (context, themeProvider, _) {
                    return SwitchListTile(
                      title: const Text('Dark Mode'),
                      subtitle: Text(
                        themeProvider.isDarkMode
                            ? 'Using dark theme'
                            : 'Using light theme',
                      ),
                      secondary: Icon(
                        themeProvider.isDarkMode
                            ? Icons.dark_mode
                            : Icons.light_mode,
                      ),
                      value: themeProvider.isDarkMode,
                      onChanged: (_) {
                        themeProvider.toggleTheme();
                      },
                    );
                  },
                ),
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('About'),
                  subtitle: const Text('v1.0.0'),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'Restaurant App',
                      applicationVersion: '1.0.0',
                      applicationLegalese: '© 2025 amalrivel',
                      children: [
                        const SizedBox(height: 16),
                        const Text(
                          'Dicoding restaurant app for finding best places to eat.',
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
