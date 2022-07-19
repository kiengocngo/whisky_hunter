import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/distilleries_info/distilleries_info_event.dart';
import 'package:whisky_hunter/%20bloc/distilleries_info/distilleries_info_state.dart';
import 'package:whisky_hunter/resource/repository/api_repository_distilleries_info.dart';

class DistilleriesInfoBloc extends Bloc<DistilleriesInfoEvent, DistilleriesInfoState>{
  DistilleriesInfoBloc() : super(DistilleriesInfoInitial()){
    final ApiRepositoryDistilleriesInfo _apiResDisInfo = ApiRepositoryDistilleriesInfo();
    on<GetDistilleriesInfoList>((event, emit ) async {
      try {
        emit(DistilleriesInfoLoading());
        final _disInfo = await _apiResDisInfo.fetchDistilleriesInfoList();
        emit(DistilleriesInfoLoaded(_disInfo));
        
      } on NetWorkError {
        emit(const DistilleriesInfoError('Failed to fetch data'));        
      }
    });
  }
}