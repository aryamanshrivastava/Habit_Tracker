import 'package:isar/isar.dart';
part 'habit.g.dart';
class Habit {
  Id id = Isar.autoIncrement;
  late String name;
  List<DateTime> completedDays = [

  ];
}