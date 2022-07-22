import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction/aution_event.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction/aution_state.dart';
import 'package:whisky_hunter/resource/repository/api_repository_auction.dart';

class AuctionBloc extends Bloc<AuctionEvent, AuctionState>{
  AuctionBloc() : super(AuctionInitial()){
    final ApiRepositoryAuctionc apiRepositoryAuction = ApiRepositoryAuctionc();
    on<GetAuctionList>((event, emit ) async {
      try {
        emit(AuctionLoading());
        final auctionList = await apiRepositoryAuction.fetchAuctionList();
        emit(AuctionLoaded(auctionList));
        
      } on NetWorkError {
        emit(const AuctionError('Failed to fetch data'));        
      }
    });
  }
}