import 'package:equatable/equatable.dart';

abstract class DistilleriesSlugEvent extends Equatable {
  const DistilleriesSlugEvent();

  @override 
  List<Object> get props => [];
}

class GetSLugList1 extends DistilleriesSlugEvent{
  final String slug;
  const GetSLugList1({required this.slug});
}