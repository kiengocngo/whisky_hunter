import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/dio/config_dio.dart';
import '../auction/aution_state.dart';
import 'distilleries_info_event.dart';
import 'distilleries_info_state.dart';

class DistilleriesInfoBloc
    extends Bloc<DistilleriesInfoEvent, DistilleriesInfoState> {
  DistilleriesInfoBloc({required this.dio})
      : super(const DistilleriesInfoState(error: '')) {
    on<GetDistilleriesInfoList>(_onGetDistilleriesInfo);
  }
  final Dio dio;
  Future<void> _onGetDistilleriesInfo(GetDistilleriesInfoList event,
      Emitter<DistilleriesInfoState> emit) async {
    try {
      if (state.status == AuctionStatus.initial) {
        final distilleries = await DioClient().fetchDistilleriesList();
        return emit(state.copyWith(
          status: AuctionStatus.success,
          distilleries: distilleries,
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
