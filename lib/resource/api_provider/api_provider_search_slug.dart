import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';

class ApiProviderSearchSlug {
  final Dio _dio = Dio();
  Future<List<AuctionDataModel>> fetchSlugList(String? slug) async {
    List<AuctionDataModel> slugs = [];
    try {
      Response response =
          await _dio.get('https://whiskyhunter.net/api/auction_data/bonhams');
      if (response.statusCode == 200) {
        var getData = response.data as List;
        slugs = getData.map((e) => AuctionDataModel.fromJson(e)).toList();
        if (slug != null) {
          slugs = slugs
              .where((element) => element.allAuctionsLotsCount
                  .toString()
                  .toLowerCase()
                  .contains((slug.toLowerCase())))
              .toList();
        } else {
          print('fetch error');
        }
      } else {
        throw Exception('Failded to load data');
      }
    } on DioError catch (e) {
      log(e.toString());
      throw Exception('Failded to fecth data');
    }
    return slugs;
  }
}
