import 'package:flutter/material.dart';
import 'package:super_fitness_app/features/exercise/presentation/view/widgets/youtube_web_view_screen.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/styles.dart';

class ExerciseCard extends StatelessWidget {
  final String title;
  final String description;
  final String thumbnailUrl;
  final String videoUrl;

  const ExerciseCard({
    super.key,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(color: Color(0xff242424)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            thumbnailUrl,
            width: 60,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          title,
          style: balooThambi2BoldLarge.copyWith(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              local.exercise_reps_info,
              style: balooThambi2BoldLarge.copyWith(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            Text(
              description,
              style: balooThambi2BoldLarge.copyWith(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.play_circle_fill,
            color: AppColors.orange,
            size: 32,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => YouTubeWebViewScreen(videoUrl: videoUrl,isFood: false,),
              ),
            );
          },
        ),
      ),
    );
  }
}
