import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/dio/config_dio.dart';
import '../auction/auction.dart';
import 'aution_info.dart';

class AuctionInfoBloc extends Bloc<AuctionInfoEvent, AuctionInfoState> {
  AuctionInfoBloc({required this.dio})
      : super((const AuctionInfoState(error: ''))) {
    on<GetAuctionInfoList>(_onGetAuctionInfo);
  }
  final Dio dio;

  Future<void> _onGetAuctionInfo(
    GetAuctionInfoList event,
    Emitter<AuctionInfoState> emit,
  ) async {
    try {
      if (state.status == AuctionStatus.initial) {
        final auctionInfo = await DioClient().fetchAuctionInfoList();
        return emit(state.copyWith(
          status: AuctionStatus.success,
          auctionInfo: auctionInfo,
        ));
      }
    } catch (_) {
      emit(state.copyWith(
        status: AuctionStatus.failure,
        error: _.toString(),
      ));
    }
  }
}
