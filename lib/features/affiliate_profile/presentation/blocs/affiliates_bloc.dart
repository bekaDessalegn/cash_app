import 'dart:io';

import 'package:cash_app/features/affiliate_profile/data/repositories/affiliates_repository.dart';
import 'package:cash_app/features/affiliate_profile/presentation/blocs/affiliates_event.dart';
import 'package:cash_app/features/affiliate_profile/presentation/blocs/affiliates_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleAffiliateBloc extends Bloc<SingleAffiliateEvent, SingleAffiliateState> {
  AffiliatesRepository affiliatesRepository;
  SingleAffiliateBloc(this.affiliatesRepository) : super(InitialSingleAffiliateState()){
    on<GetSingleAffiliateEvent>(_onGetSingleAffiliateEvent);
    on<SignOutEvent>(_onSignOutEvent);
  }

  void _onGetSingleAffiliateEvent(GetSingleAffiliateEvent event, Emitter emit) async {
    emit(GetSingleAffiliateLoadingState());
    try{
      final affiliate = await affiliatesRepository.getAffiliate();
      emit(GetSingleAffiliateSuccessfulState(affiliate));
    } catch(e){
      emit(GetSingleAffiliateFailedState("Something went wrong"));
    }
  }

  void _onSignOutEvent(SignOutEvent event, Emitter emit) async {
    emit(SignOutLoading());
    try {
      await affiliatesRepository.signOut();
      emit(SignOutSuccessful());
    } catch (e) {
      emit(GetSingleAffiliateFailedState("Something went wrong, please try again"));
    }
  }

}

class ChildrenBloc extends Bloc<ChildrenEvent, ChildrenState> {
  AffiliatesRepository affiliatesRepository;
  ChildrenBloc(this.affiliatesRepository) : super(InitialChildrenState()){
    on<GetChildrenEvent>(_onGetChildrenEvent);
  }

  void _onGetChildrenEvent(GetChildrenEvent event, Emitter emit) async {
    emit(GetChildrenLoadingState());
    try{
      final children = await affiliatesRepository.getChildren();
      emit(GetChildrenSuccessfulState(children));
    } catch(e){
      emit(GetChildrenFailedState("Something went wrong"));
    }
  }
}

class PatchPhoneBloc extends Bloc<EditProfileEvent, EditProfileState> {
  AffiliatesRepository affiliatesRepository;
  PatchPhoneBloc(this.affiliatesRepository) : super(EditPhoneInitialState()){
    on<PatchPhoneEvent>(_onPatchPhoneEvent);
  }

  void _onPatchPhoneEvent(PatchPhoneEvent event, Emitter emit) async {
    emit(EditPhoneLoading());
    try {
      final response = await affiliatesRepository.patchPhone(event.phone);
      print("The response is");
      print(response);
      if(response == "Invalid_Phone"){
        emit(EditPhoneFailed("Invalid Phone"));
      } else if(response == "Affiliate_Phone_Already_Exist"){
        emit(EditPhoneFailed("Phone already exists"));
      } else{
        emit(EditPhoneSuccessful());
      }
    } on HttpException{
      emit(EditPhoneFailed("Phone already exists"));
    } on SocketException{
      emit(EditPhoneFailed("Something went wrong please, try again"));
    } on Exception{
      emit(EditPhoneFailed("Something went wrong please, try again"));
    }
  }
}

class PutAvatarBloc extends Bloc<PutAvatarEvent, PutAvatarState> {
  AffiliatesRepository affiliatesRepository;
  PutAvatarBloc(this.affiliatesRepository) : super(InitialPutAvatarStateState()){
    on<PutAvatar>(_onPutAvatar);
    on<DeleteAvatar>(_onDeleteAvatar);
  }

  void _onPutAvatar(PutAvatar event, Emitter emit) async {
    emit(PutAvatarStateLoading());
    try {
      final avatar = await affiliatesRepository.putAvatar(event.avatar, event.imageType);
      emit(PutAvatarStateSuccessful(avatar));
    } catch(e){
      emit(PutAvatarStateFailed("Something went wrong please try again"));
    }
  }

  void _onDeleteAvatar(DeleteAvatar event, Emitter emit) async {
    emit(PutAvatarStateLoading());
    try {
      await affiliatesRepository.deleteAvatar();
      emit(DeleteAvatarStateSuccessful());
    } catch(e){
      emit(PutAvatarStateFailed("Something went wrong please try again"));
    }
  }

}

class PutEmailBloc extends Bloc<EmailEvent, PutEmailState>{
  AffiliatesRepository affiliateRepository;
  PutEmailBloc(this.affiliateRepository) : super(PutEmailInitialState()){
    on<InitialPutEmailEvent>(_onInitialPutEmailEvent);
    on<PutEmailEvent>(_onPutEmailEvent);
    on<VerifyEmailEvent>(_onVerifyEmailEvent);
  }

