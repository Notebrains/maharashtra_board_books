import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:maharashtra_board_books/common/constants/strings.dart';

Widget cachedNetImgWithCustomRadius(String url, double width, double height, double radius, BoxFit boxFit) => ClipRRect(
  borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
  child: CachedNetworkImage(
    height: height,
    width: width,
    fit: boxFit,
    //placeholder: (context, url) => CircularProgressIndicator(),
    imageUrl: url,
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        Center(child: Lottie.asset('assets/animations/lottiefiles/3_line_loading.json', fit: BoxFit.cover, width: 300, height: 250),),
    errorWidget: (context, url, error) => Image.network(Strings.imgUrlNotFound),
  ),
);
