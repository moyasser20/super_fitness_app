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
  static const String mealById = 'lookup.php';
  static const String musclesEndPoint = 'muscles';
  static const String musclesGroupEndPoint = 'musclesGroup';
  static const String recommendationMuscles = 'muscles/random';
  static const String muscleGroups = 'muscles';
  static const String muscleGroupsById = 'musclesGroup/{groupId}';
  static const String mealCategoriesUri =
      'https://www.themealdb.com/api/json/v1/1/categories.php';
}
