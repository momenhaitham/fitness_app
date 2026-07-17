abstract class AppEndPoint {
  static const String baseUrl = "https://fitness.elevateegy.com/api/v1";
  static const String register = "/auth/signup";
  static const String forgetPassword = "/auth/forgotPassword";
  static const String verifyResetCode = "/auth/verifyResetCode";
  static const String resetPassword = '/auth/resetPassword';
  static const String login = "/auth/signin";
  static const String recommendationToDay = "/muscles/random";
  static const String upcomingWorkOut = "/muscles";
  static const String foodForYou = "https://www.themealdb.com/api/json/v1/1/categories.php";
  static const String workouts = "/muscles";
  static const String musclesGroupById = "/musclesGroup";
  static const String levels = "/levels";
  static const String randomPrimeMoverMuscles = "/muscles/random";
  static const String getExercisesByPrimeMoverMuscleAndDifficultyLevel = "/exercises/by-muscle-difficulty?primeMoverMuscleId=69d982f085f6bfa972bf2266&difficultyLevelId=69d982ed85f6bfa972bf2216";
}
