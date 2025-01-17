import 'package:get/get.dart';
import 'package:flutter/material.dart';



 showbottomsheet(){
   Get.bottomSheet(

       Container(
         decoration: BoxDecoration(
             color: Colors.grey,
             borderRadius: BorderRadius.circular(20)
         ),
         child: Column(
           children: [
             ListTile(
               title:Text('Light theme'),
               leading: Icon(Icons.light_mode),
               onTap: (){
                 Get.changeTheme(ThemeData.light());

               },
             ),
             ListTile(
               title:Text('Dark theme'),
               leading: Icon(Icons.dark_mode),
               onTap: (){
                 Get.changeTheme(ThemeData.dark());

               },
             ),

           ],
         ),
       )
   );}


class Utils {

}