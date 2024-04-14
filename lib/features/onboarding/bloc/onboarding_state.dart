part of 'onboarding_bloc.dart';

enum OnboardingStatus { initial, loading, success, failed }

class OnboardingState extends Equatable {
  const OnboardingState(
      {this.status = OnboardingStatus.initial, this.isLogin = false});
  final OnboardingStatus status;
  final bool isLogin;

  OnboardingState copyWith({OnboardingStatus? status, bool? isLogin}) {
    return OnboardingState(
        status: status ?? this.status, isLogin: isLogin ?? this.isLogin);
  }

  @override
  List<Object?> get props => [status, isLogin];
}
