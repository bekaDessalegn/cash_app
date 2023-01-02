import 'package:cash_app/features/affiliate_wallet/data/repositories/transaction_repository.dart';
import 'package:cash_app/features/affiliate_wallet/presentation/blocs/transactions_event.dart';
import 'package:cash_app/features/affiliate_wallet/presentation/blocs/transactions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AffiliateTransactionsBloc extends Bloc<AffiliateTransactionsEvent, AffiliateTransactionsState> {
  TransactionRepository transactionsRepository;
  AffiliateTransactionsBloc(this.transactionsRepository) : super(InitialAffiliateTransactionsState()) {
    on<GetAffiliateTransactionsEvent>(_onGetAffiliateTransactionsEvent);
    on<GetMoreAffiliateTransactionsEvent>(_onGetMoreAffiliateTransactionsEvent);
  }

  void _onGetAffiliateTransactionsEvent(GetAffiliateTransactionsEvent event, Emitter emit) async {
    emit(GetAffiliateTransactionsLoadingState());
    try{
      final transactions = await transactionsRepository.getAffiliateTransactions(event.skipNumber);
      if(transactions.runtimeType.toString() == "List<LocalTransactions>"){
        emit(GetAffiliateTransactionsSocketErrorState(transactions));
      } else{
        emit(GetAffiliateTransactionsSuccessfulState(transactions));
      }
    } catch(e){
      emit(GetAffiliateTransactionsFailedState("Something went wrong"));
    }
  }

  void _onGetMoreAffiliateTransactionsEvent(GetMoreAffiliateTransactionsEvent event, Emitter emit) async {
    try{
      final transactions = await transactionsRepository.getAffiliateTransactions(event.skipNumber);
      emit(GetAffiliateTransactionsSuccessfulState(transactions));
    } catch(e){
      emit(GetAffiliateTransactionsFailedState("Something went wrong"));
    }
  }

}