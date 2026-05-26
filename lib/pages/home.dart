import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedFile = "No PDF selected";

  Future<void> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null) return;

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