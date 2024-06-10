import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'downloads_view.dart';
import 'home_view.dart';
import 'video_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _page = 1; // Set initial index
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _page);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: CurvedNavigationBar(
          height: 48.h,
          key: _bottomNavigationKey,
          index: _page, // Set initial index
          items: <Widget>[
            Icon(Icons.video_library_sharp, size: 26.h),
            Icon(Icons.home, size: 26.h),
            Icon(Icons.downloading_sharp, size: 26.h),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.grey.shade300,
          backgroundColor: Colors.lightBlueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) {
            if (index != _page) {
              setState(() {
                _page = index;
              });
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          letIndexChange: (index) => true,
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(), // Disable scrolling
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _page = index;
            });
          },
          children: <Widget>[
            // Pages corresponding to each icon
            const VideoDownloadView(),
            const HomeView(),
            const DownloadsView(),
          ].toList(), // Exclude null widgets
        ),
      ),
    );
  }
}
