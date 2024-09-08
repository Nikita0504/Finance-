part of 'counter_bloc.dart';

@immutable
class CounterState {}

class BalanceState extends CounterState {
  final double internalBalance;
  final double loss;
  final double purpose;
  final double expenses;
  final double visibleBalance;

  BalanceState(
      {this.visibleBalance = 0,
      this.internalBalance = 0,
      this.loss = 0,
      this.purpose = 0,
      this.expenses = 0});

  BalanceState copyWith({
    double? balance,
    double? loss,
    double? purpose,
    double? expenses,
    double? visibleBalance,
  }) {
    return BalanceState(
        internalBalance: balance ?? this.internalBalance,
        loss: loss ?? this.loss,
        purpose: purpose ?? this.purpose,
        expenses: expenses ?? this.expenses,
        visibleBalance: visibleBalance ?? this.visibleBalance);
  }
}
