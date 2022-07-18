import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:whisky_hunter/src/data/model/auction_information_model.dart';

class ApiProviderAuctionInformation {
  final Dio _dio = Dio();
  final String _url = 'https://whiskyhunter.net/api/auctions_info';
  Future<List<AuctionInformations>> fetchAuctionInformationList() async {
   try{
      Response response = await _dio.get(_url);
      if(response.statusCode == 200) {
        var getData = response.data as List;
        var listAuctionInfo = getData.map((e) => AuctionInformations.fromJson(e)).toList();
        return listAuctionInfo;
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