import 'package:flutter/services.dart';

final numberOnly = WhitelistingTextInputFormatter(RegExp(r'-?\d+'));
