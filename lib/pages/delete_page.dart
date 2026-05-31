import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class DeletePage extends StatefulWidget {
  const DeletePage({super.key});

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  File? selectedPdf;
  final pageController = TextEditingController();

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

  Future<void> deletePage() async {
    if (selectedPdf == null) return;

    int pageNumber = int.tryParse(pageController.text.trim()) ?? 0;

    if (pageNumber <= 0) return;

    final bytes = await selectedPdf!.readAsBytes();
    final document = PdfDocument(inputBytes: bytes);

    if (pageNumber > document.pages.count) {
      document.dispose();
      return;
    }

    document.pages.removeAt(pageNumber - 1);

    final List<int> newBytes = await document.save();
    document.dispose();

    final oldPath = selectedPdf!.path;
    final newPath = oldPath.replaceFirst(".pdf", "_page_deleted.pdf");

    final newFile = File(newPath);
    await newFile.writeAsBytes(newBytes);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Saved: ${newFile.path}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FilledButton(
              onPressed: pickPdf,
              child: const Text("Select PDF"),
            ),

            const SizedBox(height: 16),

            Text(selectedPdf?.path ?? "No PDF selected"),

            const SizedBox(height: 16),

            TextField(
              controller: pageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Page number to delete",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            FilledButton.icon(
              onPressed: deletePage,
              icon: const Icon(Icons.delete),
              label: const Text("Delete Page"),
            ),
          ],
        ),
      ),
    );
  }
}