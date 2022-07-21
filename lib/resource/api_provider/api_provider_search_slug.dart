import 'package:dio/dio.dart';
import 'package:whisky_hunter/src/comp/dialog/tm_dialog.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';

class ApiProviderSearchSlug {
  final Dio _dio = Dio();

  Future<List<AuctionDataModel>> fetchSlugList(String slug) async {
    List<AuctionDataModel> slugs = [];
    if (slug == "") {
      return slugs;
    }else if (slug == "cataway"){
      TMDialog.isShowing;
    }
    
      Response response =
          await _dio.get('https://whiskyhunter.net/api/auction_data/$slug');
      
        var getData = response.data as List;
        var listSlugData =
            getData.map((e) => AuctionDataModel.fromJson(e)).toList();
        return listSlugData;
     
  
  }
}
