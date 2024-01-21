// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHabitTile extends StatefulWidget {
  final String text;
  final bool isCompleted;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? editHabit;
  final void Function(BuildContext)? deleteHabit;
  const MyHabitTile({
    super.key,
    required this.text,
    required this.isCompleted,
    required this.onChanged,
    required this.editHabit,
    required this.deleteHabit,
  });

  @override
  State<MyHabitTile> createState() => _MyHabitTileState();
}

class _MyHabitTileState extends State<MyHabitTile> {
  bool _isCompleted = false;

  @override
  void initState() {
    _isCompleted = widget.isCompleted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            backgroundColor: Colors.grey.shade800,
            onPressed: widget.editHabit,
            icon: Icons.settings,
            borderRadius: BorderRadius.circular(8),
          ),
          SlidableAction(
            backgroundColor: Colors.red,
            onPressed: widget.deleteHabit,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(8),
          )
        ]),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isCompleted = !_isCompleted;
            });
            widget.onChanged?.call(_isCompleted);
          },
          child: Container(
              decoration: BoxDecoration(
                color: _isCompleted
                    ? Colors.green
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(12),
              child: ListTile(
                  title: Text(widget.text,
                      style: TextStyle(
                          color: widget.isCompleted
                              ? Colors.white
                              : Theme.of(context).colorScheme.inversePrimary)),
                  leading: Checkbox(
                     activeColor: Colors.green,
                      value: _isCompleted,
                      onChanged: widget.onChanged))),
        ),
      ),
    );
  }
}
