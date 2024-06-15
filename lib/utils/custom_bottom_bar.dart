import 'package:advanced_salomon_bottom_bar/advanced_salomon_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:teresa_customer/modal/user_modal.dart';
import 'package:teresa_customer/screen/chat_page.dart';
import 'package:teresa_customer/services/apiservices/api_utils.dart';
import 'package:teresa_customer/services/apiservices/api_services.dart';
import 'package:teresa_customer/utils/custom_alert.dart';
import 'package:teresa_customer/utils/custom_logo_spinner.dart';
import '../screen/bottom_bar/homepage.dart';
import '../screen/bottom_bar/settings_page.dart';
import '../screen/bottom_bar/shop_page.dart';
import '../widgets/custom_exit_alert.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  var _currentIndex = 0;
  late PageController _pageController = PageController();
  late CustomerModal customerModal;
  bool isLoading = true;
  List<String> assignedDesignerList = [];

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
    fetchCurrentUserData();
  }

  fetchCurrentUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> customerDoc =
          await ApiServices().getCurrentUserData();
      customerModal = ApiUtils().getCurrentUserData(customerDoc);
      assignedDesignerList = customerModal.assignedDesigner;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print("***** Exception on fetchCurrentUserData $e *****");
      }
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(.8),
        context: context,
        builder: (BuildContext context) => CustomErrorAlert(
          content: e.toString(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool val) {
          if (val) {
            return;
          }
          showDialog(
            barrierColor: Colors.black.withOpacity(0.8),
            context: context,
            builder: (context) => const ExitAlert(),
          );
        },
        child: SafeArea(
          child: isLoading
              ? const CustomLogoSpinner()
              : Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: PageView(
              controller: _pageController,
              pageSnapping: true,
              children: [
                const HomePage(),
                const ShopPage(),
                ChatPage(
                  customer: customerModal,
                ),
                const SettingsPage(),
              ],
              onPageChanged: (i) => setState(() => _currentIndex = i),
            ),
          ),
        ),
      ),
      bottomNavigationBar: AdvancedSalomonBottomBar(
        unselectedItemColor: Colors.grey[600],
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() {
            _currentIndex = i;
            _pageController.animateToPage(i,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          });
        },
        items: [
          AdvancedSalomonBottomBarItem(
            icon: Image.asset(
              "assets/icons/explore.png",
              height: 20,
              width: 20,
              color: Colors.white,
            ),
            title: const Text("Explore"),
            selectedColor: Colors.white,
          ),
          AdvancedSalomonBottomBarItem(
            icon: Image.asset(
              "assets/icons/store.png",
              height: 20,
              width: 20,
              color: Colors.white,
            ),
            title: const Text("Store"),
            selectedColor: Colors.white,
          ),
          AdvancedSalomonBottomBarItem(
            icon: Image.asset(
              "assets/icons/chat.png",
              height: 20,
              width: 20,
              color: Colors.white,
            ),
            title: const Text("Chat"),
            selectedColor: Colors.white,
          ),
          AdvancedSalomonBottomBarItem(
            icon: Image.asset(
              "assets/icons/settings.png",
              height: 20,
              width: 20,
              color: Colors.white,
            ),
            title: const Text("Settings"),
            selectedColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
