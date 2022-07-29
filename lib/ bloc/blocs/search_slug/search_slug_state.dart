import 'package:equatable/equatable.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction/aution_state.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';

class SearchSlugState extends Equatable {
  const SearchSlugState(
      {this.status = AuctionStatus.initial,
      this.search = const <AuctionDataModel>[]});
  final List<AuctionDataModel> search;
  final AuctionStatus status;
  SearchSlugState copyWith({
    AuctionStatus? status,
    List<AuctionDataModel>? search,
  }) {
    return SearchSlugState(
        status: status ?? this.status, search: search ?? this.search);
  }

  @override
  List<Object?> get props => [status, search];
}
