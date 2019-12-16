import 'package:dating_app/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class GetDistance extends DetailsEvent {}

class LikePerson extends DetailsEvent {
  const LikePerson({
    @required this.person,
  });
  final User person;

  @override
  List<Object> get props => [person];
}
