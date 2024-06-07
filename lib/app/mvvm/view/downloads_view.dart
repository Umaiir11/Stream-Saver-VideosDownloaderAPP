import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../configs/app_textStyles.dart';
import '../../service/video_helper.dart';
import '../../widgets/custom_appbar.dart';

class DownloadsView extends StatefulWidget {
  const DownloadsView({Key? key}) : super(key: key);

  @override
  State<DownloadsView> createState() => _DownloadsViewState();
}

class _DownloadsViewState extends State<DownloadsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        appBar: CustomAppBar(title: 'Downloads', centerTitle: true, leadingWidth: 80.w),
        body: Container(
          color: Colors.white,
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: VideoHelper.getVideoFiles(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                              child: Card(
                                child: ListTile(
                                  onTap: () {
                                    VideoHelper.launchInExternalPlayer(snapshot.data!.elementAt(index).path);
                                  },
                                  trailing: CircleAvatar(
                                    maxRadius: 12.h,
                                    backgroundColor: Colors.lightBlueAccent,
                                    child: Icon(
                                      Icons.done,
                                      size: 16.h,
                                    ),
                                  ),
                                  leading: SizedBox(
                                    width: 50.h, // Adjust width and height according to your animation size
                                    height: 50.h,
                                    child: Lottie.asset('assets/downloaded.json'), // Placeholder animation
                                  ),
                                  title: Text(
                                    snapshot.data!.elementAt(index).path.split('/').last,
                                    style: AppTextStyles.customText12(color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Center(
                                    child: Text(
                                      "Completed!",
                                      style: AppTextStyles.customText12(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return  Center(
                          child:    Center(
                            child: SizedBox(
                              width: 50.h, // Adjust width and height according to your animation size
                              height: 50.h,
                              child: Lottie.asset('assets/loader.json'), // Placeholder animation
                            ),
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
