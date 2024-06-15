import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TopAdCarousel extends StatefulWidget {
  const TopAdCarousel({super.key});

  @override
  State<TopAdCarousel> createState() => _TopAdCarouselState();
}

class _TopAdCarouselState extends State<TopAdCarousel> {
  late CarouselController _carouselController;
  int carousalIndex = 0;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: _carouselController,
      items: const [
        AdContainer(),
        AdContainer(),
        AdContainer(),
      ],
      options: CarouselOptions(
        height: 130,
        viewportFraction: 0.25,
        onPageChanged: (index, reason) {
          setState(() {
            carousalIndex = index;
          });
        },
        autoPlay: true,
      ),
    );
  }
}

class AdContainer extends StatelessWidget {
  const AdContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: 80,
            width: 80,
            child: Image.asset(
              'assets/images/wedding.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          " Test Ad",
          style: TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      ],
    );
    // return Container(
    //   margin: const EdgeInsets.symmetric(horizontal: 2.5),
    //   decoration: BoxDecoration(
    //     color: Colors.grey.shade900,
    //     // borderRadius: BorderRadius.circular(15),
    //   ),
    //   // clipBehavior: Clip.antiAlias,
    //   child: Row(
    //     children: [
    //       SizedBox(
    //         height: 120,
    //         width: 100,
    //         child: Image.asset(
    //           'assets/images/wedding.jpg',
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //       const Expanded(
    //         child: Padding(
    //           padding: EdgeInsets.all(15),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 "Test Ad",
    //                 style: TextStyle(
    //                   fontSize: 14,
    //                   fontWeight: FontWeight.w500,
    //                   color: Colors.white,
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 10,
    //               ),
    //               Text(
    //                 "Dummy Text that substantiates the ad.",
    //                 style: TextStyle(
    //                   fontSize: 10,
    //                   color: Colors.white,
    //                 ),
    //               ),
    //               Spacer(),
    //               Row(
    //                 children: [
    //                   Icon(
    //                     Icons.star,
    //                     color: Colors.yellow,
    //                     size: 15,
    //                   ),
    //                   SizedBox(
    //                     width: 5,
    //                   ),
    //                   Text(
    //                     "4.5",
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 10,
    //                     ),
    //                   ),
    //                   Spacer(),
    //                   Text(
    //                     "₹ 2000",
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 10,
    //                     ),
    //                   ),
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
