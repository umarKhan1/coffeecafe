import 'package:coffeecafe/features/sections/models/section.dart';
import 'package:coffeecafe/features/sections/models/section_item.dart';

abstract class ISectionsRepository {
  Future<List<Section>> getSections();
  Future<List<SectionItem>> getItems(String sectionId);
}
