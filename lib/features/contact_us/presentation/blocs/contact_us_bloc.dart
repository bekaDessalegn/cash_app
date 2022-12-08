import 'package:cash_app/features/contact_us/data/repositories/contact_us_repository.dart';
import 'package:cash_app/features/contact_us/presentation/blocs/contact_us_event.dart';
import 'package:cash_app/features/contact_us/presentation/blocs/contact_us_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  ContactUsRepository contactUsRepository;
  ContactUsBloc(this.contactUsRepository) : super(InitialContactUsState()){
    on<PostContactUsEvent>(_onPostContactUsEvent);
  }

  void _onPostContactUsEvent(PostContactUsEvent event, Emitter emit) async {
    emit(PostContactUsLoading());
    try {
      await contactUsRepository.postContactUs(event.contactUs);
      emit(PostContactUsSuccessful());
    } catch(e){
      emit(PostContactUsFailed("Something went wrong, please try again"));
    }
  }

}