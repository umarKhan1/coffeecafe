import 'package:coffeecafe/core/constants/app_assets.dart';
import 'package:coffeecafe/core/constants/app_strings.dart';
import 'package:coffeecafe/features/sections/models/section.dart';
import 'package:coffeecafe/features/sections/models/section_item.dart';
import 'package:coffeecafe/features/sections/repositories/i_sections_repository.dart';

class SectionsRepository implements ISectionsRepository {
  const SectionsRepository();

  static final List<Section> _sections = [
    Section(id: 'frozen', title: AppStrings.sectionFrozenBeverages),
    Section(id: 'kava', title: AppStrings.sectionKavaBottled),
  ];

  static final Map<String, List<SectionItem>> _items = {
    'frozen': [
      SectionItem(id: 'f1', title: 'Coffee', price: 22.0, image: AppAssets.cup),
      SectionItem(id: 'f2', title: 'Coffee', price: 85.0, image: AppAssets.chai),
    ],
    'kava': [
      SectionItem(id: 'k1', title: 'Kava Drink', price: 35.0, image: AppAssets.matcha),
      SectionItem(id: 'k2', title: 'Bottle Water', price: 5.0, image: AppAssets.cup),
    ],
  };

  @override
  Future<List<Section>> getSections() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return _sections;
  }

  @override
  Future<List<SectionItem>> getItems(String sectionId) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return _items[sectionId] ?? const [];
  }
}
