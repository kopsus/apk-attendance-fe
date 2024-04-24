part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, success, failed, logout }

class ProfileState extends Equatable {
  const ProfileState(
      {this.status = ProfileStatus.initial, this.name = '', this.role = ''});
  final ProfileStatus status;
  final String name;
  final String role;

  ProfileState copyWith({ProfileStatus? status, String? name, String? role}) {
    return ProfileState(
      status: status ?? this.status,
      name: name ?? this.name,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [status, name, role];
}
