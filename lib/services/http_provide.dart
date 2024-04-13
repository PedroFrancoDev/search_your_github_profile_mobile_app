import "dart:convert";

import "package:http/http.dart";
import "package:search_your_profile/model/user_profile_model.dart";

class UserProfileProvider {
  final client = Client();

  Future<UserProfileModel> fetchProfileUserData({required String? loginName}) async {
    final response = await client.get(
      Uri.https(
        "api.github.com",
        "/users/$loginName",
      ),
    );

    if (response.statusCode == 200) {
      final result = UserProfileModel.fromJson(
        jsonDecode(response.body),
      );

      return result;
    } else {
      throw Exception("Erro na requisição");
    }
  }
}
