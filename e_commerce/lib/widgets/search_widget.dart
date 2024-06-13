import 'package:e_commerce/consts/messages.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback? onSearch;
  final ValueChanged<String>? onChanged;
  final String searchText;

  // onSearch ile arama butona basınca arar.
  // onChanged ile herbir harf yazıldığında arama yapar.
  const SearchWidget(
      {super.key,
      required this.searchController,
      this.onSearch,
      this.onChanged,
      this.searchText = Messages.search});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            // search inputum
            child: TextField(
              autofocus: false,
              controller: searchController,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: searchText,
                border: InputBorder.none,
              ),
            ),
          ),
          // close iconu ile input içinde bir şey yazıyorsa onu temizlemek için
          if (searchController.text != "")
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                searchController.text = "";
                onChanged!("");
              },
            ),
          if (onSearch != null && searchController.text != "")
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: onSearch,
            ),
          if (searchController.text == "")
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
        ],
      ),
    );
  }
}
