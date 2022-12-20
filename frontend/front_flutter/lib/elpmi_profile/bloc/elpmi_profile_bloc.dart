import 'package:bloc/bloc.dart';
import 'package:elpmi_profile_repository/elpmi_profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'elpmi_profile_event.dart';
part 'elpmi_profile_state.dart';

class ElpmiProfileBloc
    extends Bloc<ElpmiProfileFetchRequested, ElpmiProfileState> {
  ElpmiProfileBloc({required ElpmiProfileRepository elpmiProfileRepository})
      : _elpmiProfileRepository = elpmiProfileRepository,
        super(ElpmiProfileInitial()) {
    on<ElpmiProfileFetchRequested>(_onElpmiProfileFetched);
  }
  final ElpmiProfileRepository _elpmiProfileRepository;

  void _onElpmiProfileFetched(
      ElpmiProfileFetchRequested event, Emitter<ElpmiProfileState> emit) async {
    ElpmiProfile elpmiProfile =
        await _elpmiProfileRepository.fetchProfile(event.jwt);
    print("${elpmiProfile.uid} : ${elpmiProfile.name ?? 'no name'}");
    emit(PopulatedElpmiProfile(elpmiProfile));
  }
}
