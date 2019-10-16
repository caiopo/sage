import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:gaia/utils/collections.dart';
import 'package:pointycastle/pointycastle.dart';

const pubKeyStr = '''-----BEGIN PUBLIC KEY-----
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAytB3niWxwf8m56QwTf78
VGk4vZkukAAo3AolaguNZkCvrUfJ+cKP2Md++K+5El+eVjwvXFAf/OuEqTwEeBFn
GXexnRuR1L1ZHbOBKF4xNRjlFwoXFZHeHIc1BTZy+stqUrQWpMVnOE66QaB89y9g
FLiIuMMBJzlfj4iLrjLfKar8V02ngUka6v9O7Mck66CRo0S708pCbM4lJnZV7S/y
J+nxocznKx3enM2M3w6QrlbXRtwDawly360A8aBcHOZx1zFk6bTOeDg5He1VF3Wz
GM9ZWS0DBKjdcU6hP60ShS3ydLSt/myGJoN/M3UvWLz2P0DNzqCj16ViMH8zLp4t
ao3bfAhNp9dBVNvJHQnqHQiCEZezo9GTce4vvdglSfyvHbDT8Y5SpC2UxIuLPFpS
UOKl1twDwxJoodOo2uHGBR3+cu1K1SupHrzUPaLoggGPsXyDuEdepEz32Bixt9bD
nz7E8XOiqvqAmUqOBn6fpdDDVFX5M+nNUuOKKDaAl3JD078GibdvEuX1p4EM1BcP
ecFBGi4Dfpb+/yL7mUjxvcPZKrD9XD5CNtU+5M/LrCmB3eAzyp1Ux/49b2fSl3P0
yPdRY4QOGmTsZ6sb4OAgqNV3ql5xRBMUtVgO+SKv4qaR+ccNdBlCO/b4DoUuCvts
/o7ipIdDNshtGDMIHcm7kIUCAwEAAQ==
-----END PUBLIC KEY-----''';

// Warning: this was extracted from PointyCastle
// Must be REALLY sure before changing
final _kMaxInputSize = 450;

String _unsafeEncrypt(Encrypter encrypter, List<int> bytes) {
  final encrypted = encrypter.encryptBytes(bytes);
  return encrypted.base64;
}

List<String> encrypt(String publicKey, String data) {
  final pubKey = RSAKeyParser().parse(pubKeyStr) as RSAPublicKey;

  final encrypter = Encrypter(RSA(
    publicKey: pubKey,
    encoding: RSAEncoding.OAEP,
  ));

  final dataPartitions = partition(utf8.encode(data), _kMaxInputSize);

  return dataPartitions.map((part) {
    print(part.length);
    return _unsafeEncrypt(encrypter, part);
  }).toList();
}

void main() {
  print(encrypt(pubKeyStr, a));
}

const a = '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam rutrum tortor dui, quis congue diam facilisis scelerisque. In tempor a justo in feugiat. Nulla facilisi. Integer at erat velit. Duis nec elit felis. Morbi vel tortor vel magna sollicitudin dignissim sollicitudin vehicula velit. Duis in dolor vel dolor fringilla suscipit. Donec facilisis lacinia urna ac fringilla. Etiam nisi nunc, ornare quis velit ac, convallis laoreet nisl.

Aenean sodales nunc sed vestibulum fringilla. Nunc tempor diam vel odio pulvinar, non vestibulum nisi malesuada. Nullam sit amet arcu fermentum velit tincidunt lacinia. Ut ac quam et massa elementum feugiat et a dolor. Sed in nisl lorem. Quisque leo eros, semper ut iaculis id, fermentum quis sem. Sed dapibus quam metus, non finibus orci faucibus non. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In luctus interdum leo. Quisque convallis metus lacus, ac scelerisque nisl suscipit nec. Phasellus volutpat ullamcorper nisi, ac ornare ligula rhoncus a. Nulla ac dignissim massa, at cursus metus. Integer at tincidunt lacus, non imperdiet erat. Curabitur massa orci, ullamcorper sit amet velit at, venenatis ultrices ante. Donec venenatis neque quam, id hendrerit mi convallis vitae.
''';
