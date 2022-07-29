import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/src/data/model/distilleries_info.dart';
import '../auction/aution_state.dart';
import 'distilleries_info_event.dart';
import 'distilleries_info_state.dart';

class DistilleriesInfoBloc
    extends Bloc<DistilleriesInfoEvent, DistilleriesInfoState> {
  DistilleriesInfoBloc({required this.dio})
      : super(const DistilleriesInfoState()) {
    on<GetDistilleriesInfoList>(_onGetDistilleriesInfo);
  }
  final Dio dio;
  Future<void> _onGetDistilleriesInfo(GetDistilleriesInfoList event,
      Emitter<DistilleriesInfoState> emit) async {
    try {
      if (state.status == AuctionStatus.initial) {
        final distilleries = await _fetchDistilleriesList();
        return emit(state.copyWith(
          status: AuctionStatus.success,
          distilleries: distilleries,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: AuctionStatus.failure));
    }
  }

  Future<List<DistilleriesInfo>> _fetchDistilleriesList() async {
    final response =
        await dio.get('https://whiskyhunter.net/api/distilleries_info/');
    if (response.statusCode == 200) {
      var getData = response.data as List;
      var listDistilleries =
          getData.map((e) => DistilleriesInfo.fromJson(e)).toList();
      return listDistilleries;
    }
    throw Exception('error to fetch data');
  }
}
