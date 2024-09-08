import 'package:finance/core/domain/models/transaction_model.dart';
import 'package:finance/core/presentation/history_screen/history_screen.dart';
import 'package:finance/core/presentation/history_screen/blocs/history_bloc/history_bloc.dart';
import 'package:finance/core/presentation/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../presentation/home_page/blocs/counter_bloc/counter_bloc.dart';
import '../presentation/home_page/widgets/alert_dailog.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final historyBloc = BlocProvider.of<HistoryBloc>(context);
    final counterBloc = BlocProvider.of<CounterBloc>(context);

    final TextEditingController controllerTop = TextEditingController();
    final TextEditingController controllerDown = TextEditingController();
    return PersistentTabView(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: const Color.fromARGB(255, 131, 124, 124),
        foregroundColor: const Color.fromARGB(255, 231, 227, 227),
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        spacing: 12,
        spaceBetweenChildren: 12,
        children: [
          SpeedDialChild(
            child: const Icon(
              Icons.account_balance_rounded,
              color: Color.fromARGB(255, 231, 227, 227),
            ),
            backgroundColor: const Color.fromARGB(255, 131, 124, 124),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MyAlertDialog(
                        title: 'Сhange the accumulated balance',
                        onPressed: () {
                          String inputText = controllerTop.text.trim();
                          String description = controllerDown.text;
                          if (inputText.isNotEmpty) {
                            try {
                              double sum = double.parse(inputText);
                              TransactionModel transactionModel =
                                  TransactionModel(
                                      sum: sum,
                                      description: description,
                                      type: true);
                              var counterState =
                                  counterBloc.state is BalanceState;
                              counterBloc
                                  .add(UpdateBalanceEvent(transactionModel));
                              historyBloc.add(SaveHistoryEvent(
                                  transactionModel: transactionModel));
                              Navigator.of(context).pop();
                            } catch (e) {
                              print("Invalid input: $e");
                            }
                          } else {
                            print("Input is empty");
                          }
                        },
                        controllerTop: controllerTop,
                        controllerDown: controllerDown);
                  });
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.account_balance_wallet,
              color: Color.fromARGB(255, 231, 227, 227),
            ),
            backgroundColor: const Color.fromARGB(255, 131, 124, 124),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MyAlertDialog(
                    title: 'Change the balance',
                    controllerTop: controllerTop,
                    controllerDown: controllerDown,
                    onPressed: () {
                      String inputText = controllerTop.text.trim();
                      String description = controllerDown.text;

                      if (inputText.isNotEmpty) {
                        try {
                          double sum = double.parse(inputText);
                          TransactionModel transactionModel = TransactionModel(
                              sum: sum, description: description);
                          counterBloc.add(UpdateBalanceEvent(transactionModel));
                          historyBloc.add(SaveHistoryEvent(
                              transactionModel: TransactionModel(
                            sum: sum,
                            description: description,
                          )));
                          Navigator.of(context).pop();
                        } catch (e) {
                          print("Invalid input: $e");
                        }
                      } else {
                        print("Input is empty");
                      }
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      tabs: [
        PersistentTabConfig(
          screen: const HomePage(),
          item: ItemConfig(
            activeForegroundColor: const Color.fromARGB(255, 231, 227, 227),
            inactiveForegroundColor: const Color.fromARGB(255, 185, 180, 180),
            icon: const Icon(
              Icons.home_filled,
            ),
            title: "Home",
          ),
        ),
        PersistentTabConfig(
          screen: const HistoryScreen(),
          item: ItemConfig(
            activeForegroundColor: const Color.fromARGB(255, 231, 227, 227),
            inactiveForegroundColor: const Color.fromARGB(255, 185, 180, 180),
            icon: const Icon(
              Icons.history_outlined,
            ),
            title: "History",
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style6BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration:
            const NavBarDecoration(color: Color.fromARGB(255, 110, 103, 103)),
      ),
    );
  }
}
