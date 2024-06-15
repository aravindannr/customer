import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/custom_logo_spinner.dart';

class CollectionCard extends StatelessWidget {
  const CollectionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.grey.shade900,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return const ProductBottomSheet();
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey.shade500,
              Colors.grey.shade300,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/latest3-background.png"),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lorem ipsum",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProductBottomSheet extends StatefulWidget {
  const ProductBottomSheet({super.key});

  @override
  State<ProductBottomSheet> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProductBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 100,
            vertical: 10,
          ),
          height: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.shade400,
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl:
                  "https://images.pexels.com/photos/1036623/pexels-photo-1036623.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              placeholder: (context, url) => const Center(
                child: CustomLogoSpinner(
                  oneSize: 10,
                  roundSize: 30,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Lorem ipsum",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            "₹6899",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 25),
          child: Text(
            "Details",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 25),
          child: Text(
            "Lorem ipsum, placeholder or dummy text used in typesetting and graphic design for previewing layouts",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(Colors.black),
              minimumSize: WidgetStatePropertyAll<Size>(
                Size(MediaQuery.of(context).size.width * 0.9, 50),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "Make an Enquiry",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
