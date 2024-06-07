import 'dart:async';

import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../mvvm/model/playlist_model.dart';
import 'youtube_service.dart';

late dynamic fileName;
final yt = YoutubeExplode();
var _controller = Get.find<PlaylistService>();

Future downloadPlaylist(String playlistURL) async {
  try {
    var playlist = await yt.playlists.get(playlistURL);
    await for (var video in yt.playlists.getVideos(playlist.id)) {
      PlayListModel listModel = PlayListModel();
      listModel.setVideo(video);
      _controller.playList_list.add(listModel);
    }
    _controller.playList_list.refresh();
    _controller.isLoaded.value = true;
    _controller.isLoading.value = false;
  } catch (error) {
    _controller.isLoading.value = false;
  }
}
