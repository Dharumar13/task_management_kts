import 'package:equatable/equatable.dart';


abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object?> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileLoaded extends EditProfileState {

  const EditProfileLoaded();
}
class EditProfileUpdate extends EditProfileState {
  final String? message;
  const EditProfileUpdate(this.message);
}

class EditAuthorization extends EditProfileState {}

class EditProfileError extends EditProfileState {
  final String? message;
  const EditProfileError(this.message);
}

class EditProfileException extends EditProfileState {
  final String? message;
  const EditProfileException(this.message);
}


