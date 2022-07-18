import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/aution_bloc/auction/aution_event.dart';
import 'package:whisky_hunter/%20bloc/aution_bloc/auction/aution_state.dart';
import 'package:whisky_hunter/resource/repository/api_repository_auction.dart';

class AuctionBloc extends Bloc<AuctionEvent, AuctionState>{
  AuctionBloc() : super(AuctionInitial()){
    final ApiRepositoryAuctionc _apiRepositoryAuction = ApiRepositoryAuctionc();
    on<GetAuctionList>((event, emit ) async {
      try {
        emit(AuctionLoading());
        final auctionList = await _apiRepositoryAuction.fetchAuctionList();
        emit(AuctionLoaded(auctionList));
        
      } on NetWorkError {
        emit(const AuctionError('Failed to fetch data'));        
      }
    });
  }
}