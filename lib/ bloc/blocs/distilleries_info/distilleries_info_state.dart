import 'package:equatable/equatable.dart';
import 'package:whisky_hunter/src/data/model/distilleries_info.dart';

import '../auction/aution_state.dart';

class DistilleriesInfoState extends Equatable {
  const DistilleriesInfoState(
      {this.status = AuctionStatus.initial,
      this.distilleries = const <DistilleriesInfo>[]});

  final List<DistilleriesInfo> distilleries;
  final AuctionStatus status;

  DistilleriesInfoState copyWith({
    AuctionStatus? status,
    List<DistilleriesInfo>? distilleries,
  }) {
    return DistilleriesInfoState(
        status: status ?? this.status,
        distilleries: distilleries ?? this.distilleries);
  }

  @override
  List<Object?> get props => [status, distilleries];
}
