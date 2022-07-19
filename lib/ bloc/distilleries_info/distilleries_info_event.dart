import 'package:equatable/equatable.dart';

abstract class DistilleriesInfoEvent extends Equatable {
  const DistilleriesInfoEvent();

  @override 
  List<Object> get props => [];
}

class GetDistilleriesInfoList extends DistilleriesInfoEvent{}