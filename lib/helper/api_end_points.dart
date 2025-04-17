class ApiEndPoints{
  /// dev
  static const String serverUrl = "https://server.itribe.us/";
  static const String learningWorldServerUrl = "https://tri.getlearnworlds.com/admin/api/";
  // static const String serverUrl = "http://192.168.1.28:8000/";
  static const String baseUrl = "${serverUrl}api/v1/";

  static const String mapKey = "AIzaSyBvXbn98lEGtl3hjl_AvORATwjygwzH9g4";
  static const String circuitKey = "AIzaSyBvXbn98lEGtl3hjl_AvORATwjygwzH9g4";

  ///------Register------///
  static const String register = "${baseUrl}auth/register";
  static const String login = "${baseUrl}auth/login";
  static const String logout = "${baseUrl}auth/logout";
  static const String otpSend = "${baseUrl}auth/email/otp/send";
  static const String verifyOTP = "${baseUrl}auth/email/otp/verify";
  static const String changePassword = "${baseUrl}change_user_password";
  static const String joinTribe = "${baseUrl}tribe/join";
  static const String homeFeeds = "${baseUrl}home-feeds";
  static const String villageFeeds = "${baseUrl}all-home-feeds";
  static const String profileFeeds = "${baseUrl}get-profile-home-feeds";
  static const String postCreate = "${baseUrl}posts";
  static const String uploadImage = "${baseUrl}attachment/upload";
  static const String emailAvailability = "${baseUrl}auth/check_availability";


  ///------POSTS------///
  static const String createComment = "${baseUrl}comments";
  static const String getComments = "${baseUrl}post";
  static const String likePost = "${baseUrl}likes";
  static const String post = "${baseUrl}post/";
  static const String favouritePost = "${baseUrl}post/favourite";
  static const String getFavouritePost = "${baseUrl}post/get-favourite";
  static const String getBlockedUser = "${baseUrl}get_user_block_contents";
  static const String blockContent = "${baseUrl}block_content";
  static const String reportContent = "${baseUrl}report_content";
  static const String postStatusUpdate = "${baseUrl}update-status/posts/visibility";

  // static const String getTribes = "${baseUrl}get_tribes";
  static const String tribes = "${baseUrl}tribes";
  static const String getAllTribesAutoComplete = "https://server.itribe.us/api/v1/get_tribes_autocomplete";// arslan
  static const String getAllTribesApi = "${baseUrl}get_tribes/1"; //arslan
  static const String getTribesDetails = "${baseUrl}tribe/details/1"; //arslan
  static const String getUsersTribes = "${baseUrl}tribe/user";
  static const String getTribeMembers = "${baseUrl}tribe/members";
  static const String tribeRemovalRequest = "${baseUrl}tribe/member_remove";
  static const String getUsersSpecificTribesDetails = "${baseUrl}tribe/details";
  static const String getSpecificTribesPosts = "${baseUrl}get_tribe_posts/";
  static const String updateTribeProfile = "${baseUrl}tribe/update_thumbnail";


  // post
  static const String getAllPost = "${baseUrl}posts";
  static const String createPost = "${baseUrl}posts";
  static const String getPostById = "${baseUrl}posts/1";
  static const String getTribePost = "${baseUrl}get_tribe_posts/204";
  static String getTribePostByTribeId(int? id) => "${baseUrl}get_tribe_posts/$id";
  static String updatePost(int? id) => "${baseUrl}posts/$id";
  static String deletePost(int? id) => "${baseUrl}posts/$id";




}

