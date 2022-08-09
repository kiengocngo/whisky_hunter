import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction/auction.dart';
import 'package:whisky_hunter/dio/config_dio.dart';

import '../../../src/data/model/distilleries_info.dart';
part 'distilleries_info_state.dart';

class DistilleriesInfoCubit extends Cubit<DistilleriesInfoState> {
  DistilleriesInfoCubit({required this.dio})
      : super(const DistilleriesInfoState(error: ''));
  final Dio dio;

  Future<void> getListDistillInfo() async {
    try {
      if (state.status == AuctionStatus.initial) {
        final distilleriesInfo = await DioClient().fetchDistilleriesList();
        emit(state.copyWith(
          status: AuctionStatus.success,
          distilleries: distilleriesInfo,
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
