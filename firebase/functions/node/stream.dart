@JS()
library stream;

import 'dart:async';

import 'package:js/js.dart';
import 'package:node_interop/node.dart';
import 'package:node_interop/util.dart';

@JS()
@anonymous
abstract class Stream {
  external dynamic get generateToken;
}

Future<String> generateToken({
  required String? idUser,
}) async {
  final stream = require('./stream.js');

  final completer = Completer();
  final doneCallback = allowInterop((result) => completer.complete(result));
  stream.generateToken(idUser, doneCallback);

  return completer.future.then(dartify);
}