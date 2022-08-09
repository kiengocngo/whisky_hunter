import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction/auction.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction_info/aution_info.dart';
import 'package:whisky_hunter/dio/config_dio.dart';

class AuctionInfoCubit extends Cubit<AuctionInfoState> {
  AuctionInfoCubit({required this.dio})
      : super(const AuctionInfoState(error: ''));
  final Dio dio;

  Future<void> getListAucionInfo() async {
    try {
      if (state.status == AuctionStatus.initial) {
        final auctionInfo = await DioClient().fetchAuctionInfoList();
        emit(state.copyWith(
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
