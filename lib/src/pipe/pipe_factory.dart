import 'package:dart_pipeline/src/pipable.dart';
import 'package:dart_pipeline/src/pipe/pipe_factory_interface.dart';
import 'package:dart_pipeline/src/pipe/pipe_strategy_interface.dart';
import 'package:dart_pipeline/src/pipe/strategy/use_callable_pipe_strategy.dart';
import 'package:dart_pipeline/src/pipe/strategy/use_object_pipe_strategy.dart';

class PipeFactory implements PipeFactoryInterface {

  late List<PipeStrategyInterface> _strategies;

  @override
  PipeFactoryInterface setStrategies(List<PipeStrategyInterface> strategies) {
    _strategies = strategies;
    return this;
  }

  PipeFactoryInterface setDefaultStrategies() {
    _strategies = [
      UseCallablePipeStrategy(),
      UseObjectPipeStrategy()
    ];
    return this;
  }

  @override
  Pipe create(dynamic pipable) {
    for (var strategy in _strategies) {
      var pipe = strategy.create(pipable);
      if(pipe != null) {
        return pipe;
      }
    }
    throw Exception("Pipe could not be created from the given strategies");
  }
}