import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/features/pagination/bloc/pagination_event.dart';
import 'package:hrms_roster/features/pagination/bloc/pagination_state.dart';

typedef PageRequest<T> = Future<List<T>> Function(int page);

class PaginationBloc<T> extends Bloc<PaginationEvent, PaginationState<T>> {
  final PageRequest<T> fetchPage;
  final int limit;

  PaginationBloc({required this.fetchPage, this.limit = 30})
    : super(const PaginationState()) {
    on<LoadInitialEvent>(_loadInitial);
    on<LoadMoreEvent>(_loadMore);
    on<RefreshEvent>(_refresh);
  }

  // ================= INIT =================
  Future<void> _loadInitial(
    LoadInitialEvent event,
    Emitter<PaginationState<T>> emit,
  ) async {
    emit(state.copyWith(isLoading: true, page: 1));

    final data = await fetchPage(1);

    emit(
      state.copyWith(
        items: data,
        isLoading: false,
        page: 1,
        hasReachedMax: data.length < limit,
      ),
    );
  }

  // ================= LOAD MORE =================
  Future<void> _loadMore(
    LoadMoreEvent event,
    Emitter<PaginationState<T>> emit,
  ) async {
    if (state.hasReachedMax || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.page + 1;

    final data = await fetchPage(nextPage);

    final updated = List<T>.from(state.items)..addAll(data);

    emit(
      state.copyWith(
        items: updated,
        isLoadingMore: false,
        page: nextPage,
        hasReachedMax: data.length < limit,
      ),
    );
  }

  // ================= REFRESH =================
  Future<void> _refresh(
    RefreshEvent event,
    Emitter<PaginationState<T>> emit,
  ) async {
    add(LoadInitialEvent());
  }
}
