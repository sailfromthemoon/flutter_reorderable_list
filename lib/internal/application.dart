import 'package:flutter/material.dart';

import '../presentation/drag_and_drop_screen.dart';
import '../presentation/reorderable_screen.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Builder(builder: (context) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReorderableScreen(),
                        ),
                      );
                    },
                    child: const Text(
                        'Base Task(with ReorderableListView widget)'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DragAndDropScreen()),
                      );
                    },
                    child: const Text(
                        'Extended Task(with drag_and_drop_lists package)'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange[400],
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
