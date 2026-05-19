import 'dart:convert';

import 'package:logger/logger.dart';

final logger = Logger();

Future<dynamic> jsonToObject(String? jsonTxt) async {
  return json.decoder.convert(jsonTxt ?? '{}');
}

String toJSON(Object obj) {
  return json.encoder.convert(obj);
}
