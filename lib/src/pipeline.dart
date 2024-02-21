import 'package:dart_pipeline/src/pipable.dart';
import 'package:dart_pipeline/src/pipe/pipe_factory_interface.dart';
import 'package:dart_pipeline/src/pipeline_interface.dart';

class Pipeline extends PipelineInterface {
  /// The object being passed through the pipeline.
  late dynamic _passable;

  late PipeFactoryInterface _pipeFactory;

  List<Pipable> _pipes = [];

  PipelineInterface setPipeFactory(PipeFactoryInterface pipeFactory) {
    _pipeFactory = pipeFactory;
    return this;
  }

  @override
  PipelineInterface send(passable) {
    _passable = passable;
    return this;
  }

  @override
  PipelineInterface pipe(List<Pipable> pipes) {
    _pipes.addAll(pipes);
    return this;
  }

  @override
  PipelineInterface through(List<Pipable> pipes) {
    _pipes = pipes;
    return this;
  }

  @override
  dynamic then(Function(dynamic) destination) {
    var pipeline = _pipes.reversed.fold<dynamic>(
      prepareDestination(destination),
      carry(),
    );

    return pipeline(_passable);
  }

  @override
  dynamic thenReturn() => then((passable) => passable);

  Function(dynamic) prepareDestination(Function(dynamic) destination) {
    return (passable) {
      try {
        return destination(passable);
      } on Exception catch (e) {
        return handleException(passable, e);
      }
    };
  }

  /// Get a Closure that represents a slice of the application onion.
  Function(dynamic, dynamic) carry() {
    return (stack, pipable) {
      return (passable) {
          try {
            var pipe = _pipeFactory.create(pipable);
            var carry = pipe(passable, stack);
            return handleCarry(carry);
          } on Exception catch (e) {
            return handleException(passable, e);
          }
        };
    };
  }

  dynamic handleCarry(dynamic carry) => carry;

  dynamic handleException(dynamic passable, Exception exception) => throw exception;
}
