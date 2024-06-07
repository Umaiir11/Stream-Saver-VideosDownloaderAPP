import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../mvvm/model/playlist_model.dart';

class YTService extends GetxController {
  RxBool isLoaded = false.obs;
  RxBool isLoading = false.obs;
  RxList<PlayListModel> ytPlaylist = RxList();
}


class PlaylistService extends GetxController {
  RxBool isLoaded = false.obs;
  RxBool isLoading = false.obs;
  RxList<PlayListModel> playList_list = RxList();

  // Define the ytPlaylist getter
  RxList<PlayListModel> get ytPlaylist => playList_list;
}
