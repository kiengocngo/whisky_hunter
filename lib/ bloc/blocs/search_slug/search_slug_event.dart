import 'package:equatable/equatable.dart';

abstract class SearchSlugEvent extends Equatable {
  const SearchSlugEvent();
}

class GetSLugList extends SearchSlugEvent {
  final String slug;
  const GetSLugList({required this.slug});
  @override
  List<Object> get props => [slug];
}
