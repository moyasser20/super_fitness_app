import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/features/exercise/presentation/view/widgets/exercise_card.dart';
import '../../../../core/common/widgets/custome_loading_indicator.dart';
import '../../../../core/contants/app_icons.dart';
import '../../../../core/contants/app_images.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../viewmodel/exercise_states.dart';
import '../viewmodel/exercise_viewmodel.dart';

class ExerciseScreen extends StatefulWidget {
  final String primeMoverMuscleId;
  final String primeMoverMuscleName;

  const ExerciseScreen({
    super.key,
    required this.primeMoverMuscleId,
    required this.primeMoverMuscleName,
  });

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  String? selectedLevelId;
  String? backgroundThumbnail;

  @override
  void initState() {
    super.initState();

    final cubit = context.read<ExerciseViewModel>();

    cubit.getAllDifficultyLevels(widget.primeMoverMuscleId).then((_) {
      final levels = cubit.difficultyLevelResponse?.difficultyLevels ?? [];
      if (levels.isNotEmpty) {
        final firstLevel = levels.first;
        cubit.getExerciseByMuscleAndDifficulty(
          widget.primeMoverMuscleId,
          firstLevel.id ?? '',
          difficultyLevels: levels,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocConsumer<ExerciseViewModel, ExerciseState>(
      listener: (context, state) {
        if (state is ExerciseDataLoaded &&
            state.exercises.exercises.isNotEmpty) {
          final exercises = state.exercises.exercises;
          final firstVideoUrl =
              exercises.first.shortYoutubeDemonstrationLink ??
              exercises.first.inDepthYoutubeExplanationLink ??
              "https://youtu.be/2zVNyi5Uk44";

          backgroundThumbnail = context
              .read<ExerciseViewModel>()
              .getYouTubeThumbnail(firstVideoUrl);
        }
      },
      builder: (context, state) {
        final cubit = context.read<ExerciseViewModel>();
        final levels = cubit.difficultyLevelResponse?.difficultyLevels ?? [];
        final selectedId = cubit.selectedDifficultyId;

        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.homeBc),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (backgroundThumbnail != null)
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.network(
                      backgroundThumbnail!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 260,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 270,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                          Colors.black,
                        ],
                        stops: [0.2, 0.6, 1.0],
                      ),
                    ),
                  ),
                ],
              )
            else
              Container(color: Colors.transparent),

            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
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
                backgroundColor: Colors.transparent,
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "${widget.primeMoverMuscleName}  ${local.exercise_title}",
                        style: balooThambi2BoldLarge.copyWith(
                          color: AppColors.white,
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      local.exercise_subtitle,
                      style: balooThambi2BoldLarge.copyWith(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.6),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            local.exercise_duration,
                            style: balooThambi2BoldLarge.copyWith(
                              color: AppColors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.6),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            local.exercise_calories,
                            style: balooThambi2BoldLarge.copyWith(
                              color: AppColors.orange,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (levels.isNotEmpty)
                    Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xff242424),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        child: SizedBox(
                          height: 45,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: levels.length,
                            itemBuilder: (context, index) {
                              final level = levels[index];
                              final isSelected = selectedId == level.id;
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap:
                                      () => cubit
                                          .getExerciseByMuscleAndDifficulty(
                                            widget.primeMoverMuscleId,
                                            level.id ?? '',
                                            difficultyLevels: levels,
                                          ),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          isSelected
                                              ? AppColors.orange
                                              : Colors.transparent,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      level.name ?? '',
                                      style: balooThambi2BoldLarge.copyWith(
                                        color:
                                            isSelected
                                                ? Colors.white
                                                : Colors.white.withOpacity(0.8),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Builder(
                      builder: (_) {
                        if (state is GetLevelsLoading ||
                            state is ExerciseLoading) {
                          return const Center(child: AppLoadingIndicator());
                        } else if (state is ExerciseDataLoaded) {
                          final exercises = state.exercises.exercises ?? [];
                          if (exercises.isEmpty) {
                            return Center(
                              child: Text(
                                local.no_exercises_found,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            );
                          }
                          return Container(
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xff242424),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: ListView.builder(
                                itemCount: exercises.length,
                                itemBuilder: (context, index) {
                                  final ex = exercises[index];
                                  if (ex.shortYoutubeDemonstrationLink ==
                                          null ||
                                      ex
                                          .shortYoutubeDemonstrationLink!
                                          .isEmpty) {
                                    return const SizedBox.shrink();
                                  }
                                  final thumb = cubit.getYouTubeThumbnail(
                                    ex.shortYoutubeDemonstrationLink ??
                                        ex.inDepthYoutubeExplanationLink ??
                                        "",
                                  );
                                  return ExerciseCard(
                                    title: ex.exercise,
                                    description:
                                        ex.primaryEquipment ??
                                        local.no_description,
                                    thumbnailUrl: thumb,
                                    videoUrl: ex.shortYoutubeDemonstrationLink!,
                                  );
                                },
                              ),
                            ),
                          );
                        } else if (state is ExerciseError ||
                            state is GetLevelsError) {
                          final msg =
                              (state is ExerciseError)
                                  ? state.message
                                  : (state as GetLevelsError).message;
                          return Center(
                            child: Text(
                              msg,
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