  void _onInitialPutEmailEvent(InitialPutEmailEvent event, Emitter emit) async {
    emit(PutEmailInitialState());
  }

  void _onPutEmailEvent(PutEmailEvent event, Emitter emit) async {
    emit(PutEmailLoading());
    try {
      await affiliateRepository.patchEmail(event.email);
      emit(PutEmailSuccessful());
    } on HttpException{
      emit(PutEmailFailed("Email already exists"));
    } on SocketException{
      emit(PutEmailFailed("Something went wrong please, try again"));
    } on Exception{
      emit(PutEmailFailed("Something went wrong please, try again"));
    }
  }

  void _onVerifyEmailEvent(VerifyEmailEvent event, Emitter emit) async {
    emit(VerifyEmailLoading());
    try {
      await affiliateRepository.verifyEmail(event.verificationCode);
      emit(VerifyEmailSuccessful());
    } on HttpException{
      emit(VerifyEmailFailed("Invalid verification code"));
    } on SocketException{
      emit(VerifyEmailFailed("Something went wrong please, try again"));
    } on Exception{
      emit(VerifyEmailFailed("Something went wrong please, try again"));
    }
  }
}

class EditPasswordBloc extends Bloc<EditProfileEvent, EditProfileState>{
  AffiliatesRepository affiliatesRepository;
  EditPasswordBloc(this.affiliatesRepository) : super(EditPasswordInitialState()){
    on<EditPasswordEvent>(_onEditPasswordEvent);
  }

  void _onEditPasswordEvent(EditPasswordEvent event, Emitter emit) async {
    emit(EditPasswordLoading());
    try {
      await affiliatesRepository.patchPassword(
          event.oldPasswordHash, event.newPasswordHash);
      emit(EditPasswordSuccessful());
    } on HttpException{
      emit(EditPasswordFailed("Old password is incorrect"));
    } on SocketException{
      emit(EditPasswordFailed("Something went wrong please, try again"));
    } on Exception{
      emit(EditPasswordFailed("Something went wrong please, try again"));
    }
  }

}

class DeleteAffiliateBloc extends Bloc<DeleteAffiliateEvent, DeleteAffiliateState>{
  AffiliatesRepository affiliatesRepository;
  DeleteAffiliateBloc(this.affiliatesRepository) : super(InitialDeleteAffiliateState()){
    on<DeleteSingleAffiliateEvent>(_onDeleteSingleAffiliateEvent);
  }

  void _onDeleteSingleAffiliateEvent(DeleteSingleAffiliateEvent event, Emitter emit) async{
    emit(DeleteAffiliateLoadingState());
    try{
      await affiliatesRepository.deleteAffiliate(event.passwordHash);
      emit(DeleteAffiliateSuccessfulState());
    } on HttpException {
      emit(DeleteAffiliateFailedState("Wrong password"));
    } on SocketException {
      emit(DeleteAffiliateFailedState("Something went wrong, please try again"));
    } on Exception {
      emit(DeleteAffiliateFailedState("Something went wrong, please try again"));
    }
  }

}

class ParentAffiliateBloc extends Bloc<ParentAffiliateEvent, ParentAffiliateState> {
  AffiliatesRepository affiliatesRepository;
  ParentAffiliateBloc(this.affiliatesRepository) : super(InitialParentAffiliateState()){
    on<GetParentAffiliateEvent>(_onGetParentAffiliateEvent);
    on<StartGetParentAffiliateEvent>(_onStartGetParentAffiliateEvent);
  }

  void _onGetParentAffiliateEvent(GetParentAffiliateEvent event, Emitter emit) async {
    emit(GetParentAffiliateLoadingState());
    try{
      final affiliate = await affiliatesRepository.getParentAffiliate(event.parentId);
      emit(GetParentAffiliateSuccessfulState(affiliate));
    } catch(e){
      emit(GetParentAffiliateFailedState("Something went wrong"));
    }
  }

  void _onStartGetParentAffiliateEvent(StartGetParentAffiliateEvent event, Emitter emit) async {
    emit(GetParentAffiliateLoadingState());
  }

}

class PatchFullNameBloc extends Bloc<EditFullNameEvent, EditFullNameState> {
  AffiliatesRepository affiliatesRepository;
  PatchFullNameBloc(this.affiliatesRepository) : super(PatchFullNameInitialState()){
    on<PatchFullNameEvent>(_onPatchFullNameEvent);
  }

  void _onPatchFullNameEvent(PatchFullNameEvent event, Emitter emit) async {
    emit(PatchFullNameLoading());
    try {
      await affiliatesRepository.patchFullName(event.fullName);
      emit(PatchFullNameSuccessful());
    } catch(e){
      emit(PatchFullNameFailed("Something went wrong please, try again"));
    }
  }
}