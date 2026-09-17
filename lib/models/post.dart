class post {
  final int id;
  final String title;
  final String content;
  final int categoryId;
  final String categoryName;
  final String? createdAt;
  final String? updatedAt;

  post({
    required this.id,
    required this.title,
    required this.content,
    required this.categoryId,
    required this.categoryName,
    this.createdAt,
    this.updatedAt,
  });

  factory post.fromJson(Map<String, dynamic> json) {
    return post(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}