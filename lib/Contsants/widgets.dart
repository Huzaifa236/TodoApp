


import 'package:flutter/material.dart';

import '../Models/task_model.dart';

class TaskWidget extends StatelessWidget {
  final Task task;
  final VoidCallback onpressed;
  const TaskWidget({
    super.key, required this.task, required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
      title:  Text(task.taskName,style: const TextStyle(color: Colors.white),),
      subtitle:  Text("${task.date}, ${task.time}",style: const TextStyle(color: Colors.white),),
      trailing: IconButton(onPressed: onpressed, icon: const Icon(Icons.delete),color: Colors.red,),
    );
  }
}


class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final void Function()? onTap;
  final bool readOnly;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  const CustomTextField({
    super.key, required this.hint, this.icon, this.onTap, this.readOnly=false, this.onChanged, this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: TextFormField(
        controller: controller ,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white),
         readOnly: readOnly,
         decoration:  InputDecoration(
          suffixIcon: GestureDetector(
              onTap: onTap,
              child: Icon(icon,color: Colors.white,)),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.white
          )
        ),
      ),
    );
  }
}



