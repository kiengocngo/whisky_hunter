import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';

class ApiProviderSearchSlug {
  
  final Dio _dio = Dio();
  final String _url = 'https://whiskyhunter.net/api/auction_data/catawiki';
  Future<List<AuctionDataModel>> fetchSlugList() async {
    try{
      Response response = await _dio.get(_url);
      if(response.statusCode == 200) {
        var getData = response.data as List;
        var listSlugData = getData.map((e) => AuctionDataModel.fromJson(e)).toList();
        return listSlugData;
      }
      else {
        throw Exception('Failded to load data');
      }
      
    }on DioError catch (e){
      log(e.toString());
      throw Exception("Failded to fecth data");
    }
  }
}