import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DocuMate',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.grey[800],
      ),
      home: const Example(),
    );
  }
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text('PDF Tools', style: optionStyle),
    Text('Files', style: optionStyle),
    Text('Settings', style: optionStyle),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 20,
        title: const Text('DocuMate'),
      ),

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 8,
            ),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 4,
              activeColor: Colors.black,
              iconSize: 22,
              textStyle: const TextStyle(fontSize: 12),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,

              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.picture_as_pdf,
                  text: 'PDF',
                ),
                GButton(
                  icon: LineIcons.folderOpen,
                  text: 'Files',
                ),
                GButton(
                  icon: LineIcons.cog,
                  text: 'Settings',
                ),
              ],

              selectedIndex: _selectedIndex,

              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}