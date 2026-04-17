import 'package:equatable/equatable.dart';
import '../../domain/entities/upskill_entities.dart';

enum UpskillStatus { initial, loading, loaded, error, refreshing }

class UpskillState extends Equatable {
  final UpskillStatus status;
  final UpskillSuggestionResponse? data;
  final String? errorMessage;
  final int selectedTabIndex;
  final Set<int> expandedProjects;
  final Set<int> expandedUpskillSuggestions;

  const UpskillState({
    this.status = UpskillStatus.initial,
    this.data,
    this.errorMessage,
    this.selectedTabIndex = 0,
    this.expandedProjects = const {},
    this.expandedUpskillSuggestions = const {},
  });

  UpskillState copyWith({
    UpskillStatus? status,
    UpskillSuggestionResponse? data,
    String? errorMessage,
    int? selectedTabIndex,
    Set<int>? expandedProjects,
    Set<int>? expandedUpskillSuggestions,
  }) {
    return UpskillState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      expandedProjects: expandedProjects ?? this.expandedProjects,
      expandedUpskillSuggestions: expandedUpskillSuggestions ?? this.expandedUpskillSuggestions,
    );
  }

  @override
  List<Object?> get props => [
        status,
        data,
        errorMessage,
        selectedTabIndex,
        expandedProjects,
        expandedUpskillSuggestions,
      ];
}