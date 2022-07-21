import 'package:equatable/equatable.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';


abstract class SearchSlugState extends Equatable {
  const SearchSlugState();

  @override 
  List<Object?> get props => [];
}

class SearchSlugInitial extends SearchSlugState{}

class SearchSlugLoading extends SearchSlugState{}

class SearchSlugLoaded extends SearchSlugState {
  final List<AuctionDataModel> listSlug;
  const SearchSlugLoaded(this.listSlug);
}

class SearchSlugError extends SearchSlugState{
  final String? message;
  const SearchSlugError(this.message);
}