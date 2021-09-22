import 'package:flutter/material.dart';

class ListFailWidget extends StatelessWidget {
  const ListFailWidget({
    Key? key,
    required this.onRefresh,
    required this.message,
  }) : super(key: key);

  final VoidCallback onRefresh;
  final String message;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: onRefresh,
              label: const Text('Try Again'),
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      );
}
