import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilesPage extends StatefulWidget {
  const FilesPage({super.key});

  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  List<String> recentFiles = [];

  @override
  void initState() {
    super.initState();
    loadRecentFiles();
  }

  Future<void> loadRecentFiles() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      recentFiles = prefs.getStringList('recent_pdfs') ?? [];
    });
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('recent_pdfs');

    setState(() {
      recentFiles.clear();
    });
  }

  String getFileName(String path) {
    return path.split('/').last;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recent Files",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            IconButton(
              onPressed: clearHistory,
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),

        const SizedBox(height: 20),

        if (recentFiles.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 80),
              child: Text("No PDF history yet"),
            ),
          )
        else
          ...recentFiles.map(
                (path) => Card(
              child: ListTile(
                leading: const Icon(Icons.picture_as_pdf),
                title: Text(getFileName(path)),
                subtitle: Text(path),
                onTap: () {},
              ),
            ),
          ),
      ],
    );
  }
}