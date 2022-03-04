import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:maharashtra_board_books/data/core/api_constants.dart';

import 'appbar_ic_back.dart';
import 'lottie_loading.dart';

class AssetPdfView extends StatefulWidget {

  const AssetPdfView({
    Key? key,
  }) : super(key: key);

  @override
  State<AssetPdfView> createState() => _AssetPdfViewState();
}

class _AssetPdfViewState extends State<AssetPdfView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarIcBack(context, 'Privacy Policy'),
        backgroundColor: Colors.white,
        body: const PDF(
          //fitPolicy : FitPolicy.HEIGHT,
          autoSpacing: false,
          pageFling: false,
        ).fromAsset('assets/images/Privacy_Policy_Maharashtra.pdf',
          //placeholder: (progress) => Center(child: Text('$progress %')),
          errorWidget: (error) => const Padding(
            padding: EdgeInsets.only(bottom: 50, top: 5),
            child: Center(
              child: Text('No data found',
                style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.normal, wordSpacing: 0),
              ),
            ),
          ),
        )
    );
  }
}
