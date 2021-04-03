import 'package:flutter/material.dart';
import 'package:todo_bro/widgets/text_field/outline_text_field.dart';

class TODOScreen extends StatefulWidget {
  createState() => _TODOScreenState();
}

class _TODOScreenState extends State<TODOScreen> {
  List<Map<String, dynamic>> todos = [];
  TextEditingController _todoInputTextController = new TextEditingController();
  AppBar _appBar() {
    return AppBar(title: Text("TODO Bro"));
  }

  @override
  void initState() {
    todos.add({
      "item": {"desc": "Add a TODO !", "time": "10:00 am", "date": "1/1/2021"}
    });
  }

  // Stores the selected day from the picker
  Map<String, int> contemporaryDateTime = new Map();
  Map<String, int> contemporaryTimeOfDay = new Map();
  String _selectedDate = "";
  String _selectedTime = "";

  Future<void> _showInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Create TODO'),
            content: StatefulBuilder(
              builder: (context, setState) => SingleChildScrollView(
                child: ListBody(
                  children: [
                    OutlineTextField(
                      textEditingController: _todoInputTextController,
                      hintText: "Enter TODO",
                    ),
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 10, left: 5),
                            child: Text(
                              _selectedDate == ""
                                  ? "No Date Selected,"
                                  : _selectedDate + " at ",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 10, left: 5),
                            child: Text(
                              _selectedTime == ""
                                  ? "No Time Selected"
                                  : _selectedTime,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                            child: Text("Pick Day"),
                            onPressed: () async {
                              DateTime dt = await showDatePicker(
                                  context: context,
                                  initialDate: contemporaryDateTime.isEmpty
                                      ? DateTime.now()
                                      : DateTime(
                                          contemporaryDateTime['year'],
                                          contemporaryDateTime['month'],
                                          contemporaryDateTime['day']),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2030));

                              contemporaryDateTime["day"] = dt.day;
                              contemporaryDateTime["month"] = dt.month;
                              contemporaryDateTime["year"] = dt.year;

                              setState(() {
                                _selectedDate =
                                    '${dt.day}/${dt.month}/${dt.year}';
                                print(_selectedDate);
                              });
                            }),
                        TextButton(
                            child: Text("Pick Time"),
                            onPressed: () async {
                              TimeOfDay tof = await showTimePicker(
                                  context: context,
                                  initialTime: contemporaryTimeOfDay.isEmpty
                                      ? TimeOfDay.now()
                                      : TimeOfDay(
                                          hour: contemporaryTimeOfDay['hour'],
                                          minute:
                                              contemporaryTimeOfDay['minute']));
                              contemporaryTimeOfDay['hour'] = tof.hour;
                              contemporaryTimeOfDay['minute'] = tof.minute;
                              setState(() {
                                _selectedTime =
                                    "${tof.hourOfPeriod}:${tof.minute} ${tof.period.index == 0 ? 'am' : 'pm'}";
                              });
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Save'),
                onPressed: () {
                  setState(() {
                    todos.add({
                      "item": {
                        "desc": _todoInputTextController.text,
                        "time": _selectedTime,
                        "date": _selectedDate
                      }
                    });
                  });

                  _selectedDate = "";
                  _selectedTime = "";
                  contemporaryDateTime.clear(); // remove the contempoary data
                  contemporaryTimeOfDay.clear();
                  _todoInputTextController.text = "";
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int pos) {
              Map<String, dynamic> item = todos[pos];
              return todoItem(context, item['item']['desc'],
                  item['item']['time'], item['item']['date'], pos);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          icon: Icon(Icons.add),
        ),
        onPressed: () {
          _showInputDialog(context);
        },
      ),
    );
  }

  Map<int, bool> itemsChecked = new Map();
  bool checked = false;

  Widget todoItem(
      BuildContext context, String description, time, date, int position) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(10),
      child: Center(
        child: CheckboxListTile(
          title: Text(description),
          subtitle: Text("${date} @ ${time}"),
          value: itemsChecked.containsKey(position)
              ? itemsChecked[position]
              : false,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (bool val) {
            if (itemsChecked.containsKey(position)) {
              // if item is found update item
              setState(() {
                checked = itemsChecked[position];
                checked = !checked;
                itemsChecked.update(position, (value) => checked);

                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    setState(() {
                      todos.removeAt(position);
                    });
                  });
                });
              });
            } else {
              setState(() {
                // if not found remove
                itemsChecked.putIfAbsent(position, () => true);
                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    setState(() {
                      todos.removeAt(position);
                    });
                  });
                });
              });
            }
          },
        ),
      ),
    );
  }
}
