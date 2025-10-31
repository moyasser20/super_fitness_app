abstract class ApiEndPoints {
  static const String signup = 'auth/signup';
  static const String login = 'auth/signin';
  static const String forgetPassword = 'auth/forgotPassword';
  static const String resetPassword = 'auth/resetPassword';
  static const String verifyReset = 'auth/verifyResetCode';
  static const String logout = 'auth/logout';
  static const String profileData = 'auth/profile-data';
  static const String changePassword = 'auth/change-password';
  static const String editProfile = 'auth/editProfile';
  static const String recommendationMuscles = 'muscles/random';
  static const String muscleGroups = 'muscles';
  static const String muscleGroupsById = 'musclesGroup/{groupId}';
  static const String getAllDifficultyLevels = 'levels/difficulty-levels/by-prime-mover';
  static const String getExerciseByMuscleAndDifficulty = 'exercises/by-muscle-difficulty';
}
