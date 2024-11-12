
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_app/Contsants/widgets.dart';
import 'package:todo_app/viewModel/tasks_viewModel.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: const Icon(
          Icons.check_circle,
          color: Colors.white,
          size: 40,
        ),
        title: const Text(
          "Todo List",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Consumer<TaskViewModel>(
        builder: (context,taskProvider,_){
          return ListView.separated(
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];
              return TaskWidget(task: task, onpressed: () {
                taskProvider.deleteTask(index);
              },);
            },
            separatorBuilder: (context, index) {
              return const Divider(
                thickness: 2,
              );
            },
            itemCount: taskProvider.tasks.length);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                double height = MediaQuery.of(context).size.height;
                double width = MediaQuery.of(context).size.width;
                final taskProvider = Provider.of<TaskViewModel>(context);
                return Dialog(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: SizedBox(
                    height: height * 0.5,
                    width: width * 0.8,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * .05, vertical: height * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Create A New Task",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "What Has To Be Done?",
                            style: TextStyle(color: Colors.white),
                          ),
                          CustomTextField(
                              onChanged: (value) {
                                taskProvider.setTaskName(value);
                              },
                              hint: 'Enter a Task'),
                          const SizedBox(height: 50),
                          const Text(
                            "Due Date",
                            style: TextStyle(color: Colors.white),
                          ),
                          CustomTextField(
                            onTap: () async {
                              DateTime? date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2015),
                                  lastDate: DateTime(2030));
                             //  final f = DateFormat('yyyy-MM-dd hh:mm');
                             // var fDate= f.format(date!);
                              taskProvider.setDate(date);
                            },
                            readOnly: true,
                            hint: "Enter a Date",
                            icon: Icons.calendar_month,
                            controller: taskProvider.dateController,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            onTap: () async {
                              TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              taskProvider.setTime(time);
                            },
                            readOnly: true,
                            hint: "Enter a Time",
                            icon: Icons.timer,
                            controller: taskProvider.timeController,
                          ),
                          const SizedBox(height: 30),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: Colors.white),
                                onPressed: () async{
                                  await taskProvider.addTask();
                                    if(context.mounted){
                                      Navigator.pop(context);
                                    }
                                },
                                child: const Text(
                                  "Create",
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
