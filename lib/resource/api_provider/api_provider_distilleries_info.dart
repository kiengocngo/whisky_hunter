import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:whisky_hunter/src/data/model/distilleries_info.dart';

class ApiProviderDistilleriesInfo {
  
  final Dio _dio = Dio();
  final String _url = 'https://whiskyhunter.net/api/distilleries_info/';
  Future<List<DistilleriesInfo>> fetchDistilleriesInfoList() async {
    try{
      Response response = await _dio.get(_url);
      if(response.statusCode == 200) {
        var getData = response.data as List;
        var listDistilleriesInfo = getData.map((e) => DistilleriesInfo.fromJson(e)).toList();
        return listDistilleriesInfo;
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