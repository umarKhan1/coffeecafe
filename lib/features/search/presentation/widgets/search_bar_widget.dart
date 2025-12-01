import 'dart:async';
import 'package:coffeecafe/core/constants/app_strings.dart';
import 'package:coffeecafe/features/search/cubit/search_cubit.dart';
import 'package:coffeecafe/features/search/cubit/search_state.dart';
import 'package:coffeecafe/features/search/models/search_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffeecafe/features/product_detail/models/product_id_mapper.dart';
import 'package:coffeecafe/features/product_detail/presentation/pages/product_detail_page.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});
  @override
  Widget build(BuildContext context) => const _SearchBarWrapper();
}

class _SearchBarWrapper extends StatefulWidget {
  const _SearchBarWrapper();
  @override
  State<_SearchBarWrapper> createState() => _SearchBarWrapperState();
}

class _SearchBarWrapperState extends State<_SearchBarWrapper> {
  late final TextEditingController _controller;
  final List<String> _phrases = AppStrings.searchHintPhrases;
  int _index = 0;
  int _charCursor = 0;
  bool _forward = true;
  bool _paused = false;
  String _animated = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _startAnimation();
  }

  void _startAnimation() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 140), (t) {
      if (!mounted) return;
      if (_controller.text.isNotEmpty) return; // user typing -> pause
      final phrase = _phrases[_index];
      if (_paused) return;
      setState(() {
        if (_forward) {
          if (_charCursor < phrase.length) {
            _charCursor++;
            _animated = phrase.substring(0, _charCursor);
            if (_charCursor == phrase.length) {
              _paused = true;
              Future.delayed(const Duration(milliseconds: 650), () {
                if (!mounted || _controller.text.isNotEmpty) return;
                _paused = false;
                _forward = false;
              });
            }
          }
        } else {
          if (_charCursor > 0) {
            _charCursor--;
            _animated = _charCursor == 0 ? '' : phrase.substring(0, _charCursor);
            if (_charCursor == 0) {
              _paused = true;
              Future.delayed(const Duration(milliseconds: 350), () {
                if (!mounted || _controller.text.isNotEmpty) return;
                _paused = false;
                _forward = true;
                _index = (_index + 1) % _phrases.length;
              });
            }
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (p, c) => p.query != c.query || p.results != c.results,
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: _SearchField(
                controller: _controller,
                animatedHint: _animated,
              ),
            ),
            SizedBox(height: 12.h),
            if (state.query.isNotEmpty && state.results.isNotEmpty)
              _SearchResultsList(items: state.results),
          ],
        );
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.animatedHint});
  final TextEditingController controller;
  final String animatedHint;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.2),
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.white.withValues(alpha: 0.4), size: 25.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: cubit.onQueryChanged,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              cursorColor: Colors.white.withValues(alpha: 0.7),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: controller.text.isEmpty ? '${AppStrings.searchPrefix} $animatedHint' : null,
                hintStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.45),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                controller.clear();
                cubit.clearSearch();
              },
              child: Icon(Icons.close, color: Colors.white.withValues(alpha: 0.5), size: 20.sp),
            )
          else
            SizedBox(width: 20.w), // spacer instead of filter icon
        ],
      ),
    );
  }
}

class _SearchResultsList extends StatelessWidget {
  const _SearchResultsList({required this.items});
  final List<SearchItem> items;
  @override
  Widget build(BuildContext context) => SizedBox(
        height: 200.h,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return TweenAnimationBuilder<double>(
              key: ValueKey(item.id),
              tween: Tween(begin: 0, end: 1),
              duration: Duration(milliseconds: 240 + 40 * index),
              builder: (context, value, child) => Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, (1 - value) * 12),
                  child: child,
                ),
              ),
              child: _SearchResultTile(item: item),
            );
          },
        ),
      );
}

class _SearchResultTile extends StatelessWidget {
  const _SearchResultTile({required this.item});
  final SearchItem item;
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: GestureDetector(
          onTap: () {
            final id = ProductIdMapper.fromTitle(item.name);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => ProductDetailPage(productId: id)),
            );
          },
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(
                    item.image,
                    width: 50.w,
                    height: 50.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 50.w,
                      height: 50.w,
                      color: Colors.white.withValues(alpha: 0.1),
                      child: const Icon(Icons.image_not_supported, color: Colors.white54),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14.sp),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        item.category,
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
