import 'package:whisky_hunter/resource/api_provider/api_provider_auction.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';

class ApiRepositoryAuctionc {
  final _provider = ApiProviderAuction();

  Future<List<AuctionDataModel>> fetchAuctionList() {
    return _provider.fetchAuctionList();
  }
}
class NetWorkError extends Error{}
