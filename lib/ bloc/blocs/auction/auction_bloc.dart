import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:whisky_hunter/dio/config_dio.dart';
import 'auction.dart';

class AuctionBloc extends Bloc<AuctionEvent, AuctionState> {
  AuctionBloc({required this.dio}) : super(const AuctionState(error: '')) {
    on<GetAuctionList>(_onGetAuction);
  }
  final Dio dio;

  Future<void> _onGetAuction(
    GetAuctionList event,
    Emitter<AuctionState> emit,
  ) async {
    try {
      if (state.status == AuctionStatus.initial) {
        final autions = await DioClient().fetchAuctionList();
        return emit(state.copyWith(
          status: AuctionStatus.success,
          auction: autions,
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
