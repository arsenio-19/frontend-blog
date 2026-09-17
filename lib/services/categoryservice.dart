import 'dart:convert';
import 'package:http/http.dart' as http;

class category {
  final int id;
  final String name;

  category({
    required this.id,
    required this.name,
  });

  factory category.fromJson(Map<String, dynamic> json) {
    return category(
      id: json['id'],
      name: json['name'],
    );
  }
}

class categoryservice {
  static const String baseUrl =
      'http://localhost:3000/api/categories';

  Future<List<category>> getCategories() async {
    final response = await http.get(
      Uri.parse(baseUrl),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      final List data = jsonData['data'];

      return data.map((item) {
        return category.fromJson(item);
      }).toList();
    }

    throw Exception('Gagal mengambil kategori');
  }
}