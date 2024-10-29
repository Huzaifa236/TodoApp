




import 'dart:developer';

import 'package:flutter/material.dart';

import '../Models/task_model.dart';

class TaskViewModel extends ChangeNotifier{
    List<Task> tasks= [];
   String? taskName;

   final dateController = TextEditingController();
   final timeController = TextEditingController();

   bool get isValid => taskName != null &&dateController.text == "" &&timeController.text =="";
   setTaskName (String? value){
     taskName = value;
     log(value.toString());
     notifyListeners();
   }

   setDate(DateTime? date){
     if(date == null){
       return;
     }
     log(date.toString());
   DateTime currentDate = DateTime.now();
   DateTime now = DateTime(currentDate.year,currentDate.microsecond,currentDate.day);
   int diff= date.difference(now).inDays;
    if(diff ==0){
      dateController.text = 'Today';
    }else if(diff == 1){
      dateController.text = 'Tomorrow';
    }else{
      dateController.text = "${date.day}-${date.month}-${date.year}";
    }
    notifyListeners();
   }
   setTime(TimeOfDay? time){
     if(time ==null){
       return;
     }
     if(time.hour ==0){
       timeController.text= "12:${time.minute} AM";
     }else if(time.hour <12){
       timeController.text= "${time.hour}:${time.minute} AM";
     }else if(time.hour ==12){
       timeController.text= "${time.hour}:${time.minute} PM";
     }else{
       timeController.text= "${time.hour-12}:${time.minute} PM";
     }

     log(time.toString());
     notifyListeners();
   }
   addTask(){
     // if(!isValid){
     //   return;
     // }
     final task = Task(taskName!, dateController.text, timeController.text);
     tasks.add(task);
     dateController.clear();
     timeController.clear();
     log(tasks.length.toString());
     notifyListeners();

   }



}