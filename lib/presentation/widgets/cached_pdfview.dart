import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:maharashtra_board_books/data/core/api_constants.dart';
import 'package:maharashtra_board_books/presentation/widgets/AppbarMenu.dart';

import 'lottie_loading.dart';

class CachedPdfView extends StatefulWidget {
  final String pdfUrl;
  final String pdfName;

  const CachedPdfView({
    Key? key,
    required this.pdfUrl,
    required this.pdfName,
  }) : super(key: key);

  @override
  State<CachedPdfView> createState() => _CachedPdfViewState();
}

class _CachedPdfViewState extends State<CachedPdfView> {
  @override
  void initState() {
    super.initState();
    getAds();
  }

  void getAds() async {
    try{
      InterstitialAd? _interstitialAd;
      InterstitialAd.load(
        adUnitId: ApiConstants.liveUnitIds,
        request: ApiConstants.adMobRequest,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            //print('$ad loaded');
            _interstitialAd = ad;
            _interstitialAd!.setImmersiveMode(true);

            if (_interstitialAd != null) {
              _interstitialAd!.show();
              _interstitialAd = null;
            }
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');

          },
        ),
      );

      setState(() {});
    } catch(error){
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMenu(context, widget.pdfName, (isNightModeOn){}),
      //backgroundColor: Colors.white,
      body: PDF(
        fitPolicy : FitPolicy.BOTH,
        autoSpacing: false,
        pageFling: false,
        onError: (error) {
          print(error.toString());
        },
        onPageError: (page, error) {
          print('$page: ${error.toString()}');
        },

      ).cachedFromUrl(
        widget.pdfUrl,
        //placeholder: (progress) => Center(child: Text('$progress %')),
        placeholder: (progress) => const LottieLoading(),
        errorWidget: (error) => const Padding(
          padding: EdgeInsets.only(bottom: 50, top: 5),
          child: Center(
            child: Text('No data found',
              style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.normal, wordSpacing: 0),
            ),
          ),
        ),
      ),
    );
  }
}
