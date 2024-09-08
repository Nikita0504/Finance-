import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/colors.dart';
import 'package:finance/core/presentation/home_page/widgets/circular_chart.dart';

import 'blocs/counter_bloc/counter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(child: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          if (state is BalanceState) {
            return CircularChart(
              categories: {
                'purpose': state.purpose,
                'loss': state.loss,
                'expenses': state.expenses,
              },
              totalAmount: state.internalBalance,
              visibleBalance: state.visibleBalance,
            );
          } else
            return SizedBox();
        },
      )),
    );
  }
}
