import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffeecafe/features/sections/repositories/i_sections_repository.dart';
import 'package:coffeecafe/features/sections/cubit/sections_state.dart';
import 'package:coffeecafe/features/sections/models/section_item.dart';

class SectionsCubit extends Cubit<SectionsState> {
  SectionsCubit({required ISectionsRepository repository})
      : _repository = repository,
        super(const SectionsState());

  final ISectionsRepository _repository;

  Future<void> load() async {
    try {
      final sections = await _repository.getSections();
      final Map<String, List<SectionItem>> map = {};
      for (final s in sections) {
        final items = await _repository.getItems(s.id);
        map[s.id] = items;
      }
      emit(state.copyWith(sections: sections, itemsById: map));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to load sections: $e'));
    }
  }
}
