class Review {
  final String author;
  final String content;
  final String createdAt;

  Review({
    required this.author,
    required this.content,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      author: json['author'],
      content: json['content'],
      createdAt: json['created_at'],
    );
  }
}
