part of  'distilleries_info_cubit.dart';

class DistilleriesInfoState extends Equatable {
  const DistilleriesInfoState(
      {this.status = AuctionStatus.initial,
      this.distilleries = const <DistilleriesInfo>[],
      required this.error});

  final List<DistilleriesInfo> distilleries;
  final AuctionStatus status;
  final String error;

  DistilleriesInfoState copyWith({
    AuctionStatus? status,
    List<DistilleriesInfo>? distilleries,
    String? error,
  }) {
    return DistilleriesInfoState(
        status: status ?? this.status,
        distilleries: distilleries ?? this.distilleries,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, distilleries, error];
}
