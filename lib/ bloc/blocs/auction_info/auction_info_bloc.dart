import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction_info/auctio_info_state.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction_info/auction_info_event.dart';
import 'package:whisky_hunter/resource/repository/api_repository_auction_info.dart';

class AuctionInfoBloc extends Bloc<AuctionInfoEvent, AuctionInfoState>{
  AuctionInfoBloc() : super(AuctionInfoInitial()){
    final ApiRepositoryAuctionInfo apiRepositoryAuctionInfo= ApiRepositoryAuctionInfo();
    on<GetAuctionInfoList>((event, emit) async {
      try {
        emit(AuctionInfoLoading());
        final auctionInfoList = await apiRepositoryAuctionInfo.fecthAuctionInfoList();
        emit(AuctionInfoLoaded(auctionInfoList));
      } on NetWorkError {
        emit(const AuctionInfoError("Failded to fecth data"));
      }
    });
  }
}