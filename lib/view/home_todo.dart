import 'package:flutter/material.dart';
import 'package:todoapp/model/to_do_modal.dart';
import 'package:todoapp/res/common/button.dart';
import 'package:todoapp/res/constant/app_strings.dart';
import 'package:todoapp/res/constant/colors.dart';

import 'to_do_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ToDoModel> toDoList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Center(
          child:
              Text(AppStings.homeScreen, style: TextStyle(color: Colors.pink)),
        ),
        backgroundColor: Colors.pink.shade50,
        elevation: 0,
      ),
      body: toDoList.isEmpty
          ? Center(
              child: Text(
                "No Data Found",
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.textColor,
                ),
              ),
            )
          : ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: toDoList.length,
              itemBuilder: (context, index) => Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title: ${toDoList[index].title}",
                      style: const TextStyle(
                          color: AppColors.Colortext,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "description:${toDoList[index].des!}",
                      style: const TextStyle(
                          color: AppColors.Colortext,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "date:${toDoList[index].date!}",
                      style: const TextStyle(
                          color: AppColors.textHintColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Time:${toDoList[index].time!}",
                      style: const TextStyle(
                          color: AppColors.textHintColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            dynamic data = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddToDoScreen(
                                  toDoList: toDoList,
                                  index: index,
                                ),
                              ),
                            );
                            if (data != null) {
                              debugPrint("Data--->$data");
                              toDoList = data;
                              setState(() {});
                            }
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            toDoList.removeAt(index);
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          dynamic data = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddToDoScreen(
                toDoList: toDoList,
              ),
            ),
          );

          if (data != null) {
            debugPrint("Data --> $data");
            toDoList = data;
            setState(() {});
          }
        },
        child: const AppButton(
          title: AppStings.addToDo,
        ),
      ),
    );
  }
}
