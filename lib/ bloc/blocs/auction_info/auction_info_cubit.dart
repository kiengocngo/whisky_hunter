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
    final auctionInfo = await DioClient().fetchAuctionInfoList();

    if (state.status == AuctionStatus.initial) {
      final listAuctionInfo = auctionInfo.data;
      return emit(state.copyWith(
        status: AuctionStatus.success,
        auctionInfo: listAuctionInfo,
      ));
    }

    return emit(state.copyWith(
      status: AuctionStatus.failure,
      error: auctionInfo.error,
    ));
  }
}
