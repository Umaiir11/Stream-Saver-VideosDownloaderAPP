import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../configs/app_textStyles.dart';
import '../service/download_manager.dart';

void showVideoOptions(BuildContext context, video, int videoNo, bool isPlaylist) async {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.w),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Select Video Quality!", style: AppTextStyles.customText14(color: Colors.black)),
              SizedBox(height: 20.h),
              FutureBuilder(
                future: getVideoQualityData(video.url),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CupertinoActivityIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error loading video quality options", style: AppTextStyles.customText12(color: Colors.black)),
                    );
                  } else if (snapshot.hasData) {
                    List<String> videoQualities = (snapshot.data! as Set).map((quality) => quality.toString()).toList();
                    return SizedBox(
                      height: 200.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: videoQualities.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setController(isPlaylist);
                              downloadPlaylistVideo(video, videoNo, index);
                              Navigator.pop(context);
                            },
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              child: ListTile(
                                leading: Icon(Icons.play_arrow, color: Colors.red),
                                title: Text(quilityNameConvert(videoQualities[index]), style: AppTextStyles.customText12(color: Colors.black)),
                                trailing: Icon(Icons.file_download, color: Colors.black),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: Text("No video quality options available", style: AppTextStyles.customText12(color: Colors.black)));
                  }
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

String quilityNameConvert(String txt) {
  return '${txt.replaceAll(RegExp(r'[^0-9]'), '')}p';
}