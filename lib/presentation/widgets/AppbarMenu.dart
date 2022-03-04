import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maharashtra_board_books/presentation/themes/theme_color.dart';

PreferredSizeWidget appBarMenu (BuildContext context, String text, Function(bool isNightModeOn) onNightMode){
  return AppBar(
    centerTitle: false,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    title: Text(
      text, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
    ),
    backgroundColor: AppColor.primaryColor,
    leading: GestureDetector(
      child: const Icon(
        Icons.arrow_back_ios_rounded,
        color: Colors.white,
        size: 22,
      ),
      onTap: (){
        Navigator.pop(context);
      },
    ),

   /* actions: <Widget>[
      PopupMenuButton(
        color: Colors.white,
        onSelected: (value){
          switch (value) {
            case 'Night Mode':
              onNightMode(true);
              break;
            case 'Day Mode':
              onNightMode(false);
              break;
          }
        },
        itemBuilder: (BuildContext itemBuilder) => {'Night Mode', 'Day Mode'}.map((value) =>
            PopupMenuItem(child: Text(value), value: value, textStyle: const TextStyle(color: Colors.black),)).toList()),
    ],*/
  );
}