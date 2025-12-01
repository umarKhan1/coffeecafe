import 'package:coffeecafe/features/product_detail/cubit/product_detail_cubit.dart';
import 'package:coffeecafe/features/product_detail/cubit/product_detail_state.dart';
import 'package:coffeecafe/features/product_detail/presentation/widgets/detail_description_block.dart';
import 'package:coffeecafe/features/product_detail/presentation/widgets/detail_header_image.dart';
import 'package:coffeecafe/features/product_detail/presentation/widgets/detail_milk_selector.dart';
import 'package:coffeecafe/features/product_detail/presentation/widgets/detail_price_cta.dart';
import 'package:coffeecafe/features/product_detail/presentation/widgets/detail_title_block.dart';
import 'package:coffeecafe/features/product_detail/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductDetailCubit>(
      create: (_) => ProductDetailCubit(repository: const ProductRepository())..load(productId),
      child: const _ProductDetailView(),
    );
  }
}

class _ProductDetailView extends StatelessWidget {
  const _ProductDetailView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            }
            if (state.error != null) {
              return Center(
                child: Text(state.error!, style: const TextStyle(color: Colors.red)),
              );
            }
            final product = state.product!;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
               
                      
           DetailHeaderImage(image: product.image),               GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          
                          child: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 28.h),
                  DetailTitleBlock(title: product.title, subtitle: product.subtitle, rating: product.rating),
                  SizedBox(height: 24.h),
                  DetailDescriptionBlock(
                    text: product.description,
                    expanded: state.expanded,
                    onToggle: context.read<ProductDetailCubit>().toggleExpanded,
                  ),
                  SizedBox(height: 32.h),
                  DetailMilkSelector(
                    available: product.availableMilks,
                    selected: state.selectedMilk,
                    onSelect: context.read<ProductDetailCubit>().selectMilk,
                  ),
                  SizedBox(height: 40.h),
                  DetailPriceCta(
                    price: product.price,
                    enabled: state.selectedMilk != null,
                    onAdd: () {
                      // TODO integrate CartCubit later
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:  Text('Added to cart', style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white
                          ),),
                          backgroundColor: Colors.black,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 60.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
