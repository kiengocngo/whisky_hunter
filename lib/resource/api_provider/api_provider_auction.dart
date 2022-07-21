import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:whisky_hunter/dio/config_dio.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';

class ApiProviderAuction {
  final NetworkManager networkManager = NetworkManager();
  final Dio _dio = Dio();
  Future<List<AuctionDataModel>> fetchAuctionList() async {
    try{
      
      Response response = await _dio.get('${networkManager.opts.baseUrl}/auctions_data');
      
        var getData = response.data as List;
        var listAuctionData = getData.map((e) => AuctionDataModel.fromJson(e)).toList();
        return listAuctionData;
    
      
    }on DioError catch (e){
      log(e.toString());
      throw Exception("Failded to fecth data");
    }
  }
}