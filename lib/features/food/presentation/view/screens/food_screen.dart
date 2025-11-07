import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/utils/styles.dart';
import '../../../../../core/common/widgets/custome_loading_indicator.dart';
import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/contants/app_images.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/routes/route_names.dart';
import '../../viewmodel/food_states.dart';
import '../../viewmodel/food_viewmodel.dart';

class FoodScreen extends StatefulWidget {
  final String? initialCategory;

  const FoodScreen({super.key, this.initialCategory});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<String> _categories = [];
  List<dynamic> _meals = [];

  @override
  void initState() {
    super.initState();
    context.read<MealsCubit>().loadCategories();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocConsumer<MealsCubit, FoodStates>(
      listener: (context, state) {
        if (state is FoodCategoriesLoaded) {
          _categories = state.categories;

          _tabController?.dispose();
          _tabController = TabController(
            length: _categories.length,
            vsync: this,
          );

          final initialIndex =
              widget.initialCategory != null
                  ? _categories.indexOf(widget.initialCategory!)
                  : 0;

          final validIndex =
              (initialIndex >= 0 && initialIndex < _categories.length)
                  ? initialIndex
                  : 0;

          _tabController!.index = validIndex;

          context.read<MealsCubit>().getMealsByCategory(
            _categories[validIndex],
          );
        } else if (state is FoodLoaded) {
          _meals = state.meals;
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(AppImages.homeBc, fit: BoxFit.cover),
              ),
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
                    pinned: true,
                    floating: true,
                    leading: Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: AppColors.main,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SvgPicture.asset(AppIcons.backIcon),
                        ),
                      ),
                    ),
                    title: Text(
                      local.food_recommendation,
                      style: balooThambi2BoldExtraLarge.copyWith(fontSize: 24),
                    ),
                    bottom:
                        _categories.isNotEmpty && _tabController != null
                            ? PreferredSize(
                              preferredSize: const Size.fromHeight(60),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: SizedBox(
                                  height: 45,
                                  child: TabBar(
                                    controller: _tabController,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    tabAlignment: TabAlignment.start,
                                    physics: const BouncingScrollPhysics(),
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    isScrollable: true,
                                    indicator: BoxDecoration(
                                      color: AppColors.orange,
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    dividerColor: Colors.transparent,
                                    labelColor: AppColors.white,
                                    unselectedLabelColor: AppColors.white
                                        .withOpacity(0.7),
                                    labelStyle: balooThambi2Bold,
                                    labelPadding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    tabs:
                                        _categories
                                            .map(
                                              (category) => Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 6.0,
                                                    ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 18.0,
                                                      vertical: 6.0,
                                                    ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        25.0,
                                                      ),
                                                ),
                                                child: Tab(text: category),
                                              ),
                                            )
                                            .toList(),
                                    onTap: (index) {
                                      final selectedCategory =
                                          _categories[index];
                                      context
                                          .read<MealsCubit>()
                                          .getMealsByCategory(selectedCategory);
                                    },
                                  ),
                                ),
                              ),
                            )
                            : null,
                  ),

                  if (state is FoodLoading)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: AppLoadingIndicator()),
                    )
                  else if (state is FoodError)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          state.message,
                          style: balooThambi2MediumLarge,
                        ),
                      ),
                    )
                  else if (_tabController != null && _categories.isNotEmpty)
                    SliverFillRemaining(
                      child: TabBarView(
                        controller: _tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children:
                            _categories
                                .map(
                                  (category) => _buildFoodGrid(_meals, local),
                                )
                                .toList(),
                      ),
                    )
                  else
                    const SliverToBoxAdapter(child: SizedBox.shrink()),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFoodGrid(List<dynamic> foods, AppLocalizations local) {
    if (foods.isEmpty) {
      return Center(
        child: Text(local.no_foods_available, style: balooThambi2MediumLarge),
      );
    }

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              final food = foods[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.foodDetailsScreen,
                    arguments: food.idMeal,
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4),
                            BlendMode.colorBurn,
                          ),
                          image: NetworkImage(food.strMealThumb ?? ""),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                          ),
                        ),
                        child: Text(
                          food.strMeal ?? local.unnamed_food,
                          textAlign: TextAlign.center,
                          style: balooThambi2BoldExtraLarge,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }, childCount: foods.length),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 1.0,
            ),
          ),
        ),
      ],
    );
  }
}
