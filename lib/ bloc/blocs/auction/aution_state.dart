import 'package:equatable/equatable.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';

enum AuctionStatus { initial, success, failure }

class AuctionState extends Equatable {
  const AuctionState(
      {this.status = AuctionStatus.initial,
      this.auction = const <AuctionDataModel>[]});

  final List<AuctionDataModel> auction;
  final AuctionStatus status;

  AuctionState copyWith({
    AuctionStatus? status,
    List<AuctionDataModel>? auction,
  }) {
    return AuctionState(
      status: status ?? this.status,
      auction: auction ?? this.auction,
    );
  }

  @override
  String toString() {
    return 'AuctionState {status : $status, auction: ${auction.length}}';
  }

  @override
  List<Object> get props => [status, auction];
}

// class AuctionInitial extends AuctionState {}

// class AuctionLoading extends AuctionState {}

// class AuctionLoaded extends AuctionState {
//   final List<AuctionDataModel> listAutionModel;
//   const AuctionLoaded(this.listAutionModel);
// }

// class AuctionError extends AuctionState {
//   final String? message;
//   const AuctionError(this.message);
// }
