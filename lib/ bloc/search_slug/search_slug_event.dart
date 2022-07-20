import 'package:equatable/equatable.dart';

abstract class SearchSlugEvent extends Equatable {
  const SearchSlugEvent();

  @override 
  List<Object> get props => [];
}

class GetSLugList extends SearchSlugEvent{
  final String slug;
  const GetSLugList({required this.slug});
}