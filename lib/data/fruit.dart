class Fruit {
  final String name;
  final String location;
  final int age;
  final String description;
  final int likeCount;
  final List<String> tags;
  final List<String> images;

  Fruit({
    required this.name,
    required this.location,
    required this.age,
    required this.description,
    required this.likeCount,
    required this.tags,
    required this.images,
  });

  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      age: json['age'] ?? 0,
      description: json['description'] ?? '',
      likeCount: json['likeCount'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
      images: List<String>.from(json['images'] ?? []),
    );
  }
}
