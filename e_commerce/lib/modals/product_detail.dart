import 'package:e_commerce/modals/product.dart';

class ProductDetail extends Product {
  // product Detail in içindeki şeyler product da olduğu için extend ettim ve super e gerekli verileri verdim.
  String description;
  String category;

  List<String?> ingredients;
  List<String?> measures;

  ProductDetail({
    required id,
    required title,
    required price,
    required image,
    required this.description,
    required this.category,
    required this.ingredients,
    required this.measures,
  }) : super(id: id, title: title, image: image);
// API'den json olarak gelen veriyi kendi modelime mapladim
  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['idProduct'],
      title: json['strProduct'],
      price: json['ProductPrice'].toDouble(),
      description: json['strInstructions'],
      category: json['strCategory'],
      image: json['strImages'],

      // Burada veri bana array olarak gelmiyordu. Bu şekilde bunu array çevirdim.
      ingredients: List<String>.generate(
          20, (index) => json['strIngredient${index + 1}']),
      measures:
          List<String>.generate(20, (index) => json['strMeasure${index + 1}']),
    );
  }
}
