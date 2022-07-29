import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction/aution_state.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction_info/auctio_info_state.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction_info/auction_info_event.dart';
import 'package:whisky_hunter/src/data/model/auction_information_model.dart';

class AuctionInfoBloc extends Bloc<AuctionInfoEvent, AuctionInfoState> {
  AuctionInfoBloc({required this.dio}) : super((const AuctionInfoState())) {
    on<GetAuctionInfoList>(_onGetAuctionInfo);
  }
  final Dio dio;

  Future<void> _onGetAuctionInfo(
    GetAuctionInfoList event,
    Emitter<AuctionInfoState> emit,
  ) async {
    try {
      if (state.status == AuctionStatus.initial) {
        final auctionInfo = await _fetchAuctionInfoList();
        return emit(state.copyWith(
          status: AuctionStatus.success,
          auctionInfo: auctionInfo,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: AuctionStatus.failure));
    }
  }

  Future<List<AuctionInformations>> _fetchAuctionInfoList() async {
    final response =
        await dio.get('https://whiskyhunter.net/api/auctions_info');
    if (response.statusCode == 200) {
      var getData = response.data as List;
      var listAuctionInfo =
          getData.map((e) => AuctionInformations.fromJson(e)).toList();
      return listAuctionInfo;
    }
    throw Exception('error to fetch data');
  }
}
