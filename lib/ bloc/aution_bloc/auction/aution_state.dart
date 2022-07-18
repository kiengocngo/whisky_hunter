import 'package:equatable/equatable.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';

abstract class AuctionState extends Equatable {
  const AuctionState();

  @override 
  List<Object?> get props => [];
}

class AuctionInitial extends AuctionState {}

class AuctionLoading extends AuctionState {}
class AuctionLoaded extends AuctionState {
  final List<AuctionDataModel> listAutionModel;
  const AuctionLoaded(this.listAutionModel);
}

class AuctionError extends AuctionState {
  final String? message;
  const AuctionError(this.message);
}