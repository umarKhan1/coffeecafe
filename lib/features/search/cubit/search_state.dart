import 'package:coffeecafe/features/search/models/search_item.dart';
import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  const SearchState({
    this.query = '',
    this.results = const [],
    this.error,
    this.hintText = '',
    this.hintIndex = 0,
  });

  final String query;
  final List<SearchItem> results;
  final String? error;
  final String hintText; // animated typewriter text
  final int hintIndex; // which phrase we are animating

  SearchState copyWith({
    String? query,
    List<SearchItem>? results,
    String? error,
    String? hintText,
    int? hintIndex,
  }) =>
      SearchState(
        query: query ?? this.query,
        results: results ?? this.results,
        error: error,
        hintText: hintText ?? this.hintText,
        hintIndex: hintIndex ?? this.hintIndex,
      );

  @override
  List<Object?> get props => [query, results, error, hintText, hintIndex];
}
