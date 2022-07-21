import 'package:equatable/equatable.dart';
import 'package:whisky_hunter/src/data/model/distilleries_info.dart';


abstract class DistilleriesInfoState extends Equatable {
  const DistilleriesInfoState();

  @override 
  List<Object?> get props => [];
}

class DistilleriesInfoInitial extends DistilleriesInfoState{}

class DistilleriesInfoLoading extends DistilleriesInfoState{}

class  DistilleriesInfoLoaded extends DistilleriesInfoState {
  final List<DistilleriesInfo> listDistilleriesInfo;
  const DistilleriesInfoLoaded(this.listDistilleriesInfo);
}

class DistilleriesInfoError extends DistilleriesInfoState{
  final String? message;
  const DistilleriesInfoError(this.message);
}