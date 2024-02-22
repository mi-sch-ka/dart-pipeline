<img src="https://github.com/mi-sch-ka/dart-pipeline/blob/main/.github/thumbnail.png?raw=true"/>

## Overview

The `dart-pipeline` library offers a seamless way to pass an object between multiple classes and execute various tasks on it.
This fluid process allows you to perform complex operations and obtain the final result once all the tasks have been completed.

## What is Pipeline?

The Pipeline class is implemented based on the [Chain of Responsibility](https://refactoring.guru/design-patterns/chain-of-responsibility) design pattern. 
This design promotes flexibility and scalability in task handling by decoupling senders and receivers of requests.

In summary; the pipelines take a job, process it, and forward it to the next pipeline.

## How to use

### Pipeline with Functions

```dart
var pipelineFactory = PipelineFactory();
var result = pipelineFactory.create()
    .send("Hello")
    .pipe([
      (dynamic passable, Function(dynamic nextPassable) next) => next([passable,"World"].join(" "))
    ])
    .thenReturn();

assert(result is String);
assert(result == "Hello World");
```
### Pipeline with Objects

```dart
var pipelineFactory = PipelineFactory();

var result = pipelineFactory.create()a
    .send("ewogICJsYW5ndWFnZSI6ImRhcnQiCn0=")
    .pipe([Base64Decoder(), JsonDecoder()])
    .thenReturn();

assert(result is Map<String, dynamic>);
assert(result["language"] == "dart");
```

You can define your pipe object by implementing the `PipeInterface`:

```dart
import 'package:dart_pipeline/dart_pipeline.dart';

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
```
