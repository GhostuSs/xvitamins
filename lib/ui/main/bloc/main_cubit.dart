import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xvitamins/data/GDays/gdays.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void update({required GDays gdays}){
    emit(state.copyWith(newgdays: gdays));
  }
}
