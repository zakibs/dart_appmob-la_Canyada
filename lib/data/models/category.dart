class Category {
  final String id;
  final String name;
  final String imageUrl;
  final int itemCount;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.itemCount,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'itemCount': itemCount,
    };
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      itemCount: json['itemCount'],
    );
  }
}
