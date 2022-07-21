import 'package:whisky_hunter/resource/api_provider/api_provider_search_slug.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';

class ApiRepositorySearchSlug {
  final _provider = ApiProviderSearchSlug();

  Future<List<AuctionDataModel>> fetchSlugList(String slug) {
    return _provider.fetchSlugList(slug);
  }
}
class NetWorkError extends Error{}
