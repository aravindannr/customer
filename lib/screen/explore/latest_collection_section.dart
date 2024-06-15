import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class LatestCollectionCarousel extends StatefulWidget {
  const LatestCollectionCarousel({
    super.key,
  });

  @override
  State<LatestCollectionCarousel> createState() =>
      _LatestCollectionCarouselState();
}

class _LatestCollectionCarouselState extends State<LatestCollectionCarousel> {
  int carousalIndex = 0;
  late CarouselController _carouselController;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      // clipBehavior: Clip.antiAlias,
      height: 250,
      child: CarouselSlider(
        carouselController: _carouselController,
        items: [
          Image.asset(
            'assets/images/latest1.jpg',
            fit: BoxFit.cover,
            width: width,
          ),
          Image.asset(
            'assets/images/latest2.jpg',
            fit: BoxFit.cover,
            width: width,
          ),
          Image.asset(
            'assets/images/latest4.jpg',
            fit: BoxFit.cover,
            width: width,
          ),
        ],
        options: CarouselOptions(
          height: 250,
          autoPlay: true,
          pageSnapping: true,
          clipBehavior: Clip.antiAlias,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          viewportFraction: 1,
          enableInfiniteScroll: true,
          onPageChanged: (index, reason) {
            setState(() {
              carousalIndex = index;
            });
          },
        ),
      ),
    );
  }
}
