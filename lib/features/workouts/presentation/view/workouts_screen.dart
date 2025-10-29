import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/config/di.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/muscle_group_details_response.dart';
import 'package:super_fitness_app/features/workouts/presentation/viewmodel/workouts_states.dart';
import 'package:super_fitness_app/features/workouts/presentation/viewmodel/workouts_view_model.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WorkoutsViewModel>()..getAllMuscles(),
      child: BlocBuilder<WorkoutsViewModel, WorkoutsState>(
        builder: (context, state) {
          if (state.allMusclesStatus == DataStatus.loading) {
            return const Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state.allMusclesStatus == DataStatus.error) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(child: Text('Error: ${state.allMusclesError}')),
            );
          }

          final categories =
              state.muscleGroups
                  .map((e) => e.name ?? '')
                  .where((name) => name.isNotEmpty)
                  .toList();

          if (categories.isEmpty) {
            return const Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(child: Text('No muscle categories available')),
            );
          }

          return DefaultTabController(
            length: categories.length,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: _buildAppBar(context, categories, state),
              body: _buildBody(state),
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
  ) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Workouts',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
          fontFamily: "Baloo Thambi 2",
        ),
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
        labelStyle: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
        ),
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

  Widget _buildBody(WorkoutsState state) {
    return TabBarView(
      children:
          state.muscleGroups.map((_) {
            if (state.muscleDetailsStatus == DataStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.orange),
              );
            } else if (state.muscleDetailsStatus == DataStatus.error) {
              return Center(child: Text('Error: ${state.muscleDetailsError}'));
            } else if (state.muscleDetailsStatus == DataStatus.success) {
              return _buildWorkoutGrid(state.muscles);
            } else {
              return const SizedBox.shrink();
            }
          }).toList(),
    );
  }

  Widget _buildWorkoutGrid(List<Muscle> workouts) {
    if (workouts.isEmpty) {
      return const Center(
        child: Text(
          'No workouts available for this category.',
          style: TextStyle(color: Colors.white),
        ),
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
          return Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                image: NetworkImage(
                  workout.image ??
                      "https://static.thenounproject.com/png/261694-200.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
                child: Text(
                  workout.name ?? 'Unnamed Workout',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
