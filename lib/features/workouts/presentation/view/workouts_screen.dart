import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/core/config/di.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/utils/styles.dart';
import 'package:super_fitness_app/features/exercise/presentation/viewmodel/exercise_viewmodel.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/muscle_group_details_response.dart';
import 'package:super_fitness_app/features/workouts/presentation/viewmodel/workouts_states.dart';
import 'package:super_fitness_app/features/workouts/presentation/viewmodel/workouts_view_model.dart';
import '../../../../core/contants/app_icons.dart';
import '../../../../core/contants/app_images.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/routes/route_names.dart';

class WorkoutsScreen extends StatelessWidget {
  final bool isFromHome;

  const WorkoutsScreen({super.key, this.isFromHome = false});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => getIt<WorkoutsViewModel>()..getAllMuscles(),
      child: BlocBuilder<WorkoutsViewModel, WorkoutsState>(
        builder: (context, state) {
          if (state.allMusclesStatus == DataStatus.loading) {
            return const Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: CircularProgressIndicator(color: AppColors.orange),
              ),
            );
          } else if (state.allMusclesStatus == DataStatus.error) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Text(
                  local.errorWithMessage(state.allMusclesError ?? ''),
                ),
              ),
            );
          }

          final categories =
              state.muscleGroups
                  .map((e) => e.name ?? '')
                  .where((name) => name.isNotEmpty)
                  .toList();

          if (categories.isEmpty) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(child: Text(local.noMuscleCategoriesAvailable)),
            );
          }

          return DefaultTabController(
            length: categories.length,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.transparent,
              appBar: _buildAppBar(context, categories, state, isFromHome),
              body: _buildBody(context, state),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(
    BuildContext context,
    List<String> categories,
    WorkoutsState state,
    bool isFromHome,
  ) {
    final local = AppLocalizations.of(context)!;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading:
          !isFromHome
              ? null
              : Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
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
        local.workouts,
        style: balooThambi2BoldExtraLarge.copyWith(fontSize: 24),
      ),
      bottom: TabBar(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        tabAlignment: TabAlignment.start,
        physics: const BouncingScrollPhysics(),
        indicatorSize: TabBarIndicatorSize.tab,
        isScrollable: true,
        indicator: BoxDecoration(
          color: AppColors.orange,
          borderRadius: BorderRadius.circular(25.0),
          shape: BoxShape.rectangle,
        ),
        dividerColor: Colors.transparent,
        labelColor: AppColors.white,
        labelStyle: balooThambi2Bold,
        unselectedLabelColor: AppColors.white,
        tabs: categories.map((category) => Tab(text: category)).toList(),
        onTap: (index) {
          final muscleGroup = state.muscleGroups[index];
          if (muscleGroup.id != null) {
            context.read<WorkoutsViewModel>().getMusclesGroup(muscleGroup.id!);
          }
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, WorkoutsState state) {
    final local = AppLocalizations.of(context)!;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.homeBc),
              fit: BoxFit.cover,
            ),
          ),
        ),
        TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children:
              state.muscleGroups.map((_) {
                if (state.muscleDetailsStatus == DataStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.orange),
                  );
                } else if (state.muscleDetailsStatus == DataStatus.error) {
                  return Center(
                    child: Text(
                      local.errorWithMessage(state.muscleDetailsError ?? ''),
                    ),
                  );
                } else if (state.muscleDetailsStatus == DataStatus.success) {
                  return _buildWorkoutGrid(context, state.muscles);
                } else {
                  return const SizedBox.shrink();
                }
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildWorkoutGrid(BuildContext context, List<Muscle> workouts) {
    final local = AppLocalizations.of(context)!;

    if (workouts.isEmpty) {
      return Center(
        child: Text(local.noWorkoutsAvailable, style: balooThambi2MediumLarge),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.0,
        ),
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final workout = workouts[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.exercisesScreen,
                arguments: ExerciseData(id: workout.id!, name: workout.name!),
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
                        Colors.black.withValues(alpha: 0.4),
                        BlendMode.colorBurn,
                      ),
                      image: NetworkImage(
                        workout.image ??
                            "https://static.thenounproject.com/png/261694-200.png",
                      ),
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
                      workout.name ?? local.unnamedWorkout,
                      textAlign: TextAlign.center,
                      style: balooThambi2BoldExtraLarge,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
