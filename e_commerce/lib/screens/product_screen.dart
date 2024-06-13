import 'package:e_commerce/consts/colors.dart';
import 'package:e_commerce/modals/category.dart';
import 'package:e_commerce/modals/product.dart';
import 'package:e_commerce/screens/product_detail_screen.dart';
import 'package:e_commerce/services/category_services.dart';
import 'package:e_commerce/services/product_services.dart';
import 'package:e_commerce/widgets/card_widget.dart';
import 'package:e_commerce/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ProductScreen extends StatefulWidget {
  final Category category;
  const ProductScreen({super.key, required this.category});

  @override
  // ignore: library_private_types_in_public_api
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // yüklenme ekranı için loading ekledim
  late bool _loading = true;
  // ürünleri listelemek için product servisi çağırdım
  final ProductService _productService = ProductService();
  late List<Product> _products = [];
  // ürünleri arama inputu ile filterelemek için filtered product ı kullandım
  late List<Product> _filteredProducts = [];
  // üste kategorileri listelemek için category servisi çağırdım.
  final CategoryService _categoryService = CategoryService();
  late List<Category> _categories = [];
  // Diğer sayfadan gelen kategori verisini aldım. Daha sonradan değiştirebilmek için late kullandım
  late Category _category = widget.category;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getAllProductsByCategoryName();
    _getAllCategories();
  }

  // async olarak kategori adına göre tüm ürünleri listeledim
  Future<void> _getAllProductsByCategoryName() async {
    try {
      final products =
          await _productService.getAllProductsByCategoryName(_category.title);
      setState(() {
        _products = products;
        _filteredProducts = products;
        _loading = false;
      });
    } catch (e) {
      toastification.show(
        // ignore: use_build_context_synchronously
        context: context,
        title: Text('Hata: $e'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
  }

  // kategori adına göre tüm kategorileri listeledim
  Future<void> _getAllCategories() async {
    try {
      final categories = await _categoryService.getAllCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      toastification.show(
        // ignore: use_build_context_synchronously
        context: context,
        title: Text('Hata: $e'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
  }

  ///onChange a _search fonksiyonunu atadım ve query de search widget a ne yazıldıysa onu veriyor. Eğer query'nin içi boşaltıldıysa tüm ürünleri tekrardan listelemek
// için filtered product a  atıyorum.
// eğer query doluysa lowercase yapıp başlıkta bu queryi içeren ürünleri fileted product a atıyorum.
  void _search(query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = _products.toList();
        return;
      }
      _filteredProducts = _products
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // ürüne tıklandığında product ıd verisi ile productDetailScreen sayfasına geçiyor.
  void _onclickProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(productId: product.id),
      ),
    );
  }

  // Burada üsten kategori seçerse kategori değiştirmeyi sağlıyor.
  _setCategory(Category category) {
    setState(() {
      _loading = true;
      _category = category;
    });
    _getAllProductsByCategoryName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('e commerce App'),
      ),
      body: Column(
        children: [
          // Arama inputum
          SearchWidget(
            searchController: _searchController,
            onChanged: _search,
          ),
          // Seçili kategori adı
          Text(
            _category.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.start,
          ),
          // Boşluk bırakmak için
          const SizedBox(height: 10.0),
          // yatay olarak sıralanmış liste
          SizedBox(
            height: 30.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () => _setCategory(_categories[index]),
                    child: Container(
                      width: 80.0,
                      margin: const EdgeInsets.only(right: 10.0),
                      decoration: BoxDecoration(
                        // seçili kategorinin rengini değiştirdim
                        color: _categories[index].id == _category.id
                            ? Colors.green
                            : AppColor.blue,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Text(
                          _categories[index].title,
                          style: TextStyle(
                              fontSize: 10.0,
                              color: _categories[index].id == _category.id
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ));
              },
            ),
          ),
          const SizedBox(height: 15.0),
          // yükleniyorsa ekrana yükleneme işareti kodum
          _loading
              ? const Center(
                  child: CircularProgressIndicator(), // Yükleniyor animasyonu
                )
              :
              // yüklendikten sonra ekrana product listesini bastım
              Expanded(
                  child: ListView.builder(
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _onclickProduct(_filteredProducts[index]),
                        child: CardWidget(
                          id: _filteredProducts[index].id,
                          title: _filteredProducts[index].title,
                          description: "",
                          imagePath: _filteredProducts[index].image,
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
