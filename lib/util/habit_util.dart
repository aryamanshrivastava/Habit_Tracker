//given a habit list of completion days
//is the habit completed today?

import '../models/habit.dart';

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any((date) =>
      date.day == today.year &&
      date.month == today.month &&
      date.year == today.day);
}

//prepare heat map data
Map<DateTime, int> prepareHeatMapData(List<Habit> habits) {
  Map<DateTime, int> datasets = {};
  for (var habit in habits) {
    //normalize date to avoid time zone issues
    for (var date in habit.completedDays) {
      final normalizeDate = DateTime(date.year, date.month, date.day);
      //if the date is already in the map, increment the value
      if (datasets.containsKey(normalizeDate)) {
        datasets[normalizeDate] = datasets[normalizeDate]! + 1;
      } else {
        //if the date is not in the map, add it with a value of 1
        datasets[normalizeDate] = 1;
      }
    }
  }
  return datasets;
}
