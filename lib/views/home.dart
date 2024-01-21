// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:habit_tracker/components/my_habit_tile.dart';
import 'package:habit_tracker/components/my_heat_map.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:provider/provider.dart';

import '../components/my_drawer.dart';
import '../models/habit.dart';
import '../util/habit_util.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController textcontroller = TextEditingController();
  void createNewHabit() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textcontroller,
                decoration: InputDecoration(
                  hintText: 'Create a new habit',
                ),
              ),
              actions: [
                MaterialButton(
                    onPressed: () {
                      String newHabitName = textcontroller.text;
                      context.read<HabitDatabase>().addHabit(newHabitName);
                      Navigator.of(context).pop();
                      textcontroller.clear();
                    },
                    child: Text('Save')),
                MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      textcontroller.clear();
                    },
                    child: Text('Cancel')),
              ],
            ));
  }

  void checkHabitOnOff(bool? value, Habit habit) {
    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
    }
  }

  void editHabitBox(Habit habit) {
    textcontroller.text = habit.name;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textcontroller,
              ),
              actions: [
                MaterialButton(
                    onPressed: () {
                      String newHabitName = textcontroller.text;
                      context
                          .read<HabitDatabase>()
                          .updateHabitName(habit.id, newHabitName);
                      Navigator.of(context).pop();
                      textcontroller.clear();
                    },
                    child: Text('Save')),
                MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      textcontroller.clear();
                    },
                    child: Text('Cancel')),
              ],
            ));
  }

  void deleteHabit(Habit habit) {
    textcontroller.text = habit.name;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Are you sure you want to delete?'),
              actions: [
                MaterialButton(
                    onPressed: () {
                      context.read<HabitDatabase>().deleteHabit(habit.id);
                      Navigator.of(context).pop();
                    },
                    child: Text('Delete')),
                MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel')),
              ],
            ));
  }

  @override
  void initState() {
    Provider.of<HabitDatabase>(context, listen: false).readHabits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('HomeView'),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: Icon(Icons.add),
      ),
      // body: 
      // ListView(
      //   children: [
      //     MyHeatMap(startDate: , datasets: )
      //   ],
      // ),
    );
  }

  Widget buildHabitList() {
    final habitDatabase = context.watch<HabitDatabase>();
    List<Habit> currentHabits = habitDatabase.currentHabits;
    return ListView.builder(
      itemCount: currentHabits.length,
      itemBuilder: (context, index) {
        final habit = currentHabits[index];
        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);
        return MyHabitTile(
            text: habit.name,
            isCompleted: isCompletedToday,
            onChanged: (value) {
              checkHabitOnOff(value, habit);
            },
            editHabit: (context) => editHabitBox(habit),
            deleteHabit: (context) => deleteHabit(habit));
      },
    );
  }
}
