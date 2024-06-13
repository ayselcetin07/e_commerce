import 'dart:convert';
import 'package:e_commerce/consts/base_url.dart';

import 'package:e_commerce/modals/product.dart';
import 'package:e_commerce/modals/product_detail.dart';
import 'package:http/http.dart' as http;

class ProductService {
  // Kategori adına göre tüm ürünleri listeler
  Future<List<Product>> getAllProductsByCategoryName(
      String categoryName) async {
    //
    final response =
        await http.get(Uri.parse("${BaseUrl.url}filter.php?c=$categoryName"));
    if (response.statusCode == 200) {
      final List<dynamic> productsJson = json.decode(response.body)['products'];
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Kategorideki ürünler yüklenemedi');
    }
  }

  // ürün  Id ye göre ürün detaylarını getirir
  Future<ProductDetail?> getProductsDetailByProductId(String productId) async {
    final response =
        await http.get(Uri.parse("${BaseUrl.url}lookup.php?i=$productId"));
    if (response.statusCode == 200) {
      final List<dynamic> productsJson = json.decode(response.body)['products'];
      print(productsJson);
      return productsJson
          .map((json) => ProductDetail.fromJson(json))
          .toList()
          .firstOrNull;
    } else {
      throw Exception('ürün yüklenemedi');
    }
  }
}
