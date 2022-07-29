import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction/aution_event.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction/aution_state.dart';
import 'package:dio/dio.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';

class AuctionBloc extends Bloc<AuctionEvent, AuctionState> {
  AuctionBloc({required this.dio}) : super(const AuctionState()) {
    on<GetAuctionList>(_onGetAuction);
  }
  final Dio dio;

  Future<void> _onGetAuction(
    GetAuctionList event,
    Emitter<AuctionState> emit,
  ) async {
    try {
      if (state.status == AuctionStatus.initial) {
        final autions = await _fetchAuctionList();
        return emit(state.copyWith(
          status: AuctionStatus.success,
          auction: autions,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: AuctionStatus.failure));
    }
  }

  Future<List<AuctionDataModel>> _fetchAuctionList() async {
    final response = await dio.get('https://whiskyhunter.net/api/auctions_data');
    if (response.statusCode == 200) {
      var getData = response.data as List;
      var listAuctionData =
          getData.map((e) => AuctionDataModel.fromJson(e)).toList();
      return listAuctionData;
    }
    throw Exception('error to fecth data');
  }
}
