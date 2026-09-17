
import 'package:flutter/material.dart';
import 'detailArtikelPage.dart';
import '../models/post.dart';
import '../services/postservice.dart';

class artikelpage extends StatefulWidget {
  const artikelpage({super.key});

  @override
  State<artikelpage> createState() => _artikelpageState();
}

class _artikelpageState extends State<artikelpage> {
  final postservice service = postservice();

  List<post> posts = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  Future<void> loadPosts() async {
    try {
      final data = await service.getPosts();

      setState(() {
        posts = data;
        isLoading = false;
        errorMessage = null;
      });
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Text(
          'Gagal memuat artikel\n$errorMessage',
          textAlign: TextAlign.center,
        ),
      );
    }

    if (posts.isEmpty) {
      return const Center(
        child: Text('Belum ada artikel'),
      );
    }

    return RefreshIndicator(
      onRefresh: loadPosts,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final item = posts[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.categoryName,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    item.content,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 12),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => detailartikelpage(
                            artikel: item,
                          ),
                        ),
                      );
                    },
                    child: const Text('Baca Selengkapnya'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

