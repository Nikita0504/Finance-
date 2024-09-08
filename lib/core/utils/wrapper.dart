import 'package:finance/core/presentation/history_screen/blocs/history_bloc/history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/home_page/blocs/counter_bloc/counter_bloc.dart';
import 'application.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => CounterBloc()..add(UploadBalanseEvent()),
      ),
      BlocProvider(
        create: (context) => HistoryBloc()..add(UploadDataEvent()),
      ),
    ], child: const Application());
  }
}
