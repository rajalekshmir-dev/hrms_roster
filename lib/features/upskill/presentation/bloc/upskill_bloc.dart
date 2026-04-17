import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_upskill_suggestions.dart';
import 'upskill_event.dart';
import 'upskill_state.dart';

class UpskillBloc extends Bloc<UpskillEvent, UpskillState> {
  final GetUpskillSuggestions getUpskillSuggestions;

  UpskillBloc({required this.getUpskillSuggestions}) : super(const UpskillState()) {
    on<LoadUpskillSuggestions>(_onLoadUpskillSuggestions);
    on<RefreshUpskillSuggestions>(_onRefreshUpskillSuggestions);
    on<ToggleProjectExpansion>(_onToggleProjectExpansion);
    on<ToggleUpskillExpansion>(_onToggleUpskillExpansion);
    on<SelectTab>(_onSelectTab);
  }

  Future<void> _onLoadUpskillSuggestions(
    LoadUpskillSuggestions event,
    Emitter<UpskillState> emit,
  ) async {
    emit(state.copyWith(status: UpskillStatus.loading));
    
    final result = await getUpskillSuggestions();
    
    result.fold(
      (failure) => emit(state.copyWith(
        status: UpskillStatus.error,
        errorMessage: _mapFailureToMessage(failure),
      )),
      (data) => emit(state.copyWith(
        status: UpskillStatus.loaded,
        data: data,
      )),
    );
  }

  Future<void> _onRefreshUpskillSuggestions(
    RefreshUpskillSuggestions event,
    Emitter<UpskillState> emit,
  ) async {
    emit(state.copyWith(status: UpskillStatus.refreshing));
    
    final result = await getUpskillSuggestions();
    
    result.fold(
      (failure) => emit(state.copyWith(
        status: UpskillStatus.error,
        errorMessage: _mapFailureToMessage(failure),
      )),
      (data) => emit(state.copyWith(
        status: UpskillStatus.loaded,
        data: data,
      )),
    );
  }

  void _onToggleProjectExpansion(
    ToggleProjectExpansion event,
    Emitter<UpskillState> emit,
  ) {
    final newExpanded = Set<int>.from(state.expandedProjects);
    if (newExpanded.contains(event.projectIndex)) {
      newExpanded.remove(event.projectIndex);
    } else {
      newExpanded.add(event.projectIndex);
    }
    emit(state.copyWith(expandedProjects: newExpanded));
  }

  void _onToggleUpskillExpansion(
    ToggleUpskillExpansion event,
    Emitter<UpskillState> emit,
  ) {
    final newExpanded = Set<int>.from(state.expandedUpskillSuggestions);
    if (newExpanded.contains(event.upskillIndex)) {
      newExpanded.remove(event.upskillIndex);
    } else {
      newExpanded.add(event.upskillIndex);
    }
    emit(state.copyWith(expandedUpskillSuggestions: newExpanded));
  }

  void _onSelectTab(
    SelectTab event,
    Emitter<UpskillState> emit,
  ) {
    emit(state.copyWith(selectedTabIndex: event.tabIndex));
  }

  String _mapFailureToMessage(dynamic failure) {
    // Add your failure mapping logic here
    return 'Failed to load upskill suggestions. Please try again.';
  }
}