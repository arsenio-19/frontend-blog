
import 'package:flutter/material.dart';
import '../models/post.dart';

class detailartikelpage extends StatelessWidget {
  final post artikel;

  const detailartikelpage({
    super.key,
    required this.artikel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Artikel'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              artikel.categoryName,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              artikel.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            if (artikel.createdAt != null)
              Text(
                'Dibuat: ${artikel.createdAt}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

            const SizedBox(height: 24),

            Text(
              artikel.content,
              style: const TextStyle(
                fontSize: 17,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

