import 'package:classifieds_app/models/server_response.dart';
import 'package:classifieds_app/models/user.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<User> decodeToken(ServerResponse serverResponse) async {
  final prefs = await SharedPreferences.getInstance();

  final Map<String, dynamic> authData =
      JwtDecoder.decode(serverResponse.token!);

  final user = User(
    id: authData['id'],
    fname: authData['fname'],
    lname: authData['lname'],
    role: authData['role'],
  );

  await clearPrefs(prefs);

  await prefs.setString('id', user.id!);
  await prefs.setString('fname', user.fname!);
  await prefs.setString('lname', user.lname!);
  await prefs.setString('role', user.role!);
  await prefs.setString(
    'token',
    '${serverResponse.type} ${serverResponse.token}',
  );

  return user;
}

Future<void> clearPrefs(SharedPreferences prefs) async {
  await prefs.remove('id');
  await prefs.remove('fname');
  await prefs.remove('lname');
  await prefs.remove('role');
  await prefs.remove('token');
}
