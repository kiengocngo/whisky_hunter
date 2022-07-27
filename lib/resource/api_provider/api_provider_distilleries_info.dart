import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:whisky_hunter/dio/config_dio.dart';
import 'package:whisky_hunter/src/data/model/distilleries_info.dart';

class ApiProviderDistilleriesInfo {
  final NetworkManager networkManager = NetworkManager();
  final Dio _dio = Dio();
  Future<List<DistilleriesInfo>> fetchDistilleriesInfoList() async {
    try{
       Response response = await _dio.get('${networkManager.opts.baseUrl}/distilleries_info/');
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