import 'package:dio/dio.dart';
import 'package:whisky_hunter/src/data/model/distilleries_slug.dart';

class ApiProviderDistilleriesSlug {
  final Dio _dio = Dio();

  Future<List<DistilleriesSlugModel>> fetchSlugList(String slug) async {
    List<DistilleriesSlugModel> slugs = [];
    if (slug == "") {
      return slugs;
    }
    
      Response response =
          await _dio.get('https://whiskyhunter.net/api/auction_data/$slug');
      
        var getData = response.data as List;
        var listSlugData =
            getData.map((e) => DistilleriesSlugModel.fromJson(e)).toList();
        return listSlugData;
     
  
  }
}
