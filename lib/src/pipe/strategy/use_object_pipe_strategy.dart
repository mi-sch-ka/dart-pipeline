import 'package:dart_pipeline/src/pipable.dart';
import 'package:dart_pipeline/src/pipe/pipe_interface.dart';
import 'package:dart_pipeline/src/pipe/pipe_strategy_interface.dart';

class UseObjectPipeStrategy implements PipeStrategyInterface {

  @override
  Pipe? create(Pipable pipable) {
    if (pipable is! PipeInterface) {
      return null;
    }
    return (dynamic passable, Function(dynamic nextPassable) next, [dynamic parameters]) => pipable.handle(passable, next);
  }
}
