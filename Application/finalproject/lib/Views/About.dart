import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text("You're using Jacob's Final Project App, the best app you can find for information about exhibits in the Metropolitan Museum of Art! \nDesigned by Jacob Anderson for CMSC 2204."),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back'),
            ),
          ],
        ) 
      ),
    );
  }
}