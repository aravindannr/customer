import 'package:flutter/material.dart';
import 'package:teresa_customer/screen/test_page.dart';
import '../../utils/appbar.dart';
import '../../widgets/shop_grid.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({
    super.key,
  });

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  // late ScrollController _scrollController;
  List<String> tabNames = [
    'Saree',
    'Churidar',
    'Lehenga',
    'Anarkali',
    'Salwar',
    'Kurti',
  ];

  // void hideBottomBar() {
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.userScrollDirection ==
  //         ScrollDirection.reverse) {
  //       if (widget.isVisible) {
  //         setState(() {
  //           widget.isVisible = false;
  //         });
  //         widget.onVisibilityChanged(false);
  //       }
  //     }
  //     if (_scrollController.position.userScrollDirection ==
  //         ScrollDirection.forward) {
  //       if (!widget.isVisible) {
  //         setState(() {
  //           widget.isVisible = true;
  //         });
  //         widget.onVisibilityChanged(true);
  //       }
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabNames.length, vsync: this);
    // _scrollController = ScrollController();
    // hideBottomBar();
  }

  @override
  void dispose() {
    tabController.dispose();
    // _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          CustomAppBar(
            leading: Image.asset(
              "assets/images/teresa_logo_white.png",
            ),
            trailing: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextFormField(
                decoration: const InputDecoration(
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
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: "Search for a product",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ),
          ),
          TabBar(
            controller: tabController,
            unselectedLabelColor: Colors.grey.shade600,
            labelColor: Colors.white,
            labelStyle: const TextStyle(fontSize: 16),
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: Colors.black,
            isScrollable: true,
            tabs: List.generate(
              tabNames.length,
              (index) => Tab(
                text: tabNames[index],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: TabBarView(
                controller: tabController,
                children: const [
                  ShopSaree(),
                  Testpage1(),
                  Testpage1(),
                  Testpage1(),
                  Testpage1(),
                  Testpage1(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
