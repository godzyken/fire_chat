import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:firebase_functions_interop/firebase_functions_interop.dart';
import 'package:foundation/model/user_token.dart';
import 'package:foundation/request/authentication_request.dart';
import 'package:foundation/request/authentication_response.dart';

import 'stream.dart';

/*
import 'package:bazel_worker/bazel_worker.dart';
import 'package:firebase_functions_interop/firebase_functions_interop.dart' hide Message;
import 'package:foundation/model/user_token.dart';
import 'package:foundation/request/authentication_request.dart';
import 'package:foundation/request/authentication_response.dart';
import 'stream.dart';
*/


/*
class Authentication extends AsyncWorkerLoop {
  static void handle() {
    functions['createToken'] = functions.https.onRequest(createToken);
    functions['logAuth'] = functions.auth.user().onCreate(logAuth);
  }

  static Future createToken(ExpressHttpRequest? request) async {
    try {
      final requestData = AuthenticationRequest.fromJson(request!.body);

      print('@@@@@@@@@@@@ ID USer: ${requestData.idUser}');

      if (requestData.idUser.isNotEmpty) {
        final idUser = requestData.idUser;
        print('############# Got idUser: $idUser');

        final token = await generateToken(idUser: idUser);

        print('&&&&&&&&&&&&&& Got Token: $token');

        final userToken = UserToken(idUser: idUser, token: token);
        final response = AuthenticationResponse(userToken: userToken);

        await _sendResponse(request, response);
      } else {
        print('ERRRRRROR Got not idUser');
        await _sendError(request);
      }
    } catch (e) {
      print('GGGGGGGGGGGG Error: $e');
      await _sendError(request!);
    }

    return null;
  }

  static Future logAuth(UserRecord? data, EventContext? context) async {
    print(data!.email);


  }

  static Future _sendError(ExpressHttpRequest? request) async {
    final userToken = UserToken(idUser: request!.body, token: 'token');
    final response = AuthenticationResponse(error: 'Some error occurred', userToken: userToken);

    await _sendResponse(request, response);
  }

  static Future _sendResponse(ExpressHttpRequest? request, response) async {
    request?.response.headers.add("Access-Control-Allow-Origin", "*");
    request?.response.headers.add('Access-Control-Allow-Headers', '*');
    request?.response.headers.add("Access-Control-Allow-Methods", "POST,GET,DELETE,PUT,OPTIONS");
    request?.response.writeln(json.encode(response.toJson()));
    await request?.response.close();
  }

  @override
  Future<WorkResponse> performRequest(WorkRequest? request) async {
    await new File('hello.txt').writeAsString('hello word!');
    return new WorkResponse()..exitCode = EXIT_CODE_OK;
  }

}*/


class Authentication {
  static void handle() {
    functions['createToken'] = functions.https.onRequest(createToken);
    functions['logAuth'] = functions.auth.user().onCreate(logAuth);
  }

  static Future createToken(ExpressHttpRequest request) async {
    try {
      final requestData = AuthenticationRequest.fromJson(request.body);
      print('@@@@@@@@@@@@ ID USer: ' + requestData.idUser);

      if (requestData.idUser.isNotEmpty) {
        final idUser = requestData.idUser;
        print('############# Got idUser: $idUser');

        final token = await generateToken(idUser: idUser);

        print('&&&&&&&&&&&&&& Got Token: $token');

        final userToken = UserToken(idUser: idUser, token: token);
        final response = AuthenticationResponse(userToken: userToken);

        await _sendResponse(request, response);
      } else {
        print('ERRRRRROR Got not idUser');
        await _sendError(request);
      }
    request.response.close();
    } catch (e) {
      print('GGGGGGGGGGGG Error: ' + e.toString());
      await _sendError(request);
    }
  }

  /// Note that [data] argument contains actual changed user record.
  static Future logAuth(UserRecord data, EventContext context) async {
    print(data.email);
  }

  static Future _sendError(ExpressHttpRequest? request) async {
    final userToken = UserToken(idUser: request!.body, token: 'token');
    final response = AuthenticationResponse(error: 'Some error occurred', userToken: userToken);

    await _sendResponse(request, response);
  }

  static Future _sendResponse(ExpressHttpRequest? request, response) async {
    request?.response.headers.add("Access-Control-Allow-Origin", "*");
    request?.response.headers.add('Access-Control-Allow-Headers', '*');
    request?.response.headers.add("Access-Control-Allow-Methods", "POST,GET,DELETE,PUT,OPTIONS");
    request?.response.writeln(json.encode(response.toJson()));
    await request?.response.close();
  }

  static bool looksLikeStaticCall(Expression node) {
    if (node is! MethodInvocation) return false;
    var invocation = node;
    if (invocation.target == null) return false;

    // A prefixed unnamed constructor call:
    //
    //     prefix.Foo();
    if (invocation.target is SimpleIdentifier &&
        _looksLikeClassName(invocation.methodName.name)) {
      return true;
    }

    // A prefixed or unprefixed named constructor call:
    //
    //     Foo.named();
    //     prefix.Foo.named();
    var target = invocation.target;
    if (target is PrefixedIdentifier) {
      target = (target).identifier;
    }

    return target is SimpleIdentifier && _looksLikeClassName(target.name);
  }

  static bool _looksLikeClassName(String name) {
    // Handle the weird lowercase corelib names.
    if (name == 'bool') return true;
    if (name == 'double') return true;
    if (name == 'int') return true;
    if (name == 'num') return true;

    // TODO(rnystrom): A simpler implementation is to test against the regex
    // "_?[A-Z].*?[a-z]". However, that currently has much worse performance on
    // AOT: https://github.com/dart-lang/sdk/issues/37785.
    const underscore = 95;
    const capitalA = 65;
    const capitalZ = 90;
    const lowerA = 97;
    const lowerZ = 122;

    var start = 0;
    var firstChar = name.codeUnitAt(start++);

    // It can be private.
    if (firstChar == underscore) {
      if (name.length == 1) return false;
      firstChar = name.codeUnitAt(start++);
    }

    // It must start with a capital letter.
    if (firstChar < capitalA || firstChar > capitalZ) return false;

    // And have at least one lowercase letter in it. Otherwise it could be a
    // SCREAMING_CAPS constant.
    for (var i = start; i < name.length; i++) {
      var char = name.codeUnitAt(i);
      if (char >= lowerA && char <= lowerZ) return true;
    }

    return false;
  }

  static bool _isControlFlowElement(AstNode node) =>
      node is IfElement || node is ForElement;


}