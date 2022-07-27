import 'package:equatable/equatable.dart';
import 'package:whisky_hunter/src/data/model/auction_information_model.dart';

abstract class AuctionInfoState extends Equatable {
  const AuctionInfoState();

  @override 
  List<Object?> get props => [];
}

class AuctionInfoInitial extends AuctionInfoState{}

class AuctionInfoLoading extends AuctionInfoState{}

class AuctionInfoLoaded extends AuctionInfoState {
  final List<AuctionInformations> listAuctionInfoModel;
  const AuctionInfoLoaded(this.listAuctionInfoModel);
}

class AuctionInfoError extends AuctionInfoState{
  final String? message;
  const AuctionInfoError(this.message);
}