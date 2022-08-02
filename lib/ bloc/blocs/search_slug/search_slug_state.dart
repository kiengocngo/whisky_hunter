// import 'package:equatable/equatable.dart';
// import 'package:whisky_hunter/%20bloc/blocs/auction/aution_state.dart';
// import 'package:whisky_hunter/src/data/model/auction_data_model.dart';

//  class SearchSlugState extends Equatable {
//   const SearchSlugState(
//       {this.status = AuctionStatus.initial,
//       this.search = const <AuctionDataModel>[],
//       required this.error});
// final List<AuctionDataModel> search;
//   final AuctionStatus status;
//   final String error;
//   SearchSlugState copyWith({
//     AuctionStatus? status,
//     List<AuctionDataModel>? search,
//     String? error,
//   }) {
//     return SearchSlugState(
//         status: status ?? this.status,
//         search: search ?? this.search,
//         error: error ?? this.error);
//   }

//   @override
//   List<Object?> get props => [status, search, error];
// }

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
