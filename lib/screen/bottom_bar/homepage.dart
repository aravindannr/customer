import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:teresa_customer/screen/test_page.dart';
import 'package:video_player/video_player.dart';
import '../../utils/appbar.dart';
import '../explore/latest_collection_section.dart';
import '../../widgets/seasonal_container.dart';
import '../explore/top_carousel.dart';
import '../explore/video_ad_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _videoController1;
  late VideoPlayerController _videoController2;
  late VideoPlayerController _videoController3;
  late ScrollController _scrollController;

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

  final List<String> latestItems = [
    "assets/images/banner.png",
    "assets/images/banner.png",
    "assets/images/banner.png",
    "assets/images/banner.png",
    "assets/images/banner.png",
  ];

  bool _isVideo1Initialized = false;
  bool _isVideo2Initialized = false;
  bool _isVideo3Initialized = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _initializeVideoControllers();
  }

  Future<void> _initializeVideoControllers() async {
    log('Initializing Video 1');
    _videoController1 = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://videos.pexels.com/video-files/4620479/4620479-hd_1366_720_50fps.mp4'),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..initialize().then((_) {
        _videoController1.play();
        _videoController1.setLooping(true);
        log('Video 1 initialized and playing');
        setState(() {
          _isVideo1Initialized = true;
        });
      }).catchError((error) {
        log('Error initializing video 1: $error');
      });

    log('Initializing Video 2');
    _videoController2 = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://videos.pexels.com/video-files/3205786/3205786-hd_720_1280_25fps.mp4'),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..initialize().then((_) {
        _videoController2.play();
        _videoController2.setLooping(true);
        log('Video 2 initialized and playing');
        setState(() {
          _isVideo2Initialized = true;
        });
      }).catchError((error) {
        log('Error initializing video 2: $error');
      });

    log('Initializing Video 3');
    _videoController3 = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://videos.pexels.com/video-files/4727647/4727647-hd_1280_720_50fps.mp4'),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..initialize().then((_) {
        _videoController3.play();
        _videoController3.setLooping(true);
        log('Video 3 initialized and playing');
        setState(() {
          _isVideo3Initialized = true;
        });
      }).catchError((error) {
        log('Error initializing video 3: $error');
      });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(height: 15),
                const TopAdCarousel(),
                const SizedBox(height: 15),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      VideoAdSection(
                        videoController: _videoController1,
                        page: const Testpage1(),
                        isShow: _isVideo1Initialized,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      VideoAdSection(
                        videoController: _videoController2,
                        page: const Testpage1(),
                        isShow: _isVideo2Initialized,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      VideoAdSection(
                        videoController: _videoController3,
                        page: const Testpage1(),
                        isShow: _isVideo3Initialized,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Latest collection",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: const LatestCollectionCarousel(),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Seasonal Collections",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                const SeasonalCollectionCarousel(),
                const SizedBox(height: 15),

                SizedBox(
                  height: height * 0.2,
                  child: Center(
                    child: Image.asset(
                      "assets/images/teresa_logo_white.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoController1.dispose();
    _videoController2.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  final wantKeepAlive = true;
}
