import 'package:dart_pipeline/src/pipable.dart';

abstract class PipelineInterface {

  PipelineInterface send(dynamic passable);

  PipelineInterface through(List<Pipable> pipes);

  PipelineInterface pipe(List<Pipable> pipes);

  dynamic then(Function(dynamic) destination);

  dynamic thenReturn();
}