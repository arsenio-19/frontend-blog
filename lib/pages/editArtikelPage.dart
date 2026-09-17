
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/postservice.dart';
import '../services/categoryservice.dart';

class editartikelpage extends StatefulWidget {
  final post artikel;

  const editartikelpage({
    super.key,
    required this.artikel,
  });

  @override
  State<editartikelpage> createState() => _editartikelpageState();
}

class _editartikelpageState extends State<editartikelpage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  final postservice postService = postservice();
  final categoryservice categoryService = categoryservice();

  List<category> categories = [];
  category? selectedCategory;

  bool isLoading = true;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();

    titleController.text = widget.artikel.title;
    contentController.text = widget.artikel.content;

    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      final data = await categoryService.getCategories();

      category? currentCategory;

      for (final item in data) {
        if (item.id == widget.artikel.categoryId) {
          currentCategory = item;
          break;
        }
      }

      setState(() {
        categories = data;
        selectedCategory = currentCategory;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengambil kategori: $error'),
        ),
      );
    }
  }

  Future<void> updatePost() async {
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Judul artikel wajib diisi'),
        ),
      );
      return;
    }

    if (contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Isi artikel wajib diisi'),
        ),
      );
      return;
    }

    if (selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih kategori terlebih dahulu'),
        ),
      );
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      await postService.updatePost(
        id: widget.artikel.id,
        title: titleController.text.trim(),
        content: contentController.text.trim(),
        categoryId: selectedCategory!.id,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Artikel berhasil diperbarui'),
        ),
      );

      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memperbarui artikel: $error'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Artikel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Judul Artikel',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<category>(
              initialValue: selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
              ),
              items: categories.map((item) {
                return DropdownMenuItem<category>(
                  value: item,
                  child: Text(item.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),

            const SizedBox(height: 16),

            Expanded(
              child: TextField(
                controller: contentController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  labelText: 'Isi Artikel',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isSubmitting ? null : updatePost,
                child: isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Simpan Perubahan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

