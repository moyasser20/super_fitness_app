import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'dart:convert';
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
                          _buildAppBar(state),
                          SizedBox(height: Dimensions.paddingDefault),
                          Text('Category', style: balooThambi2BoldExtraLarge),
                          SizedBox(height: Dimensions.paddingSmall),
                          _buildCategorySection(),
                          SizedBox(height: Dimensions.paddingDefault),
                          RecommendationToDayWidget(state: state),
                          SizedBox(height: Dimensions.paddingDefault),
                          _buildUpcomingWorkoutsSection(state),
                          SizedBox(height: Dimensions.paddingDefault),
                          Text(
                            'Recommendation for you',
                            style: balooThambi2BoldExtraLarge,
                          ),
                          SizedBox(height: Dimensions.paddingSmall),
                          _buildRecommendationForYouSection(state),
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

  Widget _buildAppBar(HomeState state) {
    final userName = state is HomeLoaded ? state.userName : 'Omar';
    final userImage =
        state is HomeLoaded ? state.userImage : AppImages.mainImage;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi $userName,', style: balooThambi2MediumExtraLarge),
            Text('Let\'s start your day', style: balooThambi2BoldExtraLarge),
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

  Widget _buildCategorySection() {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xff242424),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: CategoryItemWidget(
              catName: 'Gym',
              icon: AppIcons.gymIcon,
              showDivider: true,
            ),
          ),
          Expanded(
            child: CategoryItemWidget(
              catName: 'Fitness',
              icon: AppIcons.fitnessIcon,
              showDivider: true,
            ),
          ),
          Expanded(
            child: CategoryItemWidget(
              catName: 'Yoga',
              icon: AppIcons.yogaIcon,
              showDivider: true,
            ),
          ),
          Expanded(
            child: CategoryItemWidget(
              catName: 'Aerobics',
              icon: AppIcons.aerobicsIcon,
              showDivider: true,
            ),
          ),
          Expanded(
            child: CategoryItemWidget(
              catName: 'Trainer',
              icon: AppIcons.trainerIcon,
              showDivider: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingWorkoutsSection(HomeState state) {
    final muscleGroups = state is HomeLoaded ? state.muscleGroups : [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Upcoming Workouts', style: balooThambi2BoldExtraLarge),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.workoutsScreen,
                  arguments: true,
                );
              },
              child: Text(
                'See All',
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
            child: Center(child: Text('Failed to load workouts')),
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
                    /*final isLoadingThisGroup =
                    state.isLoadingMuscleGroupDetails && isDetailsShowing;
*/
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
        // _buildMuscleGroupsList(state),
        if (state is HomeLoaded && state.selectedWorkout != null)
          _buildWorkoutList(state),
        if (state is HomeLoading) _buildWorkoutList(state),
      ],
    );
  }

  Widget _buildWorkoutList(HomeState state) {
    if (state is! HomeLoaded) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.12,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (_, __) => const CustomCardShimmerWidget(),
          ),
        ),
      );
    }

    if (state is HomeLoading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.12,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (_, __) => const CustomCardShimmerWidget(),
          ),
        ),
      );
    }
    if (state.selectedWorkout == null ||
        state.selectedWorkout!.muscles.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'No workouts available',
            style: balooThambi2MediumLarge.copyWith(),
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
            itemBuilder:
                (context, index) => Container(
                  width: MediaQuery.of(context).size.width * 0.24,
                  margin: EdgeInsets.only(right: 16),
                  child: WorkoutCardWidget(details.muscles[index]),
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationForYouSection(HomeState state) {
    return Column(
      children: [
        FutureBuilder<String>(
          future: DefaultAssetBundle.of(
            context,
          ).loadString('assets/json_files/recommendation_for_you.json'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              log(snapshot.error.toString());
              return Text('Failed to load recommendations');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No recommendations found');
            }
            final data = json.decode(snapshot.data!);
            final List categories = data['categories'] ?? [];
            return SizedBox(
              height: 115,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: RecommendationFoodCard(
                      name: cat['strCategory'],
                      imageUrl: cat['strCategoryThumb'],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  //   Widget _buildMuscleGroupsList(HomeState state) {
  //     if (state is HomeError) {
  //       return SizedBox(
  //         height: 40,
  //         child: Center(child: Text('Failed to load workouts')),
  //       );
  //     }
  //
  //     if (state is HomeLoaded) {
  //       final muscleGroups = state.muscleGroups;
  //
  //       return Column(
  //         children: [
  //           SizedBox(
  //             height: 40,
  //             child: ListView.builder(
  //               scrollDirection: Axis.horizontal,
  //               itemCount: muscleGroups.length,
  //               itemBuilder: (context, index) {
  //                 final group = muscleGroups[index];
  //                 final isSelected = state.selectedMuscleIds.contains(group.id);
  //                 final isDetailsShowing =
  //                     state.selectedMuscleGroupDetails?.muscleGroup.id ==
  //                         group.id;
  //                 /*final isLoadingThisGroup =
  //                     state.isLoadingMuscleGroupDetails && isDetailsShowing;
  // */
  //                 return GestureDetector(
  //                   onTap: () {
  //                     context.read<HomeCubit>().loadMuscleGroupDetails(group.id);
  //                   },
  //                   child: MuscleGroupItemWidget(
  //                     title: group.name,
  //                     isSelected: isSelected || isDetailsShowing,
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       );
  //     }
  //
  //     return SizedBox(
  //       height: 40,
  //       child: Center(child: CircularProgressIndicator(color: AppColors.orange)),
  //     );
  //   }
}
