import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:gaia/utils/collections.dart';
import 'package:pointycastle/pointycastle.dart';

// Warning: this was extracted from PointyCastle
// Must be REALLY sure before changing
final _kMaxInputSize = 450;

String _unsafeEncrypt(Encrypter encrypter, List<int> bytes) {
  final encrypted = encrypter.encryptBytes(bytes);
  return encrypted.base64;
}

List<String> encrypt(String publicKey, String data) {
  final pubKey = RSAKeyParser().parse(publicKey) as RSAPublicKey;

  final encrypter = Encrypter(RSA(
    publicKey: pubKey,
    encoding: RSAEncoding.OAEP,
  ));

  final dataPartitions = partition(utf8.encode(data), _kMaxInputSize);

  return dataPartitions.map((part) => _unsafeEncrypt(encrypter, part)).toList();
}
