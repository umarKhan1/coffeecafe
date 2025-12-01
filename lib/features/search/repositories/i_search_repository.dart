import 'package:coffeecafe/features/search/models/search_item.dart';

abstract class ISearchRepository {
  Future<List<SearchItem>> search(String query);
}
