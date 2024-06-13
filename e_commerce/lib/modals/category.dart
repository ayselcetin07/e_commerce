class Category {
  final String id;
  final String title;
  final String image;
  final String description;

  Category({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

// API'den json olarak gelen veriyi kendi modelime mapladim
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['idCategory'],
      title: json['strCategory'],
      description: json['strCategoryDescription'],
      image: json['strImage'],
    );
  }
}
