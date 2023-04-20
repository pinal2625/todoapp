import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/model/to_do_modal.dart';
import 'package:todoapp/res/common/Container.dart';
import 'package:todoapp/res/common/button.dart';
import 'package:todoapp/res/constant/app_strings.dart';
import '../res/common/textfield.dart';

class AddToDoScreen extends StatefulWidget {
  final List<ToDoModel>? toDoList;
  final int? index;
  const AddToDoScreen({
    Key? key,
    this.toDoList,
    this.index,
  }) : super(key: key);

  @override
  State<AddToDoScreen> createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  bool? dateIsSelect = false;
  TimeOfDay selectedTime = TimeOfDay.now();
  bool? timeIsSelect = false;
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    debugPrint("picked ---->> $selectedDate");
    debugPrint("picked ---->> $picked");

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateIsSelect = true;
      setState(() {});
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    debugPrint("picked ---->> $selectedTime");
    debugPrint("picked ---->> $picked");

    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      timeIsSelect = true;
      setState(() {});
    }
  }

  List<ToDoModel> toDoList = [];
  @override
  void initState() {
    toDoList = widget.toDoList!;
    if (widget.index != null) {
      titleController.text = toDoList[widget.index!].title!;
      desController.text = toDoList[widget.index!].des!;
      selectedDate = DateFormat('d/M/y').parse(toDoList[widget.index!].date!);
      dateIsSelect = true;
      var hour =
          toDoList[widget.index!].time!.split(" ").first.split(":").first;
      var minute = toDoList[widget.index!].time!.split(" ").first.split(":")[1];
      selectedTime =
          TimeOfDay(hour: int.parse(hour), minute: int.parse(minute));
      timeIsSelect = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: Center(
            child:
                Text(AppStings.addToDo, style: TextStyle(color: Colors.pink))),
        backgroundColor: Colors.pink.shade50,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          children: [
            Image(
              image: AssetImage("assets/images/image_1.png"),
            ),
            Column(
              children: [
                AppTextField(
                  controller: titleController,
                  hintText: AppStings.enterTitle,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => selectDate(context),
                      child: AppContainer(
                        icon: Icons.date_range,
                        hintText: dateIsSelect!
                            ? DateFormat.yMd().format(selectedDate)
                            : "Select Date",
                        isData: dateIsSelect!,
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () => selectTime(context),
                      child: AppContainer(
                        icon: Icons.timelapse,
                        hintText: timeIsSelect!
                            ? selectedTime.format(context)
                            : "Select Time",
                        isData: timeIsSelect!,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                AppTextField(
                  controller: desController,
                  hintText: AppStings.enterDescription,
                  isDes: true,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    if (widget.index != null) {
                      toDoList[widget.index!] = ToDoModel(
                        title: titleController.text,
                        date: DateFormat.yMd().format(selectedDate),
                        time: selectedTime.format(context),
                        des: desController.text,
                      );
                    } else {
                      toDoList.add(
                        ToDoModel(
                          title: titleController.text,
                          date: DateFormat.yMd().format(selectedDate),
                          time: selectedTime.format(context),
                          des: desController.text,
                        ),
                      );
                    }
                    Navigator.pop(context, toDoList);
                  },
                  child: const AppButton(
                    width: 180,
                    title: AppStings.addToDo,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
