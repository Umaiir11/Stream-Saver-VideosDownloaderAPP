import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


import '../../configs/app_textStyles.dart';
import '../../service/download_service.dart';
import '../../service/playlist_service.dart';
import '../../service/youtube_service.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/custom_textfield.dart';
import '../view_model/playlist_downloader_Contriller.dart';

class YtPlayListView extends StatefulWidget {
  const YtPlayListView({super.key});

  @override
  State<YtPlayListView> createState() => _YtPlayListViewState();
}

class _YtPlayListViewState extends State<YtPlayListView> {
  final playlistController = Get.find<PlaylistService>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final playListdownloaderController = Get.find<PlayListdownloaderController>();
  TextEditingController plylistUrlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
        
          appBar: CustomAppBar(  title: 'Playlist Downloader', centerTitle: true, leadingWidth: 80.w),
        
          body: SafeArea(
            child: Container(
              color: Colors.white,
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenWidth,
              child: Form(
                key: _formKey,
                child: Column(children: [
                  CustomTextFormField(
                    autofillHints: const [AutofillHints.url],

                    validator: playListdownloaderController.youtubePlaylistUrlValidator,
                    controller:plylistUrlController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      errorStyle: AppTextStyles.customText12(),
                      hintText: "Youtube Playlist Url...",
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
                          playlistController.isLoading.value = true;
                          playlistController.playList_list.clear();
                          await downloadPlaylist(plylistUrlController.text.trim());
                          playlistController.isLoading.value;
        
                          Get.back();
                        } else {
                          playListdownloaderController.fieldsValidate = true;
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
                    return playlistController.isLoaded.value
                        ? Text("Videos List", style: AppTextStyles.customText22(color: Colors.black))
                        : SizedBox();
                  }),
                   SizedBox(
                    height: 10.h,
                  ),
                  //// LISTVIEW
                  Expanded(
                    child: Obx(() => playlistController.isLoaded.value
                        ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: playlistController.playList_list.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:  EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 2.h),
                          child: Card(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(4),
                              leading: Image.network(
                                  "https://img.youtube.com/vi/${playlistController.playList_list.elementAt(index).getVideo.id}/mqdefault.jpg"),
                              title: Center(
                                child: Text(
                                    playlistController.playList_list
                                        .elementAt(index)
                                        .getVideo
                                        .title,
                                    maxLines: 2,
                                    style: const TextStyle(fontSize: 13)),
                              ),
                              trailing: Padding(
                                padding:  EdgeInsets.only(right: 4.w),
                                child: playlistController.playList_list
                                    .elementAt(index)
                                    .downloading
                                    ?  CircleAvatar(
                                    maxRadius: 12,
                                    backgroundColor: Colors.black,
                                    child: Icon(
                                      Icons.downloading_outlined,
                                      size: 16.sp,
                                      color: Colors.white,
                                    ))
                                    : playlistController.playList_list
                                    .elementAt(index)
                                    .getCompleted
                                    ?  CircleAvatar(
                                    maxRadius: 12,
                                    backgroundColor: Colors.green,
                                    child: Icon(
                                      Icons.done,
                                      size: 18.sp,
                                      color: Colors.white,
                                    ))
                                    : IconButton(
                                  splashRadius: 24,
                                  onPressed: () {
                                    showVideoOptions(
                                        context,
                                        playlistController.playList_list
                                            .elementAt(index)
                                            .getVideo,
                                        index,
                                        true);
                                  },
                                  icon:  FaIcon(
                                  FontAwesomeIcons.download,
                                  color: Colors.black,
                                  size: 18.sp,
                                ),
                                ),
                              ),
                              subtitle: Padding(
                                padding:  EdgeInsets.only(top: 4.h),
                                child: playlistController.playList_list
                                    .elementAt(index)
                                    .getDownloadStart
                                    ? playlistController.playList_list
                                    .elementAt(index)
                                    .getCompleted
                                    ? const Center(
                                  child: Text(
                                    "Completed!",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                                    : Center(
                                  child: LinearPercentIndicator(
                                    lineHeight: 12.0,
                                    percent: playlistController.playList_list
                                        .elementAt(index)
                                        .getProgressBar
                                        .toDouble() /
                                        100,
                                    barRadius:
                                    const Radius.circular(50),
                                    center: Text(
                                      "${playlistController.playList_list.elementAt(index).getProgressBar}%",
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black),
                                    ),
                                    progressColor: Colors.lightBlueAccent,
                                    backgroundColor: Colors.grey[300],
                                  ),
                                )
                                    : Container(),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                        : Container()),
                  ),
        
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
