import 'package:get/get.dart';

import '../mvvm/view_model/dashboard_controller.dart';
import '../mvvm/view_model/playlist_downloader_Contriller.dart';
import '../mvvm/view_model/videodownloader_controller.dart';
import 'youtube_service.dart';

class PermissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put((YTService()));
    Get.put(PlaylistService());
    Get.put(VideodownloaderController());
    Get.put(DashboardController());
    Get.put(PlayListdownloaderController());
  }
}
