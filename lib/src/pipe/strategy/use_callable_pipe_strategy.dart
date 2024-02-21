import 'package:dart_pipeline/src/pipable.dart';
import 'package:dart_pipeline/src/pipe/pipe_strategy_interface.dart';

class UseCallablePipeStrategy implements PipeStrategyInterface {

  @override
  Pipe? create(Pipable pipable) {
    if (pipable is! Function) {
      return null;
    }
    return (dynamic passable, Function(dynamic nextPassable) next, [dynamic parameters]) => pipable(passable, next);
  }

}