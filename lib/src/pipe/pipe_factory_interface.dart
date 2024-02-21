import 'package:dart_pipeline/src/pipable.dart';
import 'package:dart_pipeline/src/pipe/pipe_strategy_interface.dart';

abstract class PipeFactoryInterface {

  PipeFactoryInterface setStrategies(List<PipeStrategyInterface> strategies);

  Pipe create(dynamic pipable);
}