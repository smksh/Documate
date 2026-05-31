import 'package:flutter/material.dart';

class AsciiBanner extends StatefulWidget {
  const AsciiBanner({super.key});

  @override
  State<AsciiBanner> createState() => _AsciiBannerState();
}

class _AsciiBannerState extends State<AsciiBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  final String art = r'''
                               __           .__        ___.         .__.__       .___
  ___________    _____ _____  |  | __  _____|  |__     \_ |__  __ __|__|  |    __| _/______
 /  ___/\__  \  /     \\__  \ |  |/ / /  ___/  |  \     | __ \|  |  \  |  |   / __ |/  ___/
 \___ \  / __ \|  Y Y  \/ __ \|    <  \___ \|   Y  \    | \_\ \  |  /  |  |__/ /_/ |\___ \
/____  >(____  /__|_|  (____  /__|_ \/____  >___|  / /\ |___  /____/|__|____/\____ /____  >
     \/      \/      \/     \/     \/     \/     \/  )/     \/                    \/    \/
''';

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        height: 125,
        width: double.infinity,
        child: ClipRect(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  320 - controller.value * 900,
                  0,
                ),
                child: child,
              );
            },
            child: Text(
              art,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 8,
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}