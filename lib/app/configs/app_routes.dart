import 'package:get/get.dart';

import '../mvvm/view/dashboard.dart';
import '../mvvm/view/downloads_view.dart';
import '../mvvm/view/playlist_view.dart';
import '../mvvm/view/video_view.dart';

abstract class Routes {
  Routes._();
  static const dashboard = '/dashboard';
  static const videoDownload = '/videoDownload';
  static const playListDownload = '/playListDownload';
  static const downloads = '/downloads';
}

abstract class AppPages {
  AppPages._();

  static final routes = <GetPage>[

    GetPage(
      name: Routes.dashboard,
      page: () =>  DashboardView(),
    ),GetPage(
      name: Routes.playListDownload,
      page: () =>  YtPlayListView()
    ),
    GetPage(
      name: Routes.videoDownload,
      page: () =>  VideoDownloadView()
    ),
 GetPage(
      name: Routes.downloads,
      page: () =>  DownloadsView()
    ),


  ];
}
