import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/l10n/translation/app_localizations.dart';
import 'package:super_fitness_app/core/routes/route_names.dart';

import '../../../../core/common/widgets/custom_card_shimmer_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../viewmodel/home_cubit.dart';
import 'workout_card_widget.dart';

class RecommendationToDayWidget extends StatelessWidget {
  const RecommendationToDayWidget({super.key, required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(local.recommendation_to_you, style: balooThambi2BoldExtraLarge),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.editProfileScreen);
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
        SizedBox(height: 12),
        _buildRecommendationsList(state, () {
          context.read<HomeCubit>().loadHomeData();
        }, context),
      ],
    );
  }

  Widget _buildRecommendationsList(
    HomeState state,
    Function() onTap,
    BuildContext context,
  ) {
    if (state is HomeLoading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.12,
        child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return CustomCardShimmerWidget();
          },
        ),
      );
    }

    if (state is HomeError) {
      return SizedBox(
        height: 135,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Failed to load recommendations'),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  onTap();
                },
                child: Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (state is HomeLoaded) {
      final muscles = state.recommendedMuscles;

      return SizedBox(
        height: 135,
        child: ListView.builder(
          itemCount: muscles.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder:
              (context, index) => Container(
                width: MediaQuery.of(context).size.width * 0.3,
                margin: EdgeInsets.only(right: 12),
                child: WorkoutCardWidget(muscles[index]),
              ),
        ),
      );
    }

    return SizedBox(
      height: 135,
      child: Center(child: CircularProgressIndicator(color: AppColors.orange)),
    );
  }
}
