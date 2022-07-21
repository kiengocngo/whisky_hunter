import 'package:equatable/equatable.dart';
import 'package:whisky_hunter/src/data/model/distilleries_slug.dart';


abstract class DistilleriesSlugState extends Equatable {
  const DistilleriesSlugState();

  @override 
  List<Object?> get props => [];
}

class DistilleriesSlugInitial extends DistilleriesSlugState{}

class DistilleriesSlugLoading extends DistilleriesSlugState{}

class DistilleriesSlugLoaded extends DistilleriesSlugState {
  final List<DistilleriesSlug> listSlug;
  const DistilleriesSlugLoaded(this.listSlug);
}

class DistilleriesSlugError extends DistilleriesSlugState{
  final String? message;
  const DistilleriesSlugError(this.message);
}