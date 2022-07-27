import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:whisky_hunter/src/comp/dialog/tm_dialog.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';

class ApiProviderSearchSlug {
  final Dio _dio = Dio();

  Future<List<AuctionDataModel>> fetchSlugList(String slug) async {
    List<AuctionDataModel> slugs = [];
    if (slug == "") {
      return slugs;
    } else if (slug == "cataway") {
      TMDialog.isShowing;
    }
    try {
      Response response =
          await _dio.get('https://whiskyhunter.net/api/auction_data/$slug');
      if (response.statusCode == 200) {
        var getData = response.data as List;
        var listSlugData =
            getData.map((e) => AuctionDataModel.fromJson(e)).toList();
        return listSlugData;
      } else {
        throw Exception('Failded to load data');
      }
    } on DioError catch (e) {
      log(e.toString());
      throw Exception("Failded to fecth data");
    }
  }
}
