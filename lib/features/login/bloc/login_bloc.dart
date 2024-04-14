import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<Login>(_login);
  }

  void _login(Login event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      final result = await AuthDatasource.login(
          email: event.email, password: event.password);
      AuthDatasource.saveAccessToken(result.data.accessToken);
      AuthDatasource.saveExpiredAt(result.data.expiredAt);
      AuthDatasource.saveName(result.data.name);
      AuthDatasource.saveRole(result.data.role);
      emit(state.copyWith(status: LoginStatus.success));
    } on ErrorModel catch (e) {
      emit(state.copyWith(status: LoginStatus.failed, errorMessage: e.message));
    }
  }
}
