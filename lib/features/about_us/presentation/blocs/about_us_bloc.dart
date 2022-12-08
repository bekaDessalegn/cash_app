import 'package:cash_app/features/about_us/data/repositories/about_us_repository.dart';
import 'package:cash_app/features/about_us/presentation/blocs/about_us_event.dart';
import 'package:cash_app/features/about_us/presentation/blocs/about_us_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutUsContentBloc extends Bloc<AboutUsContentEvent, AboutUsContentState> {
  AboutUsRepository aboutUsRepository;
  AboutUsContentBloc(this.aboutUsRepository) : super(InitialAboutUsContentState()){
    on<GetAboutUsContentEvent>(_onGetAboutUsContentEvent);
  }

  void _onGetAboutUsContentEvent(GetAboutUsContentEvent event, Emitter emit) async {
    emit(GetAboutUsContentLoadingState());
    try {
      final aboutUsContent = await aboutUsRepository.getAboutUsContent();
      emit(GetAboutUsContentSuccessfulState(aboutUsContent));
    } catch(e){
      emit(GetAboutUsContentFailedState("Something went wrong fetching the AboutUs content"));
    }
  }

}