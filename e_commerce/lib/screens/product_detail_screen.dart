import 'package:e_commerce/consts/messages.dart';
import 'package:e_commerce/modals/product_detail.dart';
import 'package:e_commerce/services/product_services.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductService _productService = ProductService();
  ProductDetail? _productDetail = null;
  // youtube oynatıcı

  @override
  void initState() {
    super.initState();
    _getProductDetailByProductId();
  }

// async olarak ürünün Id ile bilgilerini çektim
  Future<void> _getProductDetailByProductId() async {
    try {
      final productDetail =
          await _productService.getProductsDetailByProductId(widget.productId);
      setState(() {
        _productDetail = productDetail;
      });
    } catch (e) {
      toastification.show(
        context: context,
        title: Text('Hata: $e'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('e-commerce App'),
      ),
      // productDetail yoksa yüklenme işareti koydum
      body: _productDetail == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Hero animasyonu ekledim
                  Hero(
                    tag: 'productImage_${_productDetail!.id}',
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images2/loading.gif",
                      image: _productDetail!.image,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    _productDetail!.title,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      _productDetail!.description,
                      style: const TextStyle(fontSize: 13.0),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  const SizedBox(height: 20.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      Messages.ingredients,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        _productDetail!.description.length, //düzeltme
                        (index) {
                          // ingredients ve measure u yan yana yazdırdım
                          final ingredients = _productDetail!.title[index];
                          final measure = _productDetail!.measures[index];
                          if (ingredients != "" &&
                              measure != null &&
                              measure != "") {
                            return Text(
                              '${index + 1}) $ingredients: ($measure)',
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    // Araya çizgi koydum
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      color: Colors.black,
                      thickness: 0.5,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "${Messages.caregory}: ${_productDetail!.category}",
                      style: const TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
    );
  }
}
