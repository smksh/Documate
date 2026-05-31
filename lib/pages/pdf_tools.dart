import 'package:flutter/material.dart';

import 'rename_pdf.dart';
import 'delete_page.dart';

class PdfToolsPage extends StatelessWidget {
  const PdfToolsPage({super.key});

  Widget toolCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
      }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        leading: Icon(
          icon,
          size: 32,
          color: colorScheme.onSurfaceVariant,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: colorScheme.onSurfaceVariant,
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Text(
          "PDF Tools",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),

        const SizedBox(height: 20),

        toolCard(
          context,
          icon: Icons.swap_vert,
          title: "Reorder Pages",
          subtitle: "Change page order in a PDF",
          onTap: () {},
        ),

        toolCard(
          context,
          icon: Icons.delete_outline,
          title: "Delete Page",
          subtitle: "Remove selected pages",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DeletePage(),
              ),
            );
          },
        ),

        toolCard(
          context,
          icon: Icons.add_box_outlined,
          title: "Add Page",
          subtitle: "Insert blank or image page",
          onTap: () {},
        ),

        toolCard(
          context,
          icon: Icons.note_add_outlined,
          title: "Create PDF",
          subtitle: "Create new PDF from images/text",
          onTap: () {},
        ),

        toolCard(
          context,
          icon: Icons.drive_file_rename_outline,
          title: "Rename PDF",
          subtitle: "Rename selected PDF file",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RenamePdfPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}