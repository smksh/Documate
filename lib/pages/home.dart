import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedFile = "No PDF selected";

  Future<void> saveToHistory(String path) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> files = prefs.getStringList('recent_pdfs') ?? [];

    files.remove(path);
    files.insert(0, path);

    if (files.length > 10) {
      files = files.sublist(0, 10);
    }

    await prefs.setStringList('recent_pdfs', files);
  }

  Future<void> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null) return;

    await saveToHistory(result.files.single.path!);

    setState(() {
      selectedFile = result.files.single.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilledButton.icon(
        onPressed: pickPdf,
        icon: const Icon(Icons.picture_as_pdf),
        label: const Text("Select PDF"),
      ),
    );
  }
}