import 'package:equatable/equatable.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';

enum AuctionStatus { initial, success, failure }

class AuctionState extends Equatable {
  const AuctionState({
    this.status = AuctionStatus.initial,
    this.auction = const <AuctionDataModel>[],
    required this.error,
  });

  final List<AuctionDataModel> auction;
  final AuctionStatus status;
  final String error;
  AuctionState copyWith({
    AuctionStatus? status,
    List<AuctionDataModel>? auction,
    String? error,
  }) {
    return AuctionState(
      status: status ?? this.status,
      auction: auction ?? this.auction,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, auction, error];
}
