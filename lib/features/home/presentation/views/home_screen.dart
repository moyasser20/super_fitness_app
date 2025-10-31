import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/l10n/translation/app_localizations.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/features/exercise/presentation/viewmodel/exercise_viewmodel.dart';
import '../../../../core/common/widgets/custom_card_shimmer_widget.dart';
import '../../../../core/contants/app_icons.dart';
import '../../../../core/contants/app_images.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/styles.dart';
import '../viewmodel/home_cubit.dart';
import '../widgets/category_item_widget.dart';
import '../widgets/muscle_group_item_widget.dart';
import '../widgets/workout_card_widget.dart';
import '../widgets/recommendation_food_card.dart';
import '../widgets/recommendation_to_day_widget.dart';

class HomeScreen extends StatefulWidget {
  final ScrollController? scrollController;

  const HomeScreen({super.key, this.scrollController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController _effectiveController;

  @override
  void initState() {
    super.initState();
    _effectiveController = widget.scrollController ?? ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().loadHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.homeBc),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(Dimensions.paddingSmall),
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      return await context.read<HomeCubit>().loadHomeData();
                    },
                    color: AppColors.orange,
                    backgroundColor: Colors.white,
                    child: SingleChildScrollView(
                      controller: _effectiveController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAppBar(context, state, local),
                          SizedBox(height: Dimensions.paddingDefault),
                          Text(
                            local.category,
                            style: balooThambi2BoldExtraLarge,
                          ),
                          SizedBox(height: Dimensions.paddingSmall),
                          _buildCategorySection(local),
                          SizedBox(height: Dimensions.paddingDefault),
                          RecommendationToDayWidget(state: state),
                          SizedBox(height: Dimensions.paddingDefault),
                          _buildUpcomingWorkoutsSection(context, state, local),
                          SizedBox(height: Dimensions.paddingDefault),
                          Row(
                            children: [
                              Text(
                                local.recommendationForYou,
                                style: balooThambi2BoldExtraLarge,
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.foodScreen,
                                    arguments: true,
                                  );
                                },
                                child: Text(
                                  local.seeAll,
                                  style: balooThambi2RegularLarge.copyWith(
                                    color: AppColors.orange,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.paddingSmall),
                          _buildRecommendationForYouSection(state, local),
                          SizedBox(height: Dimensions.paddingSmall),
                          _buildPopularTrainingSection(local),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    HomeState state,
    AppLocalizations local,
  ) {
    final userName = state is HomeLoaded ? state.userName : 'User';
    final userImage =
        state is HomeLoaded ? state.userImage : AppImages.mainImage;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(local.hiUser(userName!), style: balooThambi2MediumExtraLarge),
            Text(local.startYourDay, style: balooThambi2BoldExtraLarge),
          ],
        ),
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          child: Image.asset(userImage!, fit: BoxFit.cover),
        ),
      ],
    );
  }

  Widget _buildCategorySection(AppLocalizations local) {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xff242424),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: CategoryItemWidget(
              catName: local.gym,
              icon: AppIcons.gymIcon,
              showDivider: true,
            ),
          ),
          Expanded(
            child: CategoryItemWidget(
              catName: local.fitness,
              icon: AppIcons.fitnessIcon,
              showDivider: true,
            ),
          ),
          Expanded(
            child: CategoryItemWidget(
              catName: local.yoga,
              icon: AppIcons.yogaIcon,
              showDivider: true,
            ),
          ),
          Expanded(
            child: CategoryItemWidget(
              catName: local.aerobics,
              icon: AppIcons.aerobicsIcon,
              showDivider: true,
            ),
          ),
          Expanded(
            child: CategoryItemWidget(
              catName: local.trainer,
              icon: AppIcons.trainerIcon,
              showDivider: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingWorkoutsSection(
    BuildContext context,
    HomeState state,
    AppLocalizations local,
  ) {
    final muscleGroups = state is HomeLoaded ? state.muscleGroups : [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(local.upcomingWorkouts, style: balooThambi2BoldExtraLarge),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.workoutsScreen,
                  arguments: true,
                );
              },
              child: Text(
                local.seeAll,
                style: balooThambi2RegularLarge.copyWith(
                  color: AppColors.orange,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.orange,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.paddingSmall),
        if (state is HomeError)
          SizedBox(
            height: 40,
            child: Center(child: Text(local.failedToLoadWorkouts)),
          ),
        if (state is HomeLoaded)
          Column(
            children: [
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: muscleGroups.length,
                  itemBuilder: (context, index) {
                    final group = muscleGroups[index];
                    final isSelected = state.selectedMuscleIds.contains(
                      group.id,
                    );
                    final isDetailsShowing =
                        state.selectedWorkout?.muscleGroup.id == group.id;
                    return GestureDetector(
                      onTap: () {
                        context.read<HomeCubit>().loadMuscleGroupDetails(
                          group.id,
                        );
                      },
                      child: MuscleGroupItemWidget(
                        title: group.name,
                        isSelected: isSelected || isDetailsShowing,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        if (state is HomeLoaded && state.selectedWorkout != null)
          _buildWorkoutList(context, state, local),
        if (state is HomeLoading) _buildWorkoutList(context, state, local),
      ],
    );
  }

  Widget _buildWorkoutList(
    BuildContext context,
    HomeState state,
    AppLocalizations local,
  ) {
    if (state is! HomeLoaded ||
        state.selectedWorkout == null ||
        state.selectedWorkout!.muscles.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            local.noWorkoutsAvailable,
            style: balooThambi2MediumLarge,
          ),
        ),
      );
    }

    final details = state.selectedWorkout!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Dimensions.paddingDefault),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.11,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: details.muscles.length,
            itemBuilder: (context, index) {
              final muscle = details.muscles[index];
              return Container(
                width: MediaQuery.of(context).size.width * 0.24,
                margin: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.exercisesScreen,
                      arguments: ExerciseData(id: muscle.id, name: muscle.name),
                    );
                  },
                  child: WorkoutCardWidget(muscle),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationForYouSection(
    HomeState state,
    AppLocalizations local,
  ) {
    if (state is HomeLoaded && state.mealCategories.isEmpty) {
      return SizedBox(
        height: 115,
        child: Center(child: Text(local.noRecommendationsFound)),
      );
    }
    if (state is HomeError) {
      return SizedBox(
        height: 115,
        child: Center(child: Text(local.failedToLoadRecommendations)),
      );
    }

    if (state is HomeLoaded && state.mealCategories.isNotEmpty) {
      return SizedBox(
        height: 115,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state.mealCategories.length,
          itemBuilder: (context, index) {
            final category = state.mealCategories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () {
                  // 👇 Navigate to FoodScreen with selected category
                  Navigator.pushNamed(
                    context,
                    AppRoutes.foodScreen,
                    arguments: category.name,
                  );
                },
                child: RecommendationFoodCard(
                  name: category.name,
                  imageUrl: category.thumbnail,
                ),
              ),
            );
          },
        ),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.12,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (_, __) => const CustomCardShimmerWidget(),
      ),
    );
  }

  Widget _buildPopularTrainingSection(AppLocalizations local) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(local.popularTraining, style: balooThambi2BoldExtraLarge),
        SizedBox(height: Dimensions.paddingSmall),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder:
                (context, index) => Container(
                  width: 250,
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4),
                        BlendMode.colorBurn,
                      ),
                      image: AssetImage(AppImages.popularImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          local.exerciseStrengthenChest,
                          textAlign: TextAlign.center,
                          style: balooThambi2BoldExtraLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.122),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                local.tasksCount("24"),
                                style: balooThambi2MediumLarge,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.122),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                local.difficultyBeginner,
                                style: balooThambi2BoldLarge.copyWith(
                                  color: AppColors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.paddingSmall - 2),
                    ],
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
