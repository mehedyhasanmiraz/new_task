class Urls {
  static const String _baseUrl = "http://35.73.30.144:2005/api/v1";
  static const String registerUrl = "$_baseUrl/registration"; // ✅ lowercase
  static const String loginUrl = "$_baseUrl/Login"; // ✅ lowercase
  static const String updateProfileUrl =
      "$_baseUrl/ProfileUpdate"; // ✅ lowercase
  static const String crateTaskUrl = "$_baseUrl/createTask"; // ✅ lowercase
  static const String taskStatusCountUrl =
      "$_baseUrl/taskStatusCount"; // ✅ lowercase
  static const String newTaskListUrl =
      "$_baseUrl/listTaskByStatus/New"; // ✅ lowercase
  static const String ProgressTaskListUrl =
      "$_baseUrl/listTaskByStatus/Progress"; // ✅ lowercase
  static const String completeTaskUrl =
      "$_baseUrl/listTaskByStatus/Complete"; // ✅ lowercase
  static const String cancelledTaskUrl =
      "$_baseUrl/listTaskByStatus/Cancelled"; // ✅ lowercase

  static String updateTaskStatusUrl(String taskId, String status) =>
      "$_baseUrl/updateTaskStatus/$taskId/$status"; // ✅ lowercase
  static String deleteTaskUrl(String taskId,) =>
      "$_baseUrl/deleteTask/$taskId"; // ✅ lowercase
}
