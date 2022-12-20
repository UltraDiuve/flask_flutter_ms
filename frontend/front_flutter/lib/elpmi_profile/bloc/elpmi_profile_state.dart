part of 'elpmi_profile_bloc.dart';

@immutable
abstract class ElpmiProfileState {}

class ElpmiProfileInitial extends ElpmiProfileState {}

class PopulatedElpmiProfile extends ElpmiProfileState {
  PopulatedElpmiProfile(this.elpmiProfile);
  final ElpmiProfile elpmiProfile;
}
