import 'package:coffeecafe/core/constants/app_assets.dart';
import 'package:coffeecafe/core/constants/app_strings.dart';
import 'package:coffeecafe/core/routes/app_router.dart';
import 'package:coffeecafe/features/splash/cubit/splash_cubit.dart';
import 'package:coffeecafe/features/splash/cubit/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeCup;
  late final Animation<Offset> _slideText;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeCup = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideText = Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    // Start animations slightly after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigateLogin) {
          context.go(AppRoutes.login);
        }
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppAssets.splashBg, fit: BoxFit.cover),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 290.h),
                    Center(
                      child: FadeTransition(
                        opacity: _fadeCup,
                        child: Column(
                          children: [
                            Image.asset(
                              AppAssets.cup,
                              width: 52.w,
                              height: 52.w,
                              color: scheme.secondary,
                            ),
                            SizedBox(height: 14.h),
                            Text(
                              AppStrings.coffeeTaste,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    letterSpacing: 3,
                                    color: scheme.onSurface,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 60.h),
                    SlideTransition(
                      position: _slideText,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.findYourFavorite,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w500,
                                  color: scheme.onSurface,
                                ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            AppStrings.coffeeTasteTitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontSize: 44.sp,
                                  height: 1.1,
                                  fontWeight: FontWeight.w800,
                                  color: scheme.onSurface,
                                ),
                          ),
                          SizedBox(height: 18.h),
                          Text(
                            AppStrings.splashSubtitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontSize: 16.sp,
                                  color: const Color(0xCCFFFFFF),
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
