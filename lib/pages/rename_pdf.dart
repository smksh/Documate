import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class RenamePdfPage extends StatefulWidget {
  const RenamePdfPage({super.key});

  @override
  State<RenamePdfPage> createState() => _RenamePdfPageState();
}

class _RenamePdfPageState extends State<RenamePdfPage> {
  File? selectedPdf;

  final TextEditingController controller = TextEditingController();

  Future<void> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null) return;

    setState(() {
      selectedPdf = File(result.files.single.path!);
    });
  }

  Future<void> renamePdf() async {
    if (selectedPdf == null) return;

    final newName = controller.text.trim();

    if (newName.isEmpty) return;

    final directory = selectedPdf!.parent.path;

    final renamedFile = await selectedPdf!.rename(
      "$directory/$newName.pdf",
    );

    setState(() {
      selectedPdf = renamedFile;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("PDF Renamed Successfully"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rename PDF"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FilledButton(
              onPressed: pickPdf,
              child: const Text("Select PDF"),
            ),

            const SizedBox(height: 20),

            Text(
              selectedPdf?.path ?? "No PDF Selected",
            ),

            const SizedBox(height: 20),

            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "New PDF Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            FilledButton(
              onPressed: renamePdf,
              child: const Text("Rename"),
            ),
          ],
        ),
      ),
    );
  }
}