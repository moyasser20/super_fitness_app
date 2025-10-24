enum RegisterStepType { gender, age, weight, height, goal, activity }

extension RegisterStepTypeText on RegisterStepType {
  String get title {
    switch (this) {
      case RegisterStepType.gender:
        return 'TELL US ABOUT YOURSELF!';
      case RegisterStepType.age:
        return 'HOW OLD ARE YOU?';
      case RegisterStepType.weight:
        return 'WHAT IS YOUR WEIGHT?';
      case RegisterStepType.height:
        return 'WHAT IS YOUR HEIGHT?';
      case RegisterStepType.goal:
        return 'WHAT IS YOUR GOAL?';
      case RegisterStepType.activity:
        return 'Your Regular Physical Activity Level?';
    }
  }

  String get subtitle {
    switch (this) {
      case RegisterStepType.gender:
        return 'We Need To Know Your Gender';
      case RegisterStepType.age:
        return 'This Helps Us Create Your Personalized Plan';
      case RegisterStepType.weight:
        return 'This Helps Us Create Your Personalized Plan';
      case RegisterStepType.height:
        return 'Select your height in cm';
      case RegisterStepType.goal:
        return 'This Helps Us Create Your Personalized Workout Plan';
      case RegisterStepType.activity:
        return '';
    }
  }

  List<String> get goals {
    switch (this) {
      case RegisterStepType.goal:
        return [
          'Gain Weight',
          'Lose Weight',
          'Get Fitter',
          'Gain More Flexible',
          'Learn The Basic',
        ];
      default:
        return [];
    }
  }

  List<String> get activities {
    switch (this) {
      case RegisterStepType.activity:
        return [
          'Rookie',
          'Beginner',
          'Intermediate',
          'Advanced',
          'Expert',
        ];
      default:
        return [];
    }
  }
}

class RegisterStep {
  final RegisterStepType type;

  const RegisterStep(this.type);
}
