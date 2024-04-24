import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<InitEvent>(_init);
    on<LogOut>(_logout);
  }

  void _init(InitEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(status: ProfileStatus.loading));
      final name = await AuthDatasource.getName();
      final role = await AuthDatasource.getRole();

      emit(state.copyWith(
          status: ProfileStatus.success, name: name, role: role));
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.failed));
    }
  }

  void _logout(LogOut event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(status: ProfileStatus.loading));
      await AuthDatasource.clearSharedPreference();

      emit(state.copyWith(status: ProfileStatus.logout));
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.failed));
    }
  }
}
