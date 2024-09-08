import 'package:finance/core/presentation/history_screen/blocs/history_bloc/history_bloc.dart';
import 'package:finance/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/history_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (state is HistoryListState) {
              return Column(
                  children: List.generate(
                      state.history.length,
                      (int index) => HistoryCard(
                            transactionModel: state.history[index],
                            index: index,
                          )));
            } else
              return Text('Error');
          },
        ),
      ),
    );
  }
}
