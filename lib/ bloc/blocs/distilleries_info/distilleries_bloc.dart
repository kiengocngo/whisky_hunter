import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:whisky_hunter/resource/repository/api_repository_distilleries_info.dart';

import 'distilleries_info_event.dart';
import 'distilleries_info_state.dart';

class DistilleriesInfoBloc extends Bloc<DistilleriesInfoEvent, DistilleriesInfoState>{
  DistilleriesInfoBloc() : super(DistilleriesInfoInitial()){
    final ApiRepositoryDistilleriesInfo apiResDisInfo = ApiRepositoryDistilleriesInfo();
    on<GetDistilleriesInfoList>((event, emit ) async {
      try {
        emit(DistilleriesInfoLoading());
        final disInfo = await apiResDisInfo.fetchDistilleriesInfoList();
        emit(DistilleriesInfoLoaded(disInfo));
        
      } on NetWorkError {
        emit(const DistilleriesInfoError('Failed to fetch data'));        
      }
    });
  }
}