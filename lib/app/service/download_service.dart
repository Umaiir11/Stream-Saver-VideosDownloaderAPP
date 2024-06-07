import 'dart:async';

import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../mvvm/model/playlist_model.dart';
import 'youtube_service.dart';


final ytExplode = YoutubeExplode();
final ytService = Get.find<YTService>();
Future download(String videoUrl) async {
  try {
    Video video = await ytExplode.videos.get(videoUrl);
    PlayListModel playListModel = PlayListModel();
    playListModel.setVideo(video);
    ytService.ytPlaylist.add(playListModel);
    ytService.ytPlaylist.refresh();
    ytService.isLoaded.value = true;
    ytService.isLoading.value = false;
  } catch (error) {
    ytService.isLoading.value = false;
  }
}
