part of 'counter_bloc.dart';

@immutable
sealed class CounterEvent {}

class UpdateBalanceEvent extends CounterEvent {
  final TransactionModel transactionModel;

  UpdateBalanceEvent(this.transactionModel);
}

class UploadBalanseEvent extends CounterEvent {}
