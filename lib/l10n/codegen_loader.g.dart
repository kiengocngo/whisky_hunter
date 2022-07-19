// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "home_text": "Home",
  "setting_text": "Setting",
  "branch": "WHISKY HUNTER",
  "seeMore": "See more...",
  "language": "Language",
  "select_language": "Select language",
   "vote": "Vote",
    "rate": "Rate",
    "country": "Country"
};
static const Map<String,dynamic> vi = {
  "home_text": "Trang chủ",
  "setting_text": "Cài đặt",
  "branch": "ĐẤU GIÁ RƯỢU",
  "seeMore": "Xem thêm",
  "language": "Ngôn ngữ",
  "select_language": "Chọn ngôn ngữ",
   "vote": "Lượt bình chọn",
    "rate": "Đánh giá",
    "country": "Nơi sản xuất",
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "vi": vi};
}
