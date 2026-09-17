
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/postservice.dart';
import 'buatArtikelPage.dart';
import 'editArtikelPage.dart';

class artikelSayapage extends StatefulWidget {
  const artikelSayapage({super.key});

  @override
  State<artikelSayapage> createState() => _artikelSayapageState();
}

class _artikelSayapageState extends State<artikelSayapage> {
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
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await service.getPosts();

      setState(() {
        posts = data;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  Future<void> deletePost(post artikel) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Artikel'),
          content: Text(
            'Apakah kamu yakin ingin menghapus "${artikel.title}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (confirm != true) {
      return;
    }

    try {
      await service.deletePost(artikel.id);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Artikel berhasil dihapus'),
        ),
      );

      loadPosts();
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus artikel: $error'),
        ),
      );
    }
  }

  Future<void> editPost(post artikel) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => editartikelpage(
          artikel: artikel,
        ),
      ),
    );

    if (result == true) {
      loadPosts();
    }
  }

  Future<void> createPost() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => buatartikelpage(
      ),
    ));

    if (result == true) {
      loadPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artikel Saya'),
        actions: [
          IconButton(
            onPressed: loadPosts,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: createPost,
        icon: const Icon(Icons.add),
        label: const Text('Buat Artikel'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(
                Icons.error_outline,
                size: 50,
              ),
              SizedBox(height: 16),
               Text(
                'Gagal memuat artikel',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: loadPosts,
                child: Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    if (posts.isEmpty) {
      return RefreshIndicator(
        onRefresh: loadPosts,
        child: ListView(
          children: [
            SizedBox(height: 200),
            Center(
              child: Text(
                'Belum ada artikel',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: loadPosts,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final artikel = posts[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artikel.categoryName,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    artikel.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    artikel.content,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            editPost(artikel);
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            deletePost(artikel);
                          },
                          icon: const Icon(Icons.delete),
                          label: const Text('Hapus'),
                        ),
                      ),
                    ],
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

