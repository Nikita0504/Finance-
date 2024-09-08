import 'package:bloc/bloc.dart';
import 'package:finance/core/domain/models/transaction_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(BalanceState()) {
    on<UpdateBalanceEvent>(onUpdateBalanceEvent);
    on<UploadBalanseEvent>(onUploadDataEvent);
  }
  onUpdateBalanceEvent(event, emit) {
    TransactionModel transactionModel = event.transactionModel;
    changeDiagram(transactionModel);
    saveHistory();
  }

  void changeDiagram(TransactionModel transactionModel) {
    double sum = transactionModel.sum;
    final currentState = state as BalanceState;
    if (!transactionModel.type) {
      if (sum > 0) {
        emit(currentState.copyWith(
            balance: currentState.internalBalance + sum,
            expenses: currentState.expenses + sum,
            visibleBalance: currentState.visibleBalance + sum));
      } else {
        emit(currentState.copyWith(
            balance: currentState.internalBalance + sum.abs(),
            loss: currentState.loss + sum.abs(),
            visibleBalance: currentState.visibleBalance + sum));
      }
    } else {
      if (sum > 0) {
        emit(currentState.copyWith(
          balance: currentState.internalBalance + sum,
          purpose: currentState.purpose + sum,
        ));
      } else {
        emit(currentState.copyWith(
            expenses: currentState.expenses + sum.abs(),
            purpose: currentState.purpose + sum,
            visibleBalance: currentState.visibleBalance + sum.abs()));
      }
    }
  }

  onUploadDataEvent(event, emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final currentState = state as BalanceState;

    // prefs.remove('expenses');
    // prefs.remove('internalBalance');
    // prefs.remove('loss');
    // prefs.remove('purpose');
    // prefs.remove('visibleBalance');

    double expenses = prefs.getDouble('expenses') ?? 0;
    double internalBalance = prefs.getDouble('internalBalance') ?? 0;
    double loss = prefs.getDouble('loss') ?? 0;
    double purpose = prefs.getDouble('purpose') ?? 0;
    double visibleBalance = prefs.getDouble('visibleBalance') ?? 0;

    emit(BalanceState(
        expenses: expenses,
        internalBalance: internalBalance,
        loss: loss,
        purpose: purpose,
        visibleBalance: visibleBalance));
  }

  void saveHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final currentState = state as BalanceState;

    await prefs.setDouble('expenses', currentState.expenses);
    await prefs.setDouble('internalBalance', currentState.internalBalance);
    await prefs.setDouble('loss', currentState.loss);
    await prefs.setDouble('purpose', currentState.purpose);
    await prefs.setDouble('visibleBalance', currentState.visibleBalance);
  }
}
