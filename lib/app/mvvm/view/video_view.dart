import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


import '../../configs/app_permissions.dart';
import '../../configs/app_textStyles.dart';
import '../../service/download_service.dart';
import '../../service/youtube_service.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/custom_textfield.dart';
import '../view_model/videodownloader_controller.dart';

class VideoDownloadView extends StatefulWidget {
  const VideoDownloadView({Key? key}) : super(key: key);

  @override
  State<VideoDownloadView> createState() => _VideoDownloadViewState();
}

class _VideoDownloadViewState extends State<VideoDownloadView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final videodownloaderController = Get.find<VideodownloaderController>();
 final youtubeController = Get.find<YTService>();
  //final youtubeController = Get.put(YTService());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Hide the keyboard when tapped
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(

        child: Scaffold(
          appBar: CustomAppBar(  title: 'Video Downloader', centerTitle: true, leadingWidth: 80.w),
          body: Container(
            color: Colors.white,
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    validator: videodownloaderController.youtubeUrlValidator,
                    autofillHints: const [AutofillHints.url],
                    controller: videodownloaderController.search_controller,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      errorStyle: AppTextStyles.customText12(),
                      hintText: "Youtube Video Url...",
                      hintStyle: AppTextStyles.customText14(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: context.theme.primaryColor.withOpacity(0.3)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: context.theme.primaryColor.withOpacity(0.3)),
                      ),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                    ),
                    labelText: 'URL',
                    validationText: 'Please fill the field',
                    keyboardType: TextInputType.url,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextElevatedBtn(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Get.dialog(
                             Center(
                              child: SizedBox(
                                width: 50.h, // Adjust width and height according to your animation size
                                height: 50.h,
                                child: Lottie.asset('assets/loader.json'), // Placeholder animation
                              ),
                            ),
                            barrierDismissible: false,
                          );
                          youtubeController.isLoading.value = true;
                          await download(videodownloaderController.search_controller.text.trim());
                          youtubeController.isLoading.value;
                          Get.back();
                        } else {
                          videodownloaderController.fieldsValidate = true;
                        }
                      },
                      btnText: 'Search',
                      textStyle: AppTextStyles.customText16(color: Colors.white),
                      style: ElevatedButton.styleFrom(
                          maximumSize: Size(0.6.sw, 47.h), backgroundColor: Colors.lightBlueAccent)),
                  SizedBox(
                    height: 25.h,
                  ),
                  Obx(() {
                    return youtubeController.isLoaded.value
                        ? Text("Videos List", style: AppTextStyles.customText22(color: Colors.black))
                        : SizedBox();
                  }),
                  Expanded(
                    child: Obx(() => youtubeController.isLoaded.value
                        ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: youtubeController.ytPlaylist.length,
                      itemBuilder: (context, index) {
                        final video = youtubeController.ytPlaylist.elementAt(index).getVideo;
                        final isDownloading = youtubeController.ytPlaylist.elementAt(index).downloading;
                        final isCompleted = youtubeController.ytPlaylist.elementAt(index).getCompleted;
                        final progress = youtubeController.ytPlaylist.elementAt(index).getProgressBar.toDouble();
        
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(15.0),
                            elevation: 5.0,
                            shadowColor: Colors.grey.withOpacity(0.5),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15.0),
                              onTap: () {
                                // Handle tap action here
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                                        child: Image.network(
                                          "https://img.youtube.com/vi/${video.id}/hqdefault.jpg",
                                          width: double.infinity,
                                          height: 200.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      if (isDownloading)
                                        Positioned(
                                          top: 10,
                                          left: 10,
                                          child: CircleAvatar(
                                            maxRadius: 16,
                                            backgroundColor: Colors.red,
                                            child: Icon(
                                              Icons.downloading_outlined,
                                              size: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      if (isCompleted)
                                        Positioned(
                                          top: 10.h,
                                          left: 10.w,
                                          child: CircleAvatar(
                                            maxRadius: 16,
                                            backgroundColor: Colors.lightBlueAccent,
                                            child: Icon(
                                              Icons.done,
                                              size: 18.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          video.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        youtubeController.ytPlaylist.elementAt(index).getDownloadStart
                                            ? isCompleted
                                            ? Center(
                                          child: Text(
                                              "Completed!",
                                              style: AppTextStyles.customText12(color: Colors.blue)
                                          ),
                                        )
                                            : LinearPercentIndicator(
                                          lineHeight: 12.0,
                                          percent: progress / 100,
                                          barRadius: Radius.circular(50),
                                          center: Text(
                                            "${progress.toInt()}%",
                                            style: TextStyle(fontSize: 10, color: Colors.black),
                                          ),
                                          progressColor: Colors.lightBlueAccent,
                                          backgroundColor: Colors.grey[300],
                                        )
                                            : Container(),
                                        if (!isDownloading && !isCompleted)
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                              splashRadius: 24,
                                              onPressed: () async {
                                                showVideoOptions(context, video, index, false);
                                              },
                                              icon: FaIcon(
                                                FontAwesomeIcons.download,
                                                color: Colors.black,
                                                size: 18.sp,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
        
        
                        : Container()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
