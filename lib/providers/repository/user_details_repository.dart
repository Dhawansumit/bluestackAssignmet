import 'package:bluestackassignment/model/login_config_response.dart';
import 'package:bluestackassignment/providers/services/user_details_service.dart';
import 'package:bluestackassignment/utils/constants/string_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<LoginConfigResponse> fetchUserDetails() async {
  LoginConfigResponse response;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  await _prefs.then((SharedPreferences prefs) async {
    response = await getUserDetails(prefs.getString(StringConstants.authToken));
    print(response);
  });

  return response;
}
