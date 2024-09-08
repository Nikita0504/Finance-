import 'package:finance/core/domain/models/transaction_model.dart';
import 'package:finance/core/presentation/history_screen/blocs/history_bloc/history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryCard extends StatelessWidget {
  final TransactionModel transactionModel;
  final int index;
  const HistoryCard(
      {super.key, required this.transactionModel, required this.index});

  @override
  Widget build(BuildContext context) {
    double sum = transactionModel.sum;
    Color? color() {
      if (transactionModel.type == false) {
        return sum > 0 ? Colors.green : Colors.red;
      } else {
        return Colors.blue[300];
      }
    }

    return Container(
      margin: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            sum.toString(),
            style: TextStyle(
                fontSize: 17.5, color: color(), fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              Text(
                transactionModel.description.toString(),
                style: TextStyle(color: Colors.grey),
              ),
              IconButton(
                  onPressed: () {
                    final bloc = BlocProvider.of<HistoryBloc>(context);
                    bloc.add(DeleteHistoryEvent(index: index));
                  },
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
