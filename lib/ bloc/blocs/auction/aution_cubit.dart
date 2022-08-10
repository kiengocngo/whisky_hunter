import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction/auction.dart';
import 'package:whisky_hunter/dio/dio.dart';

class AuctionCubit extends Cubit<AuctionState> {
  AuctionCubit({required this.dio}) : super(const AuctionState(error: 'error'));
  final Dio dio;

  Future<void> getAuctionList() async {
    final autions = await DioClient().fetchAuctionList();
    if (state.status == AuctionStatus.initial) {
      final listAuction = autions.data;
      return emit(state.copyWith(
        status: AuctionStatus.success,
        auction: listAuction,
      ));
    }

    return emit(state.copyWith(
      status: AuctionStatus.failure,
      error: autions.error,
    ));
  }
}
