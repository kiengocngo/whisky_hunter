import 'package:equatable/equatable.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction/aution_state.dart';
import 'package:whisky_hunter/src/data/model/auction_information_model.dart';

class AuctionInfoState extends Equatable {
  const AuctionInfoState(
      {this.status = AuctionStatus.initial,
      this.auctionInfo = const <AuctionInformations>[]});
  final List<AuctionInformations> auctionInfo;
  final AuctionStatus status;
  AuctionInfoState copyWith({
    AuctionStatus? status,
    List<AuctionInformations>? auctionInfo,
  }) {
    return AuctionInfoState(
        status: status ?? this.status,
        auctionInfo: auctionInfo ?? this.auctionInfo);
  }

  @override
  List<Object> get props => [status, auctionInfo];
}
