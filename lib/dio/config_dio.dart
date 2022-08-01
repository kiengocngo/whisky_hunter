import 'package:dio/dio.dart';
import 'package:whisky_hunter/src/data/model/model.dart';
import 'dio.dart';

class DioClient {
  DioClient()
      : _dio = Dio(BaseOptions(
          baseUrl: Endpoints.baseURL,
          connectTimeout: Endpoints.connectionTimeout,
          receiveTimeout: Endpoints.receiveTimeout,
          contentType: 'application/json',
        ));
  late final Dio _dio;

  Future<List<AuctionDataModel>> fetchAuctionList() async {
    try {
      final response = await _dio.get('/auctions_data');
      var getData = response.data as List;
      var listAuctionData =
          getData.map((e) => AuctionDataModel.fromJson(e)).toList();
      return listAuctionData;
    } on DioError catch (err) {
      final errorMesage = DioException.fromDioError(err).toString();
      throw errorMesage;
    }
  }

  Future<List<AuctionInformations>> fetchAuctionInfoList() async {
    try {
      final response = await _dio.get('/auctions_info');

      var getData = response.data as List;
      var listAuctionInfo =
          getData.map((e) => AuctionInformations.fromJson(e)).toList();
      return listAuctionInfo;
    } on DioError catch (err) {
      final errorMesage = DioException.fromDioError(err).toString();
      throw errorMesage;
    }
  }

  Future<List<DistilleriesInfo>> fetchDistilleriesList() async {
    try {
      final response = await _dio.get('/distilleries_info/');

      var getData = response.data as List;
      var listDistilleries =
          getData.map((e) => DistilleriesInfo.fromJson(e)).toList();
      return listDistilleries;
    } on DioError catch (err) {
      final errorMesage = DioException.fromDioError(err).toString();
      throw errorMesage;
    }
  }
}
