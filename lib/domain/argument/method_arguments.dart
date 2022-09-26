import 'package:uber_clone/domain/argument/who_called.dart';

class MethodArguments {
  String title;
  WhoCalled whoCalled;
  dynamic clazz;

  MethodArguments({
    required this.title,
    required this.whoCalled,
    this.clazz,
  });
}
