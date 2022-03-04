import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:maharashtra_board_books/common/extensions/common_fun.dart';
import 'package:maharashtra_board_books/data/core/api_constants.dart';
import 'package:maharashtra_board_books/data/data_sources/api_functions.dart';
import 'package:maharashtra_board_books/data/models/status_message_api_res_model.dart';
import 'package:maharashtra_board_books/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:maharashtra_board_books/presentation/widgets/appbar_ic_back.dart';
import 'package:maharashtra_board_books/presentation/widgets/button.dart';
import 'package:maharashtra_board_books/presentation/widgets/cached_pdfview.dart';


class ViewSubjects extends StatefulWidget {
  final String subjectId;
  final String title;
  final String bookPdf;

  const ViewSubjects({Key? key, required this.subjectId, required this.title, required this.bookPdf}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<ViewSubjects> {
  late bool isPdfDownloaded = false;
  late bool isPdfDownloading = false;

  static const _insets = 16.0;
  AdManagerBannerAd? _inlineAdaptiveAd;
  bool _isLoaded = false;
  AdSize? _adSize;
  late Orientation _currentOrientation;

  double get _adWidth => MediaQuery.of(context).size.width - (2 * _insets);


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentOrientation = MediaQuery.of(context).orientation;
    _loadAd();
  }

  void _loadAd() async {
    await _inlineAdaptiveAd?.dispose();
    setState(() {
      _inlineAdaptiveAd = null;
      _isLoaded = false;
    });

    // Get an inline adaptive size for the current orientation.
    AdSize size = AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize(
        _adWidth.truncate());

    _inlineAdaptiveAd = AdManagerBannerAd(
      adUnitId: ApiConstants.liveAppId,
      sizes: [size],
      request: const AdManagerAdRequest(),
      listener: AdManagerBannerAdListener(
        onAdLoaded: (Ad ad) async {
          print('Inline adaptive banner loaded: ${ad.responseInfo}');

          // After the ad is loaded, get the platform ad size and use it to
          // update the height of the container. This is necessary because the
          // height can change after the ad is loaded.
          AdManagerBannerAd bannerAd = (ad as AdManagerBannerAd);
          final AdSize? size = await bannerAd.getPlatformAdSize();
          if (size == null) {
            print('Error: getPlatformAdSize() returned null for $bannerAd');
            return;
          }

          setState(() {
            _inlineAdaptiveAd = bannerAd;
            _isLoaded = true;
            _adSize = size;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Inline adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    await _inlineAdaptiveAd!.load();
  }

  /// Gets a widget containing the ad, if one is loaded.
  ///
  /// Returns an empty container if no ad is loaded, or the orientation
  /// has changed. Also loads a new ad if the orientation changes.
  Widget _getAdWidget() {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (_currentOrientation == orientation &&
            _inlineAdaptiveAd != null &&
            _isLoaded &&
            _adSize != null) {
          return Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: _adWidth,
                height: _adSize!.height.toDouble(),
                child: AdWidget(
                  ad: _inlineAdaptiveAd!,
                ),
              ));
        }
        // Reload the ad if the orientation changes.
        if (_currentOrientation != orientation) {
          _currentOrientation = orientation;
          _loadAd();
        }
        return Container();
      },
    );
  }


  @override
  void dispose() {
    super.dispose();
    _inlineAdaptiveAd?.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, widget.title),
      backgroundColor: Colors.white,
      body: SlideInUp(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Button(text: isPdfDownloaded? 'Open File' : 'Download', onPressed: (){
                  if (isPdfDownloaded) {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                          CachedPdfView(
                            pdfUrl: widget.bookPdf,
                            pdfName: widget.title,
                          ),
                      ),
                    );
                  } else {
                    setState(() {
                      isPdfDownloading = true;
                    });
                  }

                }),
              ),

              _getAdWidget(),

              SizedBox(
                height: 300,
                child: Visibility(
                  visible: isPdfDownloading && !isPdfDownloaded,
                  child: const PDF(
                    fitPolicy : FitPolicy.BOTH,
                    autoSpacing: false,
                    pageFling: false,
                  ).cachedFromUrl(
                    widget.bookPdf,
                    placeholder: (progress) {
                      //progress == 100?  isPdfDownloaded = true:  isPdfDownloaded = false;
                      updateList(widget.subjectId);
                      if (progress == 100) {
                        isPdfDownloaded = true;
                        isPdfDownloading = false;
                      } else {
                        WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {
                          isPdfDownloaded = false;
                        }));
                      }
                      return Center(child: Text('$progress %\nDownloading...', textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal, wordSpacing: 0),));
                    },

                    //placeholder: (progress) => const LottieLoading(),
                    //errorWidget: (error) => const Center(child: Text('Failed to download pdf file. Please try again', style: TextStyle(color: Colors.black),)),
                    // errorWidget: (error) => const Center(child: Text('', style: TextStyle(color: Colors.black),)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  void updateList(String subjectId) async {
    try{
      String deviceId = await getId();
      Map<String, dynamic> body = {};
      body["device_id"] = deviceId;
      body["subject_id"] = subjectId;

      await ApiFun.apiPostWithBody(ApiConstants.addSubjects, body).then((jsonDecodeData) {
        StatusMessageApiResModel model = StatusMessageApiResModel.fromJson(jsonDecodeData);
        edgeAlert(context, title: 'Message', description: model.message!);
        if(model.status == 1) {
          setState(() {
            isPdfDownloaded = true;
          });
        }
      });
    } catch(error){
      print("Error: $error");
    }
  }
}

