import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'youtube_service.dart';


final yt = YoutubeExplode();
var controller;

void setController(playlist) {
  debugPrint("calles");
  if (playlist) {
    controller = Get.find<PlaylistService>();
    debugPrint("Done");
  } else {
    controller = Get.find<YTService>();
  }
}

Future<Set> getVideoQualityData(videoUrl) async {
  var manifest = await yt.videos.streamsClient.getManifest(videoUrl);
  var video = manifest.muxed.getAllVideoQualities();
  return video;
}

Future<bool> requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    }
  }
  return false;
}

downloadPlaylistVideo(Video videoD, index, quilityNo) async {
  try {
    var manifest = await yt.videos.streamsClient.getManifest(videoD.url);
    var video = manifest.muxed.elementAt(quilityNo);
    var fileName =
    '${videoD.title}${DateTime.now().millisecondsSinceEpoch}.${video.container.name.toString()}'
        .replaceAll(r'\', '')
        .replaceAll('/', '')
        .replaceAll('*', '')
        .replaceAll(':', '')
        .replaceAll('?', '')
        .replaceAll('"', '')
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('|', '');
    var vidStream = yt.videos.streamsClient.get(video);
    if ((await requestPermission(Permission.videos) &&
        await requestPermission(Permission.audio)) ||
        await requestPermission(Permission.storage)) {
      Directory dir =
      Directory('/storage/emulated/0/Download/Stream Saver');

      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }

      var file = File('${dir.path}/$fileName');
      if (file.existsSync()) {}

      controller.ytPlaylist.elementAt(index).setDownloadStart(true);
      controller.ytPlaylist.elementAt(index).setDownloading(true);
      controller.ytPlaylist.refresh();
      var fileStream = file.openWrite(mode: FileMode.writeOnlyAppend);
      var len = video.size.totalBytes;
      var count = 0;
      await for (final data in vidStream) {
        count += data.length;
        var progress = ((count / len) * 100).ceil();
        controller.ytPlaylist.elementAt(index).setProgressBar(progress);
        controller.ytPlaylist.refresh();
        fileStream.add(data);
      }
      controller.ytPlaylist.elementAt(index).setDownloading(false);
      controller.ytPlaylist.elementAt(index).setCompleted(true);
      await fileStream.flush();
      await fileStream.close();
      // Save the video to the gallery
      final result = await ImageGallerySaver.saveFile(file.path);
      if (result['isSuccess']) {
        print('Video saved to gallery successfully.');
      } else {
        print('Failed to save video to gallery.');
      }
    }
  } catch (e) {
    e.printError();
  }
}
