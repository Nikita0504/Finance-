import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/models/transaction_model.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryListState(const [])) {
    on<SaveHistoryEvent>(onSaveHistory);
    on<DeleteHistoryEvent>(onDeleteHistoryEvent);
    on<UploadDataEvent>(onUploadDataEvent);
  }
  void onSaveHistory(event, emit) {
    final currentState = state as HistoryListState;
    List<TransactionModel> list = List.from(currentState.history);
    list.add(event.transactionModel);
    emit(HistoryListState(list));
    saveHistory(list);
  }

  void onDeleteHistoryEvent(event, emit) {
    final currentState = state as HistoryListState;
    List<TransactionModel> list = List.from(currentState.history);
    list.removeAt(event.index);
    emit(HistoryListState(list));
    saveHistory(list);
  }

  onUploadDataEvent(event, emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('history');
    List<TransactionModel> list = TransactionModel.decode(data!);
    emit(HistoryListState(list));
  }

  void saveHistory(List<TransactionModel> list) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = TransactionModel.encode(list);

    await prefs.setString('history', encodedData);
  }
}
