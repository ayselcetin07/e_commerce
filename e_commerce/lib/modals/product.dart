class Product {
  final String id;
  final String title;

  final String image;

  Product({
    required this.id,
    required this.title,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['idProduct'],
      title: json['strProduct'],
      image: json['strProductImage'],
    );
  }
}
