abstract class AffiliateTransactionsEvent {}

class GetAffiliateTransactionsEvent extends AffiliateTransactionsEvent {
  int skipNumber;
  GetAffiliateTransactionsEvent(this.skipNumber);
}

class GetMoreAffiliateTransactionsEvent extends AffiliateTransactionsEvent {
  int skipNumber;
  GetMoreAffiliateTransactionsEvent(this.skipNumber);
}