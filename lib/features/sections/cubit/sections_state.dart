import 'package:equatable/equatable.dart';
import 'package:coffeecafe/features/sections/models/section.dart';
import 'package:coffeecafe/features/sections/models/section_item.dart';

class SectionsState extends Equatable {
  const SectionsState({
    this.sections = const [],
    this.itemsById = const {},
    this.error,
  });

  final List<Section> sections;
  final Map<String, List<SectionItem>> itemsById;
  final String? error;

  SectionsState copyWith({
    List<Section>? sections,
    Map<String, List<SectionItem>>? itemsById,
    String? error,
  }) => SectionsState(
        sections: sections ?? this.sections,
        itemsById: itemsById ?? this.itemsById,
        error: error,
      );

  @override
  List<Object?> get props => [sections, itemsById, error];
}
