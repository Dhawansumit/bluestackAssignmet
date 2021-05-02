import 'dart:typed_data';
import 'package:bluestackassignment/model/login_config_response.dart';
import 'package:bluestackassignment/utils/constants/string_constants.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';
import 'package:bluestackassignment/model/user_details_model.dart';




class LoginService {
  // final _authClientId = StringConstants.authClientId;
  // final _scopes = StringConstants.scopesList;
  // String _token;
  // final _key = StringConstants.encryptDecryptKey;
  // OAuthService oAuthService;

  // LoginService(IOAuthService oAuthService) {
  //   this.oAuthService = oAuthService;
  // }

  // getBaseUrl(QRDetails qrDetails) {
  //   return qrDetails.protocol +
  //       '://' +
  //       qrDetails.server +
  //       StringConstants.portNumber;
  // }

  // QRDetails useQrCode(String qrCode) {
  //   if (!QrDecoder.validateQrDetails(qrCode)) throw ("Invalid QR Code");
  //   return QRDetails.fromJson(JwtDecoder.decode(qrCode));
  // }
  //
  Future<String> getAccessToken(UserDetails user) async {
       final body = jsonEncode(user.toJson());
       final uri = Uri.parse(StringConstants.baseURL + StringConstants.authenticate);
      final headers = <String, String>{
        'Content-Type': 'application/json',
      };
        final response = await http.post(uri, headers: headers, body: body);
        print(jsonDecode(response.body));;
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["token"];

      }
      else if(response.statusCode == 401){
        throw Exception('Invalid Username and password');
      }
      else {
        throw Exception('Failed to obtain token');
      }

   }



  // String createAuthBody(String token) {
  //   final String authBody = '{"token":"$token"}';
  //   return authBody;
  // }
  //
  // Uint8List createUint8ListFromString(String s) {
  //   var ret = new Uint8List(s.length);
  //   for (var i = 0; i < s.length; i++) {
  //     ret[i] = s.codeUnitAt(i);
  //   }
  //   return ret;
  // }
  //
  // String getEncryptedAuth(String token) {
  //   final body = createAuthBody(token);
  //   final keyBytes = createUint8ListFromString(_key);
  //   final key = encrypt.Key(keyBytes);
  //   final encryptor = encrypt.Encrypter(
  //       encrypt.AES(key, mode: encrypt.AESMode.ecb, padding: "PKCS7"));
  //   final encrypted = encryptor.encrypt(body);
  //   return base64.encode(encrypted.bytes);
  // }
  //
  // String decryptBody(String body) {
  //   final keyBytes = createUint8ListFromString(_key);
  //   final key = encrypt.Key(keyBytes);
  //   final encryptor = encrypt.Encrypter(
  //       encrypt.AES(key, mode: encrypt.AESMode.ecb, padding: null));
  //   final decrypted = encryptor.decrypt64(body);
  //   return decrypted;
  // }
  //
  // Future getConfig(QRDetails qrDetail, String token) async {
  //   final body = getEncryptedAuth(token);
  //   final uri = Uri.parse(getBaseUrl(qrDetail) + StringConstants.getConfigPath);
  //   final headers = <String, String>{
  //     'Content-Type': 'application/x-www-form-urlencoded',
  //   };
  //   final response = await http.post(uri, headers: headers, body: body);
  //   if (response.statusCode == 200) {
  //     String decrypted = decryptBody(response.body);
  //     // Remove trailing padding
  //     int jsonEndPos = decrypted.lastIndexOf('}');
  //     if (jsonEndPos != -1) {
  //       decrypted = decrypted.substring(0, jsonEndPos + 1);
  //     }
  //     LoginConfigResponse configResponse =
  //         LoginConfigResponse.fromJson(json.decode(decrypted));
  //     return configResponse;
  //   } else {
  //     throw Exception('Failed to obtain config');
  //   }
  //}
}
