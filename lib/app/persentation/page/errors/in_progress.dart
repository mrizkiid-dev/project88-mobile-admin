import 'package:flutter/material.dart';

class InProgressPage extends StatelessWidget {
  const InProgressPage(
    {super.key,
    this.message}
  );

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message ?? 'oops something went wrong')
          ],
        ),
      ),
    );
  }
}