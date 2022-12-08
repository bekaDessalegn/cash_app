import 'package:cash_app/features/affiliate_profile/data/models/affiliates.dart';
import 'package:cash_app/features/affiliate_profile/data/models/avatar.dart';
import 'package:cash_app/features/affiliate_profile/data/models/children.dart';
import 'package:cash_app/features/affiliate_profile/data/models/parent_affiliate.dart';

abstract class SingleAffiliateState {}

class InitialSingleAffiliateState extends SingleAffiliateState {}

class GetSingleAffiliateSuccessfulState extends SingleAffiliateState {
  final Affiliates affiliate;
  GetSingleAffiliateSuccessfulState(this.affiliate);
}

class GetSingleAffiliateLoadingState extends SingleAffiliateState {}

class GetSingleAffiliateFailedState extends SingleAffiliateState {
  String errorType;
  GetSingleAffiliateFailedState(this.errorType);
}

class SignOutSuccessful extends SingleAffiliateState {}

class SignOutLoading extends SingleAffiliateState {}

class SignOutFailed extends SingleAffiliateState {}

abstract class ChildrenState {}

class InitialChildrenState extends ChildrenState {}

class GetChildrenSuccessfulState extends ChildrenState {
  final List<Children> children;
  GetChildrenSuccessfulState(this.children);
}

class GetChildrenLoadingState extends ChildrenState {}

class GetChildrenFailedState extends ChildrenState {
  String errorType;
  GetChildrenFailedState(this.errorType);
}

abstract class PutAvatarState {}

class InitialPutAvatarStateState extends PutAvatarState {}

class PutAvatarStateSuccessful extends PutAvatarState {
  Avatar avatar;
  PutAvatarStateSuccessful(this.avatar);
}

class PutAvatarStateLoading extends PutAvatarState {}

class PutAvatarStateFailed extends PutAvatarState {
  final String errorType;
  PutAvatarStateFailed(this.errorType);
}

class DeleteAvatarStateSuccessful extends PutAvatarState {}

abstract class PutEmailState{}

class PutEmailInitialState extends PutEmailState {}

class PutEmailSuccessful extends PutEmailState {}

class PutEmailLoading extends PutEmailState {}

class PutEmailFailed extends PutEmailState {
  final String errorType;
  PutEmailFailed(this.errorType);
}

class VerifyEmailSuccessful extends PutEmailState {}

class VerifyEmailLoading extends PutEmailState {}

class VerifyEmailFailed extends PutEmailState {
  final String errorType;
  VerifyEmailFailed(this.errorType);
}

abstract class EditProfileState {}

class EditPasswordInitialState extends EditProfileState {}

class EditPasswordSuccessful extends EditProfileState {}

class EditPasswordFailed extends EditProfileState {
  final String errorType;
  EditPasswordFailed(this.errorType);
}

class EditPasswordLoading extends EditProfileState {}

class EditPhoneInitialState extends EditProfileState {}

class EditPhoneSuccessful extends EditProfileState {}

class EditPhoneFailed extends EditProfileState {
  final String errorType;
  EditPhoneFailed(this.errorType);
}

class EditPhoneLoading extends EditProfileState {}

abstract class DeleteAffiliateState {}

class InitialDeleteAffiliateState extends DeleteAffiliateState {}

class DeleteAffiliateSuccessfulState extends DeleteAffiliateState{}

class DeleteAffiliateLoadingState extends DeleteAffiliateState {}

class DeleteAffiliateFailedState extends DeleteAffiliateState{
  String errorType;
  DeleteAffiliateFailedState(this.errorType);
}

abstract class ParentAffiliateState {}

class InitialParentAffiliateState extends ParentAffiliateState {}

class GetParentAffiliateSuccessfulState extends ParentAffiliateState {
  final ParentAffiliate affiliate;
  GetParentAffiliateSuccessfulState(this.affiliate);
}

class GetParentAffiliateLoadingState extends ParentAffiliateState {}

class GetParentAffiliateFailedState extends ParentAffiliateState {
  String errorType;
  GetParentAffiliateFailedState(this.errorType);
}

abstract class EditFullNameState {}

class PatchFullNameInitialState extends EditFullNameState {}

class PatchFullNameSuccessful extends EditFullNameState {}

class PatchFullNameFailed extends EditFullNameState {
  final String errorType;
  PatchFullNameFailed(this.errorType);
}

class PatchFullNameLoading extends EditFullNameState {}


