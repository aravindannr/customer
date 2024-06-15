import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teresa_customer/widgets/seasonal_collection.dart';

class SeasonalCollectionCarousel extends StatelessWidget {
  const SeasonalCollectionCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final List<String> imagePath = [
      "assets/images/seasonal1.jpg",
      "assets/images/seasonal2.jpg",
      "assets/images/seasonal3.jpg",
      "assets/images/seasonal4.jpg",
      "assets/images/seasonal1.jpg",
    ];

    final List<String> itemName = [
      "Bohemian maxi dress",
      "Vintage-inspired midi dress",
      "Sundress",
      "Ball gown",
      "Bohemian maxi dress",
    ];

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      height: 350,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 5),
        itemCount: imagePath.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const SeasonalCollection(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    // clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        Image.asset(
                          imagePath[index],
                          fit: BoxFit.cover,
                        ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.4),
                              Colors.black.withOpacity(0.9),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: const [0.3, 0.8, 1.0],
                          ),
                        ),
                      ),
                    ),
                      Positioned(
                          bottom: 8,
                          left: 8,
                          child: Text(
                            itemName[index],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
