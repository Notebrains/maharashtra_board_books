
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maharashtra_board_books/common/constants/route_constants.dart';
import 'package:maharashtra_board_books/common/extensions/common_fun.dart';
import 'package:maharashtra_board_books/presentation/themes/theme_color.dart';

PreferredSizeWidget appBarHome(BuildContext context, String title) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    backgroundColor: AppColor.primaryColor,
    elevation: 0.5,
    toolbarHeight: 60,
    leadingWidth: 56,
    systemOverlayStyle: SystemUiOverlayStyle.light,

    actions: <Widget>[
      IconButton(
        icon: const Icon(
          Icons.star,
          color: Colors.white,
        ),
        onPressed: () {
          doLaunchUrl('https://play.google.com/store/apps/details?id=com.board.maharashtra.books');
        },
      ),
    ],
  );
}
