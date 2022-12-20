part of 'elpmi_profile_bloc.dart';

@immutable
class ElpmiProfileFetchRequested extends Equatable {
  const ElpmiProfileFetchRequested(this.jwt);

  final String jwt;

  @override
  List<Object> get props => [jwt];
}
