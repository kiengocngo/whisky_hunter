// import 'package:equatable/equatable.dart';

// abstract class AuctionEvent extends Equatable {
//   const AuctionEvent();

//   @override
//   List<Object> get props => [];
// }

// class GetAuctionList extends AuctionEvent{}
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction/auction.dart';
import 'package:whisky_hunter/dio/dio.dart';

class AuctionCubit extends Cubit<AuctionState> {
  AuctionCubit({required this.dio}) : super(const AuctionState(error: 'error'));
  final Dio dio;

  Future<void> getAuctionList() async {
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
