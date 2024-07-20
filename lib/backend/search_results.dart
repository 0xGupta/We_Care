class Result {
  final String title;
  final String description;
  final String imageUrl;

  Result(
      {required this.title, required this.description, required this.imageUrl});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}
