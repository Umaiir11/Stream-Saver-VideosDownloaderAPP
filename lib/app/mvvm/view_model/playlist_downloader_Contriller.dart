
import 'package:flutter/cupertino.dart';

class PlayListdownloaderController{

  bool fieldsValidate = false;
  TextEditingController search_controller = TextEditingController();
  String? youtubePlaylistUrlValidator(String? value) {
    RegExp youtubePlaylistRegex = RegExp(
        r'^https?://(?:www\.|m\.)?youtube\.com/playlist\?list=([\w-]+)');



    if (value == null || value.isEmpty) {
      return 'Please enter a URL';
    } else if (!youtubePlaylistRegex.hasMatch(value)) {
      return 'Please enter a valid YouTube Playlist video URL';
    }
    return null;
  }

}