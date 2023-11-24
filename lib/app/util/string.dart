import 'dart:convert';

extension StringExtension on String {
  String get toBase64 {
    List<int> bytes = utf8.encode(this); // Convert string to UTF-8 bytes
    String encodedString = base64.encode(bytes); // Encode bytes to base64
    return encodedString;
  }

  String get base64Decode {
    List<int> bytes = base64.decode(this); // Decode base64 to bytes
    String decodedString = utf8.decode(bytes); // Convert bytes to string
    return decodedString;
  }
}
