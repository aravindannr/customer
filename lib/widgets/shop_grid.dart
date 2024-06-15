import 'package:flutter/material.dart';
import 'package:teresa_customer/widgets/shop_card.dart';

class ShopSaree extends StatefulWidget {
  const ShopSaree({super.key});

  @override
  State<ShopSaree> createState() => _ShopSareeState();
}

class _ShopSareeState extends State<ShopSaree> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 15,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        childAspectRatio: 3 / 4,
      ),
      itemBuilder: (context, index) {
        return const CollectionCard();
      },
    );
  }
}
