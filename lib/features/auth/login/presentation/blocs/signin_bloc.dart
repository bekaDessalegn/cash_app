import 'dart:io';

import 'package:cash_app/features/auth/login/data/repositories/signin_repository.dart';
import 'package:cash_app/features/auth/login/presentation/blocs/signin_event.dart';
import 'package:cash_app/features/auth/login/presentation/blocs/signin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInRepository signInRepository;
  SignInBloc(this.signInRepository) : super(InitialSignInState()){
    on<PostSignInEvent>(_onPostSignInEvent);
    on<InitialSendRecoveryEvent>(_onInitialSendRecoveryEvent);
    on<SendRecoveryEmailEvent>(_onSendRecoveryEmailEvent);
    on<ResetEmailEvent>(_onResetEmailEvent);
    on<AdminResetEmailEvent>(_onAdminResetEmailEvent);
  }

  void _onPostSignInEvent(PostSignInEvent event, Emitter emit) async {
    emit(SignInStateLoading());
    try {
      await signInRepository.signInAffiliate(event.signIn);
      emit(SignInStateSuccessful());
    } on HttpException{
      emit(SignInStateFailed("One of the credentials is wrong"));
    } on SocketException{
      emit(SignInStateFailed("Something went wrong please, try again"));
    } on Exception{
      emit(SignInStateFailed("Something went wrong please, try again"));
    }
  }

  void _onInitialSendRecoveryEvent(InitialSendRecoveryEvent event, Emitter emit) async {
    emit(InitialSignInState());
  }

  void _onSendRecoveryEmailEvent(SendRecoveryEmailEvent event, Emitter emit) async {
    emit(SendRecoveryEmailLoading());
    try{
      await signInRepository.forgotPassword(event.email);
      emit(SendRecoveryEmailSuccessful());
    } on HttpException{
      emit(SendRecoveryEmailFailed("Email does not exist"));
    } on SocketException{
      emit(SendRecoveryEmailFailed("Something went wrong please, try again"));
    } on Exception{
      emit(SendRecoveryEmailFailed("Something went wrong please, try again"));
    }
  }

  void _onResetEmailEvent(ResetEmailEvent event, Emitter emit) async {
    emit(ResetEmailLoading());
    try{
      await signInRepository.recoverPassword(event.recoveryToken, event.newPasswordHash);
      emit(ResetEmailSuccessful());
    } on HttpException{
      emit(ResetEmailFailed("The token has expired"));
    } on SocketException{
      emit(ResetEmailFailed("Something went wrong please, try again"));
    } on Exception{
      emit(ResetEmailFailed("Something went wrong please, try again"));
    }
  }

  void _onAdminResetEmailEvent(AdminResetEmailEvent event, Emitter emit) async {
    emit(ResetEmailLoading());
    try{
      await signInRepository.adminResetPassword(event.recoveryToken, event.newHashPassword);
      emit(ResetEmailSuccessful());
    } on HttpException{
      emit(ResetEmailFailed("The token has expired"));
    } on SocketException{
      emit(ResetEmailFailed("Something went wrong please, try again"));
    } on Exception{
      emit(ResetEmailFailed("Something went wrong please, try again"));
    }
  }
}