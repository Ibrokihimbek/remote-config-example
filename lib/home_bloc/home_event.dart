part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class CheckAppVersionEvent extends HomeEvent {
  const CheckAppVersionEvent();
  @override
  List<Object> get props => [];
}