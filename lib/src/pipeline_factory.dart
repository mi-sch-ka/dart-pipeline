import 'package:dart_pipeline/src/pipe/pipe_factory.dart';
import 'package:dart_pipeline/src/pipeline.dart';
import 'package:dart_pipeline/src/pipeline_factory_interface.dart';
import 'package:dart_pipeline/src/pipeline_interface.dart';

class PipelineFactory implements PipelineFactoryInterface {

  @override
  PipelineInterface create() {
    return Pipeline()
      .setPipeFactory(PipeFactory().setDefaultStrategies())
    ;
  }
}