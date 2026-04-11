import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  
  @override
  List<Object> get props => [];
}

class LoadHomeData extends HomeEvent {}

class RefreshHomeData extends HomeEvent {}

class SearchEmployees extends HomeEvent {
  final String query;
  
  const SearchEmployees(this.query);
  
  @override
  List<Object> get props => [query];
}

class ClearSearch extends HomeEvent {}