import 'package:coffeecafe/features/search/models/search_item.dart';
import 'package:coffeecafe/features/search/repositories/i_search_repository.dart';

class SearchRepository implements ISearchRepository {
  // Mock data - replace with API calls later
  static final List<SearchItem> mockItems = [
    const SearchItem(
      id: '1',
      name: 'Mocha',
      image: 'asset/images/cupimage.png',
      category: 'Coffee',
    ),
    const SearchItem(
      id: '2',
      name: 'Wine',
      image: 'asset/images/chai.png',
      category: 'Wine Bar',
    ),
    const SearchItem(
      id: '3',
      name: 'Chai Latte',
      image: 'asset/images/chai.png',
      category: 'Coffee',
    ),
    const SearchItem(
      id: '4',
      name: 'Matcha',
      image: 'asset/images/matcha.png',
      category: 'Coffee',
    ),
    const SearchItem(
      id: '5',
      name: 'Red Eye Coffee',
      image: 'asset/images/edeye.png',
      category: 'Coffee',
    ),
    const SearchItem(
      id: '6',
      name: 'Beer',
      image: 'asset/images/cupimage.png',
      category: 'Beer',
    ),
  ];

  @override
  Future<List<SearchItem>> search(String query) async {
    // Simulate API call with delay
    await Future<void>.delayed(const Duration(milliseconds: 300));

    if (query.isEmpty) return [];

    return mockItems
        .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
