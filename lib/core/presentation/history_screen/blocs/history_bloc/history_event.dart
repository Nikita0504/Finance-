part of 'history_bloc.dart';

@immutable
sealed class HistoryEvent {}

class SaveHistoryEvent extends HistoryEvent {
  final TransactionModel transactionModel;

  SaveHistoryEvent({required this.transactionModel});
}

class DeleteHistoryEvent extends HistoryEvent {
  final int index;

  DeleteHistoryEvent({required this.index});
}

class UploadDataEvent extends HistoryEvent {}
