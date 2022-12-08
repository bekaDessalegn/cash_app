import 'package:cash_app/features/affiliate_wallet/data/models/transactions.dart';

abstract class AffiliateTransactionsState {}

class InitialAffiliateTransactionsState extends AffiliateTransactionsState {}

class GetAffiliateTransactionsSuccessfulState extends AffiliateTransactionsState {
  final List<Transactions> transactions;
  GetAffiliateTransactionsSuccessfulState(this.transactions);
}

class GetAffiliateTransactionsLoadingState extends AffiliateTransactionsState {}

class GetAffiliateTransactionsFailedState extends AffiliateTransactionsState {
  final String errorType;
  GetAffiliateTransactionsFailedState(this.errorType);
}