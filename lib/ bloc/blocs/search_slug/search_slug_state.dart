import 'package:equatable/equatable.dart';
import 'package:whisky_hunter/src/data/model/model.dart';

abstract class SearchSlugState extends Equatable {
  const SearchSlugState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchSlugState {}

class SearchLoading extends SearchSlugState {}

class SearchSuccess extends SearchSlugState {
  const SearchSuccess(this.search);
  final List<AuctionDataModel> search;

  @override
  List<Object> get props => [search];

  @override
  String toString() => 'SearchSuccess ${search.length}';
}

class SearchError extends SearchSlugState {
  const SearchError(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
