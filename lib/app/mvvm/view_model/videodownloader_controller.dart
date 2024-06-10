
import 'package:flutter/cupertino.dart';

class VideodownloaderController{

  bool fieldsValidate = false;
  TextEditingController search_controller = TextEditingController();
  String? youtubeUrlValidator(String? value) {
    RegExp youtubeUrlRegex = RegExp(r'^https?://(?:www\.|m\.)?(?:youtube\.com/(?:watch\?v=|embed/|v/)|youtu\.be/)([\w-]+)');



    if (value == null || value.isEmpty) {
      return 'Please enter a URL';
    } else if (!youtubeUrlRegex.hasMatch(value)) {
      return 'Please enter a valid YouTube video URL';
    }
    return null;
  }

}