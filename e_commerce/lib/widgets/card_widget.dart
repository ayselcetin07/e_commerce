import 'package:e_commerce/consts/colors.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String id;
  final String imagePath;
  final String title;
  final String description;

  const CardWidget({
    super.key,
    required this.id,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    int textLength = 150;
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColor.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          // loading gif ile fotoğraf yükleme kodu
          children: <Widget>[
            FadeInImage.assetNetwork(
              placeholder: "assets/images/loading.gif",
              image: imagePath,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            // Burada başlık ve açıklamayı ekranı bastım. Açıklama çok uzun olursa diye kısaltma işlemi uyguladım.
            ListTile(
              title: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                description.length > textLength
                    ? "${description.substring(0, textLength)}..."
                    : description,
                style: const TextStyle(color: AppColor.gray),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
