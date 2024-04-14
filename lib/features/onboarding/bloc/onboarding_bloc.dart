import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingState()) {
    on<CheckLogin>(_checkLogin);
  }

  void _checkLogin(CheckLogin event, Emitter<OnboardingState> emit) async {
    try {
      emit(state.copyWith(status: OnboardingStatus.loading));
      SharedPreferences pref = await SharedPreferences.getInstance();

      if (pref.containsKey('expiredAt')) {
        if (pref.getInt('expiredAt')! > DateTime.now().millisecondsSinceEpoch) {
          emit(state.copyWith(status: OnboardingStatus.success, isLogin: true));
        } else {
          emit(
              state.copyWith(status: OnboardingStatus.success, isLogin: false));
        }
      } else {
        emit(state.copyWith(status: OnboardingStatus.success, isLogin: false));
      }
    } catch (e) {
      emit(state.copyWith(status: OnboardingStatus.failed));
    }
  }
}
