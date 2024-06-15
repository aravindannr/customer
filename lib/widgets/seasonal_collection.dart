import 'package:flutter/material.dart';
import 'package:teresa_customer/widgets/shop_card.dart';

class SeasonalCollection extends StatefulWidget {
  const SeasonalCollection({super.key});

  @override
  State<SeasonalCollection> createState() => _SeasonalCollectionState();
}

class _SeasonalCollectionState extends State<SeasonalCollection> {
  // late ScrollController _scrollController;
  // bool isVisible = true;
  // void animateToAppBar() {
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.userScrollDirection ==
  //         ScrollDirection.reverse) {
  //       if (isVisible) {
  //         setState(() {
  //           isVisible = false;
  //         });
  //       }
  //     }
  //     if (_scrollController.position.userScrollDirection ==
  //         ScrollDirection.forward) {
  //       if (!isVisible) {
  //         setState(() {
  //           isVisible = true;
  //         });
  //       }
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // _scrollController = ScrollController();
    // animateToAppBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // title: Text(
        //   'Saree Collection',
        //   style: GoogleFonts.exo(
        //     fontSize: 20,
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        // controller: _scrollController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Saree Collection',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/icons/filter.png',
                      height: 25,
                    ),
                  )
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 8,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                return const CollectionCard();
              },
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _scrollController.dispose();
  // }
}
