import 'package:search_your_profile/model/user_profile_model.dart';
import 'package:search_your_profile/services/http_provide.dart';

class Repository {
  final UserProfileProvider _userProfileProvider = UserProfileProvider();

  Future<UserProfileModel> fetchUserProfileData({required String? loginName}) {
    return _userProfileProvider.fetchProfileUserData(
      loginName: loginName,
    );
  }
}
