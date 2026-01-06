part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileInformationEvent extends EditProfileEvent {

  const GetProfileInformationEvent();

}
class ProfileUpdateEvent extends EditProfileEvent {

  const ProfileUpdateEvent();

}

class ImageUpdateEvent extends EditProfileEvent {
  ImageSource? img;
  ImageUpdateEvent(this.img);
}