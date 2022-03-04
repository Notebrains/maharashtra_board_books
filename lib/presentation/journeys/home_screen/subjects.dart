import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:maharashtra_board_books/common/constants/RandomColorHelper.dart';
import 'package:maharashtra_board_books/common/extensions/common_fun.dart';
import 'package:maharashtra_board_books/data/core/api_constants.dart';
import 'package:maharashtra_board_books/data/data_sources/api_functions.dart';
import 'package:maharashtra_board_books/data/models/SubjectsApiResModel.dart';
import 'package:maharashtra_board_books/data/models/status_message_api_res_model.dart';
import 'package:maharashtra_board_books/presentation/journeys/home_screen/ViewSubject.dart';
import 'package:maharashtra_board_books/presentation/widgets/appbar_ic_back.dart';
import 'package:maharashtra_board_books/presentation/widgets/cached_pdfview.dart';
import 'package:maharashtra_board_books/presentation/widgets/lottie_loading.dart';
import 'package:maharashtra_board_books/presentation/widgets/txt.dart';


class BoardSubject extends StatefulWidget {
  final String title;
  final int indexHome;
  final int indexBoard;

  const BoardSubject({Key? key, required this.title, required this.indexHome, required this.indexBoard}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<BoardSubject> {
  late Future<bool> _future;
  late bool isApiDataAvailable = true;
  SubjectsApiResModel model = SubjectsApiResModel();
  List<Subjects> subjectList = [];

  @override
  void initState() {
    super.initState();

    _future = getDataFromApi();
  }

  Future<bool> getDataFromApi() async {
    try{
      String deviceId = await getId();
      if (kDebugMode) {
        print('---- deviceId: $deviceId');
      }
      await ApiFun.apiGetWithParams(ApiConstants.getAllSubjects, deviceId).then((jsonDecodeData) {
        model = SubjectsApiResModel.fromJson(jsonDecodeData);
        subjectList = model.response![widget.indexHome].boardWiseSubjects![widget.indexBoard].subjects!;
      });

      if(model.status == 1) {
        isApiDataAvailable = true;
        getAds();
      }
    } catch(error){
      print("Error: $error");
    }
    return isApiDataAvailable;
  }


  void getAds() async {
    try{
      InterstitialAd? _interstitialAd;
      InterstitialAd.load(
        adUnitId: ApiConstants.liveUnitIds,
        request: ApiConstants.adMobRequest,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
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

      setState(() {
        isApiDataAvailable = true;
      });
    } catch(error){
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBarIcBack(context, widget.title),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: _future,
        builder: (context, snapShot){
          if(isApiDataAvailable){
            if(subjectList.isNotEmpty){
              return SlideInUp(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 24, top: 8),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: subjectList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                            decoration: BoxDecoration(
                              color: subjectList[index].isDownload! == "Not Downloaded" ?  Colors.grey.shade100 : Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: RandomHexColor().colorRandom(),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 1,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),

                                    child: Center(
                                      child: Txt(
                                        txt: (index+ 1).toString(),
                                        txtColor: Colors.white,
                                        txtSize: 14,
                                        fontWeight: FontWeight.bold,
                                        padding: 5,
                                      ),
                                    ),
                                  ),
                                ),

                                Expanded(
                                  flex: 3,
                                  child: Txt(
                                    txt: subjectList[index].subjectName!,
                                    txtColor: Colors.black,
                                    txtSize: 14,
                                    fontWeight: FontWeight.bold,
                                    padding: 5,
                                  ),
                                ),


                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    child: Visibility(
                                      visible: subjectList[index].isDownload! == "Downloaded",
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),

                                        child: const Center(
                                          child: Icon(
                                            Icons.delete,
                                            size: 20,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),

                                    onTap: (){
                                      updateList(subjectList[index].subjectId!);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          onTap: () async {
                            if (subjectList[index].isDownload! == "Downloaded") {
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                  CachedPdfView(
                                    pdfUrl: subjectList[index].bookPdf!,
                                    pdfName: subjectList[index].subjectName!,
                                  ),
                                ),
                              );

                            } else {
                              await Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    ViewSubjects(
                                      subjectId: subjectList[index].subjectId!,
                                      //bookPdf: subjectList[index].bookPdf!,
                                      bookPdf: subjectList[index].bookPdf!,
                                      title: subjectList[index].subjectName!,),
                                ),
                              );

                              setState(() {
                                _future = getDataFromApi();
                              });
                            }
                          },
                        );
                      }),
                ),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.only(bottom: 50, top: 5),
                child: Center(
                  child: Text('No data found',
                    style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.normal, wordSpacing: 0),
                  ),
                ),
              );
            }
          } else {
            return const LottieLoading();
          }
        },
      ),
    );
  }


  Future<bool> updateList(String subjectId) async {
    showLoadingDialog(context);
    try{
      String deviceId = await getId();
      Map<String, dynamic> body = {};
      body["device_id"] = deviceId;
      body["subject_id"] = subjectId;

      await ApiFun.apiPostWithBody(ApiConstants.deleteSubjects, body).then((jsonDecodeData) {
        StatusMessageApiResModel model = StatusMessageApiResModel.fromJson(jsonDecodeData);
        if(model.message == "Your book has been removed") {
          setState(() {
            _future = getDataFromApi();
          });
        }
      });


    } catch(error){
      print("Error: $error");
    }
    return isApiDataAvailable;
  }
}
