import 'package:flutter/material.dart';

import '../screen/bottom_bar/homepage.dart';
import '../screen/bottom_bar/shop_page.dart';


class HomeBaseScaffold extends StatefulWidget {
  const HomeBaseScaffold({super.key});

  @override
  State<HomeBaseScaffold> createState() => _HomeBaseScaffoldState();
}

class _HomeBaseScaffoldState extends State<HomeBaseScaffold> {
  late PageController _pageController;
  int currentIndex = 0;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          SafeArea(
            child: PageView(
              controller: _pageController,
              children: const [
                HomePage(
                ),
                ShopPage(
                    // onVisibilityChanged: updateVisibility,
                    // isVisible: isVisible,
                    ),
              ],
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            bottom: isVisible ? 0 : -60,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black,
              child: BottomNavigationBar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                unselectedItemColor: Colors.white54,
                selectedItemColor: Theme.of(context).colorScheme.primary,
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() => currentIndex = index);
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.ease,
                  );
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.explore,
                      size: 20,
                    ),
                    label: "Explore",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.shopping_bag,
                      size: 20,
                    ),
                    label: 'Shop',
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
