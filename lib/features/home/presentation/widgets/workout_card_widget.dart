import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/contants/app_images.dart';
import '../../../../core/utils/styles.dart';
import '../../data/models/muscle_model.dart';
import '../viewmodel/home_cubit.dart';

class WorkoutCardWidget extends StatelessWidget {
  const WorkoutCardWidget(this.muscle, {super.key});

  final Muscle muscle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image:
                  muscle.image != null
                      ? DecorationImage(
                        image: NetworkImage(muscle.image!),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withValues(alpha: 0.3),
                          BlendMode.darken,
                        ),
                      )
                      : DecorationImage(
                        image: AssetImage(AppImages.mainImage),
                        fit: BoxFit.cover,
                      ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff242424).withValues(alpha: 0.82),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 4,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                muscle.name,
                                style: balooThambi2Medium,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
