import 'package:equatable/equatable.dart';

abstract class UpskillEvent extends Equatable {
  const UpskillEvent();

  @override
  List<Object?> get props => [];
}

class LoadUpskillSuggestions extends UpskillEvent {}

class RefreshUpskillSuggestions extends UpskillEvent {}

class ToggleProjectExpansion extends UpskillEvent {
  final int projectIndex;

  const ToggleProjectExpansion(this.projectIndex);

  @override
  List<Object?> get props => [projectIndex];
}

class ToggleUpskillExpansion extends UpskillEvent {
  final int upskillIndex;

  const ToggleUpskillExpansion(this.upskillIndex);

  @override
  List<Object?> get props => [upskillIndex];
}

class SelectTab extends UpskillEvent {
  final int tabIndex;

  const SelectTab(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}