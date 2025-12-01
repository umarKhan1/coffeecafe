import 'dart:async';
import 'package:coffeecafe/features/search/cubit/search_state.dart';
import 'package:coffeecafe/features/search/repositories/search_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({SearchRepository? repository})
      : _repository = repository ?? SearchRepository(),
        super(const SearchState());

  final SearchRepository _repository;
  int _requestId = 0;
  Timer? _debounce;

  void onQueryChanged(String query) {
    _debounce?.cancel();
    emit(state.copyWith(query: query, error: null));

    if (query.isEmpty) {
      emit(state.copyWith(results: [], hintText: ''));
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 250), () async {
      final int requestId = ++_requestId;
      try {
        final results = await _repository.search(query);
        if (requestId != _requestId) return; // stale
        emit(state.copyWith(results: results));
      } catch (e) {
        emit(state.copyWith(error: 'Search failed: $e'));
      }
    });
  }

  void clearSearch() {
    _requestId++; // invalidate in-flight
    _debounce?.cancel();
    emit(const SearchState());
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
