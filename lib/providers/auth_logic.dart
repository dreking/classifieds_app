import 'dart:convert';

import 'package:classifieds_app/data/data.dart';
import 'package:classifieds_app/models/server_response.dart';
import 'package:classifieds_app/models/user.dart';
import 'package:classifieds_app/services/decode_token.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthLogic with ChangeNotifier {
  final String _domain = getUrl();
  User _user = User();

  User get user {
    return _user;
  }

  Future<ServerResponse> signIn(User user) async {
    final uri = Uri.parse(_domain + '/auth/signin');

    try {
      final response = await http.post(
        uri,
        body: jsonEncode({
          'email': user.email,
          'password': user.password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final serverResponse = ServerResponse.fromJson(jsonDecode(response.body));
      if (!serverResponse.status!) return serverResponse;

      _user = await decodeToken(serverResponse);

      notifyListeners();

      return serverResponse;
    } catch (e) {
      print(e);

      return ServerResponse(
        status: false,
        message: 'Something went wrong. Please try again later',
      );
    }
  }
}
