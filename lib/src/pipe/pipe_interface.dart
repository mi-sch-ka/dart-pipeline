abstract interface class PipeInterface {

  dynamic handle(dynamic passable, Function(dynamic nextPassable) next);

}