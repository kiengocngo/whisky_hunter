import 'package:whisky_hunter/resource/api_provider/api_provider_auction_information.dart';
import 'package:whisky_hunter/src/data/model/auction_information_model.dart';

class ApiRepositoryAuctionInfo {
  final _provider = ApiProviderAuctionInformation();

  Future<List<AuctionInformations>> fecthAuctionInfoList(){
    return _provider.fetchAuctionInformationList();
  }
}

class NetWorkError extends Error{}