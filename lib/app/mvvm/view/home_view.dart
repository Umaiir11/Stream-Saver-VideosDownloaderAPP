import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';


import '../../configs/app_routes.dart';
import '../../configs/app_textStyles.dart';
import '../../widgets/custom_appbar.dart';
import 'downloads_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: 'Home', centerTitle: true, leadingWidth: 80.w),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
      
      
              Center(
                child: SizedBox(
                  width: 50.h, // Adjust width and height according to your animation size
                  height: 50.h,
                  child: Lottie.asset('assets/yt.json'), // Placeholder animation
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton(
                    "Video",
                    FontAwesomeIcons.video,
                    Colors.pink,
                    context,
                    1,
                  ),
                  _buildButton(
                    "Playlist",
                    FontAwesomeIcons.music,
                    Colors.blue,
                    context,
                    2,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton(
                    "Downloads",
                    FontAwesomeIcons.download,
                    Colors.green,
                    context,
                    3,
                  ),
                  _buildButton(
                    "Share",
                    FontAwesomeIcons.share,
                    Colors.indigo,
                    context,
                    4,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String title, IconData icon, Color primaryColor, BuildContext context, int id) {
    return GestureDetector(
      onTap: () {
        switch (id) {
          case 1:

            Get.toNamed(Routes.videoDownload);
            break;
          case 2:
            Get.toNamed(Routes.playListDownload);


            break;
          case 3:
            Get.toNamed(Routes.downloads);

            break;
            case 4:
            break;
          default:
            break;
        }
      },
      child: Container(
        width: 150.w,
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.w),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40.sp,
              color: Colors.white,
            ),
            SizedBox(height: 10.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.customText16(color: Colors.white,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
