part of 'profiles_bloc.dart';

enum ProfilesStatus { initial, loading, success, failure }

extension ProfilesStatusX on ProfilesStatus {
  bool get isInitial => this == ProfilesStatus.initial;
  bool get isLoading => this == ProfilesStatus.loading;
  bool get isSuccess => this == ProfilesStatus.success;
  bool get isFailure => this == ProfilesStatus.failure;
}

@immutable
class ProfilesState extends Equatable {
  ProfilesState({
    this.status = ProfilesStatus.initial,
    List<BlocProfile>? profiles,
  }) : profiles = profiles ?? List.empty();

  final ProfilesStatus status;
  final List<BlocProfile> profiles;

  @override
  List<Object?> get props => [status, profiles];
}

class ProfilesInitial extends ProfilesState {}
