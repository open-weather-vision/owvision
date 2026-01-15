import 'package:dashboard/features/counter/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => CounterCubit(), child: _CounterView());
  }
}

class _CounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Text(state.toString());
          },
        ),
        ElevatedButton(
          onPressed: () => context.read<CounterCubit>().increment(),
          child: Text("Increment"),
        ),
      ],
    );
  }
}
