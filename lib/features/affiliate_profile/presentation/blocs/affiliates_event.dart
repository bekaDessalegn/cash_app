import 'package:cash_app/features/affiliate_profile/data/models/avatar.dart';

abstract class SingleAffiliateEvent {}

class GetSingleAffiliateEvent extends SingleAffiliateEvent {}

class SignOutEvent extends SingleAffiliateEvent {}

abstract class ChildrenEvent {}

class GetChildrenEvent extends ChildrenEvent {}

abstract class PutAvatarEvent {}

class PutAvatar extends PutAvatarEvent{
  Avatar avatar;
  List imageType;
  PutAvatar(this.avatar, this.imageType);
}

class DeleteAvatar extends PutAvatarEvent {}

abstract class EmailEvent {}

class InitialPutEmailEvent extends EmailEvent {}

class PutEmailEvent extends EmailEvent {
  String email;
  PutEmailEvent(this.email);
}

class VerifyEmailEvent extends EmailEvent {
  String verificationCode;
  VerifyEmailEvent(this.verificationCode);
}

abstract class EditProfileEvent {}

class EditPasswordEvent extends EditProfileEvent{
  String oldPasswordHash, newPasswordHash;
  EditPasswordEvent(this.oldPasswordHash, this.newPasswordHash);
}

class PatchPhoneEvent extends EditProfileEvent{
  String phone;
  PatchPhoneEvent(this.phone);
}

abstract class DeleteAffiliateEvent {}

class DeleteSingleAffiliateEvent extends DeleteAffiliateEvent {
  String passwordHash;
  DeleteSingleAffiliateEvent(this.passwordHash);
}

abstract class ParentAffiliateEvent {}

class GetParentAffiliateEvent extends ParentAffiliateEvent {
  String parentId;
  GetParentAffiliateEvent(this.parentId);
}

class StartGetParentAffiliateEvent extends ParentAffiliateEvent {}

abstract class EditFullNameEvent {}

class PatchFullNameEvent extends EditFullNameEvent {
  String fullName;
  PatchFullNameEvent(this.fullName);
}