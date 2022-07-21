import 'package:whisky_hunter/resource/api_provider/api_provider_distilleries_slug.dart';
import 'package:whisky_hunter/src/data/model/distilleries_slug.dart';

class ApiRepositoryDistilleriesSlug {
  final _provider = ApiProviderDistilleriesSlug();

  Future<List<DistilleriesSlugModel>> fetchSlugList(String slug) {
    return _provider.fetchSlugList(slug);
  }
}
class NetWorkError extends Error{}
