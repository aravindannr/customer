import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white60,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.white38,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.white38,
            ),
          ),
          hintText: "Search for a product",
          hintStyle: TextStyle(color: Colors.white38),
        ),
      ),
    );
  }
}
