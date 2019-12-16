import 'package:dating_app/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class Initial extends DetailsState {}

class Loading extends DetailsState {}

class Error extends DetailsState {
  const Error({
    @required this.message,
  });

  final String message;
}

class DistanceCalculated extends DetailsState {
  const DistanceCalculated(this.distance);

  final num distance;
}

class LikePressed extends DetailsState {}
