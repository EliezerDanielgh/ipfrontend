import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  String? error;

  NotFoundPage({
    Key? key,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            "404 - Página no encontrada",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (error!.isNotEmpty)
            Text(
              error!,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
