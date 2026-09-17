
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class postservice {
  static const String baseUrl =
      'http://localhost:3000/api/posts';

  Future<List<post>> getPosts() async {
    final response = await http.get(
      Uri.parse(baseUrl),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List data = jsonData['data'];

      return data.map((item) {
        return post.fromJson(item);
      }).toList();
    }

    throw Exception('Gagal mengambil artikel');
  }

  Future<void> createPost({
    required String title,
    required String content,
    required int categoryId,
  }) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': title,
        'content': content,
        'category_id': categoryId,
      }),
    );

    if (response.statusCode != 201) {
      final jsonData = jsonDecode(response.body);

      throw Exception(
        jsonData['message'] ?? 'Gagal membuat artikel',
      );
    }
  }

  Future<void> updatePost({
    required int id,
    required String title,
    required String content,
    required int categoryId,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': title,
        'content': content,
        'category_id': categoryId,
      }),
    );

    if (response.statusCode != 200) {
      final jsonData = jsonDecode(response.body);

      throw Exception(
        jsonData['message'] ?? 'Gagal memperbarui artikel',
      );
    }
  }

  Future<void> deletePost(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
    );

    if (response.statusCode != 200) {
      final jsonData = jsonDecode(response.body);

      throw Exception(
        jsonData['message'] ?? 'Gagal menghapus artikel',
      );
    }
  }
}

