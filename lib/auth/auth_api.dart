import 'dart:convert';
import 'package:http/http.dart' as http;

class AppClient {
  final _client = http.Client();
  static const _host = 'https://aidarken.herokuapp.com/auth/jwt/create/';

  Future<Uri> auth({required String email, required String password}) async {
    final url = Uri.parse('https://aidarken.herokuapp.com/auth/jwt/create/');
    final parameters = <String, dynamic>{'email': email, 'password': password};
    final request = await _client.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    final decodeResponse =
        jsonDecode(utf8.decode(request.bodyBytes)) as Map<String, dynamic>;
    final uri = Uri.parse(decodeResponse['uri'] as String);
    _client.close();
    print(uri);
    return uri;
  }
}
