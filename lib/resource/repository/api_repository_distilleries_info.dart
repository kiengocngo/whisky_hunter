import 'package:whisky_hunter/resource/api_provider/api_provider_distilleries_info.dart';
import 'package:whisky_hunter/src/data/model/distilleries_info.dart';

class ApiRepositoryDistilleriesInfo {
  final _provider = ApiProviderDistilleriesInfo();

  Future<List<DistilleriesInfo>> fetchDistilleriesInfoList() {
    return _provider.fetchDistilleriesInfoList();
  }
}
class NetWorkError extends Error{}
