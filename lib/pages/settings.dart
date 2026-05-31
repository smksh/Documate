import 'package:flutter/material.dart';
import '../widgets/ascii_banner.dart';

class SettingsPage extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  const SettingsPage({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [

        const SizedBox(height: 10),

        const AsciiBanner(),

        const SizedBox(height: 20),

        const Text(
          "Settings",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        Card(
          child: SwitchListTile(
            title: const Text("Dark Mode"),
            subtitle: const Text("Use dark theme"),
            value: isDarkMode,
            onChanged: onDarkModeChanged,
            secondary: const Icon(Icons.dark_mode),
          ),
        ),

        const SizedBox(height: 12),

        const Card(
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("About DocuMate"),
            subtitle: Text(
              "A Material 3 PDF tools and document viewer app.",
            ),
          ),
        ),

        const Card(
          child: ListTile(
            leading: Icon(Icons.code),
            title: Text("Built With"),
            subtitle: Text(
              "Flutter, Dart, Material 3",
            ),
          ),
        ),

        const Card(
          child: ListTile(
            leading: Icon(Icons.verified),
            title: Text("Version"),
            subtitle: Text("1.0.0"),
          ),
        ),

      ],
    );
  }
}