import 'package:equatable/equatable.dart';

abstract class AuctionInfoEvent extends Equatable {
  const AuctionInfoEvent();

  @override
  List<Object> get props => [];
}

class GetAuctionInfoList extends AuctionInfoEvent {}
