import 'package:dart_pipeline/src/pipable.dart';

abstract interface class PipeStrategyInterface  {

  Pipe? create(Pipable pipable);

}
