import 'dart:io';

import 'package:cash_app/features/auth/signup/data/repositories/signup_repository.dart';
import 'package:cash_app/features/auth/signup/presentation/blocs/signup_event.dart';
import 'package:cash_app/features/auth/signup/presentation/blocs/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpRepository signUpRepository;
  SignUpBloc(this.signUpRepository) : super(InitialSignUpState()){
    on<InitialSignUpEvent>(_onInitialSignUpEvent);
    on<PostSignUpEvent>(_onPostSignUpEvent);
    on<VerifySignUpEvent>(_onVerifySignUpEvent);
  }

  void _onInitialSignUpEvent(InitialSignUpEvent event, Emitter emit) async {
    emit(InitialSignUpState());
  }

  void _onPostSignUpEvent(PostSignUpEvent event, Emitter emit) async {
    emit(SignUpStateLoading());
    try {
      final response = await signUpRepository.singupAffiliate(event.signUp);
      if(response == "Invalid_Email"){
        emit(SignUpStateFailed("Invalid email"));
      } else{
        emit(SignUpStateSuccessful());
      }
    } on HttpException{
      emit(SignUpStateFailed("Phone or Email already exists"));
    } on SocketException{
      emit(SignUpStateFailed("Please connect to the internet"));
    } on Exception{
      emit(SignUpStateFailed("Something went wrong please, try again"));
    }
  }

  void _onVerifySignUpEvent(VerifySignUpEvent event, Emitter emit) async {
    emit(VerifySignUpStateLoading());
    try {
      await signUpRepository.verifySignUp(event.verificationCode);
      emit(VerifySignUpStateSuccessful());
    } on HttpException{
      emit(VerifySignUpStateFailed("Invalid Verification Code"));
    } on SocketException{
      emit(VerifySignUpStateFailed("Something went wrong please, try again"));
    } on Exception{
      emit(VerifySignUpStateFailed("Something went wrong please, try again"));
    }
  }
}