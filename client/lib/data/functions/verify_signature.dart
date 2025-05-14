import 'dart:convert' show utf8;
import 'package:crypto/crypto.dart' show Hmac, sha256;

///Function to verify signature from server
bool verifySignature(
  String name,
  String number,
  bool found,
  String signatureFromServer,
) {
  const secret = 'supersecretkey';
  final message = '$name:$number:${found ? 'True' : 'False'}'; //
  final key = utf8.encode(secret);
  final hmacSha256 = Hmac(sha256, key);
  final digest = hmacSha256.convert(utf8.encode(message)).toString();
  return digest == signatureFromServer;
}
