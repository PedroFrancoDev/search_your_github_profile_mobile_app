import 'package:search_your_profile/model/user_profile_model.dart';
import 'package:search_your_profile/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class UserProfileDataBloc {
  final Repository _repository = Repository();
  final _userProfileDataFetch = PublishSubject<UserProfileModel>();

  Stream<UserProfileModel> get userProfileData => _userProfileDataFetch.stream;

  fetchUserProfileData({required String? loginName}) async {
    final data = await _repository.fetchUserProfileData(loginName: loginName);

    _userProfileDataFetch.sink.add(data);
  }

  dispose() {
    _userProfileDataFetch.close();
  }
}
