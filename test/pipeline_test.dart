import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:dart_pipeline/src/pipe/pipe_interface.dart';
import 'package:dart_pipeline/src/pipeline_factory.dart';

void main() {
  test('test pipeline with functions', () async {
    var pipelineFactory = PipelineFactory();

    var result = pipelineFactory.create()
        .send("Hello")
        .pipe([
          (dynamic passable, Function(dynamic nextPassable) next) => next([passable,"World"].join(" "))
    ]).thenReturn()
    ;
    assert(result is String);
    assert(result == "Hello World");
  });

  test('test pipeline with objects', () async {
    var pipelineFactory = PipelineFactory();

    var result = pipelineFactory.create()
        .send("ewogICJsYW5ndWFnZSI6ImRhcnQiCn0=")
        .pipe([Base64Decoder(), JsonDecoder()])
        .thenReturn()
    ;
    assert(result is Map<String, dynamic>);
    assert(result["language"] == "dart");
  });
}

class Base64Decoder implements PipeInterface {

  @override
  dynamic handle(dynamic passable, Function(dynamic nextPassable) next) {
    var bytes = base64.decode(passable);
    var decoded = utf8.decode(bytes);
    return next(decoded);
  }
}

class JsonDecoder implements PipeInterface {

  @override
  dynamic handle(dynamic passable, Function(dynamic nextPassable) next) {
    return next(jsonDecode(passable));
  }
}


