import 'package:isar/isar.dart';
part 'app_settings.g.dart';

class AppSettings {
  Id id = Isar.autoIncrement;
  DateTime? firstLaunchDate;
}