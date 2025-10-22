import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:super_fitness_app/core/common/widgets/container_with_blur_widget.dart';
import 'package:super_fitness_app/core/common/widgets/custom_picker_widget.dart';
import 'package:super_fitness_app/core/common/widgets/custom_radio_button.dart';
import 'package:super_fitness_app/core/common/widgets/custom_snackbar_widget.dart';
import 'package:super_fitness_app/core/contants/app_icons.dart';
import 'package:super_fitness_app/core/contants/app_images.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/custom_elevated_button.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../core/utils/enums/register_enums.dart';
import '../viewmodel/register_viewmodel/register_cubit.dart';

class CompleteRegistrationScreen extends StatefulWidget {
  const CompleteRegistrationScreen({super.key});

  @override
  State<CompleteRegistrationScreen> createState() =>
      _CompleteRegistrationScreenState();
}

class _CompleteRegistrationScreenState
    extends State<CompleteRegistrationScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<RegisterStepType> _steps = [
    RegisterStepType.gender,
    RegisterStepType.age,
    RegisterStepType.weight,
    RegisterStepType.height,
    RegisterStepType.goal,
    RegisterStepType.activity,
  ];

  String? _selectedGender;
  int _selectedAge = 18;
  int _selectedWeight = 70;
  int _selectedHeight = 170;
  String? _selectedGoal;
  String? _selectedActivityDisplay;
  String? _selectedActivityValue;

  final List<String> _goals = RegisterStepType.goal.goals;
  final List<Map<String, String>> _activities = [
    {'display': 'Rookie', 'value': 'level1'},
    {'display': 'Beginner', 'value': 'level2'},
    {'display': 'Intermediate', 'value': 'level3'},
    {'display': 'Advance', 'value': 'level4'},
    {'display': 'True Beast', 'value': 'level5'},
  ];

  void _nextPage() {
    if (_currentPage < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeRegistration();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  void _completeRegistration() {
    final registerCubit = context.read<RegisterCubit>();

    if (_selectedGender != null) {
      registerCubit.setGender(_selectedGender!);
    }

    registerCubit.setAge(_selectedAge);
    registerCubit.setWeight(_selectedWeight);
    registerCubit.setHeight(_selectedHeight);

    if (_selectedGoal != null) {
      registerCubit.setGoal(goal: _selectedGoal!);
    }

    if (_selectedActivityValue != null) {
      registerCubit.setActivityLevel(activityLevel: _selectedActivityValue!);
    }

    registerCubit.submitRegistration();
  }

  bool _isStepValid() {
    switch (_steps[_currentPage]) {
      case RegisterStepType.gender:
        return _selectedGender != null;
      case RegisterStepType.goal:
        return _selectedGoal != null;
      case RegisterStepType.activity:
        return _selectedActivityValue != null;
      default:
        return true;
    }
  }

  Widget _buildStepContent(RegisterStepType type) {
    switch (type) {
      case RegisterStepType.gender:
        return _buildGenderStep();
      case RegisterStepType.age:
        return _buildAgeStep();
      case RegisterStepType.weight:
        return _buildWeightStep();
      case RegisterStepType.height:
        return _buildHeightStep();
      case RegisterStepType.goal:
        return _buildGoalStep();
      case RegisterStepType.activity:
        return _buildActivityStep();
    }
  }

  Widget _buildGenderStep() {
    return ContainerWithBlurWidget(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedGender = 'male';
                });
              },
              child: _GenderContainerWidget(
                gender: 'male',
                selectedGender: _selectedGender,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedGender = 'female';
                });
              },
              child: _GenderContainerWidget(
                gender: 'female',
                selectedGender: _selectedGender,
              ),
            ),
            const SizedBox(height: 30),
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAgeStep() {
    var locale = AppLocalizations.of(context);
    return ContainerWithBlurWidget(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            locale?.year ?? 'Year',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.main,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          CustomHorizontalPicker(
            initialValue: _selectedAge,
            minValue: 18,
            maxValue: 80,
            unit: 'years',
            onValueChanged: (value) {
              setState(() {
                _selectedAge = value;
              });
            },
          ),
          const SizedBox(height: 30),
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildWeightStep() {
    var locale = AppLocalizations.of(context);
    return ContainerWithBlurWidget(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            locale!.kg,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 20),
          CustomHorizontalPicker(
            initialValue: _selectedWeight,
            minValue: 40,
            maxValue: 150,
            unit: 'kg',
            onValueChanged: (value) {
              setState(() {
                _selectedWeight = value;
              });
            },
          ),
          const SizedBox(height: 30),
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildHeightStep() {
    var locale = AppLocalizations.of(context);
    return ContainerWithBlurWidget(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            locale!.cm,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 20),
          CustomHorizontalPicker(
            initialValue: _selectedHeight,
            minValue: 140,
            maxValue: 220,
            unit: '',
            onValueChanged: (value) {
              setState(() {
                _selectedHeight = value;
              });
            },
          ),
          const SizedBox(height: 30),
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildGoalStep() {
    return ContainerWithBlurWidget(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _goals.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final goal = _goals[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedGoal = goal;
                      });
                    },
                    child: CustomRadioButton(
                      selectedGoal: _selectedGoal,
                      value: goal,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildActivityStep() {
    return ContainerWithBlurWidget(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _activities.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final activity = _activities[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedActivityDisplay = activity['display'];
                        _selectedActivityValue = activity['value'];
                      });
                    },
                    child: CustomRadioButton(
                      selectedGoal: _selectedActivityDisplay,
                      value: activity['display']!,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    var locale = AppLocalizations.of(context);
    return CustomElevatedButton(
      color: _isStepValid() ? AppColors.main : AppColors.grey[80],
      width: double.infinity,
      isLoading: context.read<RegisterCubit>().state is RegisterLoading,
      text: _currentPage == _steps.length - 1 ? locale!.finish : locale!.next,
      onPressed: _isStepValid() ? _nextPage : () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoaded) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.dashboard,
            (route) => false,
          ).then(
            (value) => showCustomSnackBar(context, locale!.completed_success),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.fitnessBc),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SafeArea(
                        child: Center(
                          child: Image.asset(AppIcons.fitnessLogo, width: 90),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: CircularPercentIndicator(
                          radius: 28.0,
                          animation: false,
                          animationDuration: 300,
                          lineWidth: 5.0,
                          center: Text(
                            '${_currentPage + 1}/${_steps.length}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          progressColor: AppColors.main,
                          percent:
                              _currentPage == _steps.length - 1
                                  ? 1.0
                                  : _currentPage / _steps.length,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _steps[_currentPage].title,
                        style: TextStyle(
                          fontSize: _currentPage == 5 ? 25 : 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 4),
                      if (_steps[_currentPage].subtitle.isNotEmpty)
                        Text(
                          _steps[_currentPage].subtitle,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      const SizedBox(height: 30),
                      Flexible(
                        child: PageView(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (page) {
                            setState(() {
                              _currentPage = page;
                            });
                          },
                          children:
                              _steps
                                  .map((step) => _buildStepContent(step))
                                  .toList(),
                        ),
                      ),
                      _currentPage != _steps.length - 6 &&
                              _currentPage != _steps.length - 2 &&
                              _currentPage != _steps.length - 1 &&
                              _currentPage != _steps.length
                          ? Spacer()
                          : SizedBox(),
                      /*if (state is RegisterLoading)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),*/
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                child: GestureDetector(
                  onTap: _previousPage,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: AppColors.main,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SvgPicture.asset(AppIcons.backIcon, width: 12),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GenderContainerWidget extends StatelessWidget {
  final String? selectedGender;
  final String gender;

  const _GenderContainerWidget({
    required this.selectedGender,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        color: selectedGender == gender ? AppColors.main : Colors.transparent,
        borderRadius: BorderRadius.circular(80),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.8),
          width: selectedGender != gender ? 1.0 : 0,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            gender == 'male' ? AppIcons.maleIcon : AppIcons.femaleIcon,
            width: 60,
            height: 60,
            color:
                selectedGender == gender
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.8),
          ),
          const SizedBox(height: 4),
          Text(
            gender == 'male' ? locale!.gender_male : locale!.gender_female,
            style: TextStyle(
              fontSize: 14,
              color:
                  selectedGender == gender
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.8),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
