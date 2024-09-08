part of 'history_bloc.dart';

@immutable
sealed class HistoryState {}

class HistoryListState extends HistoryState {
  final List<TransactionModel> history;

  HistoryListState(this.history);
}
