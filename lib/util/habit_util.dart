//given a habit list of completion days
//is the habit completed today?

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any((date) =>
      date.day == today.year &&
      date.month == today.month &&
      date.year == today.day);
}
