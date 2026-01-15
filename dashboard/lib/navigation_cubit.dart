import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<int> {
  // Startet bei Index 0 (Home)
  NavigationCubit() : super(0);

  void setIndex(int index) => emit(index);
}
