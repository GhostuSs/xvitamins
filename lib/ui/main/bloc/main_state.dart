part of 'main_cubit.dart';

class MainState extends Equatable {
 final GDays? gdays;
  const MainState({
    this.gdays
  });


  MainState copyWith({
    GDays? newgdays,
  }) {
    return MainState(
      gdays: newgdays ?? gdays,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    gdays
  ];
}
