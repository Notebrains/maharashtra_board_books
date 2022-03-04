
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:maharashtra_board_books/common/constants/RandomColorHelper.dart';
import 'package:maharashtra_board_books/data/core/api_constants.dart';
import 'package:maharashtra_board_books/data/models/SubjectsApiResModel.dart';
import 'package:maharashtra_board_books/presentation/widgets/appbar_ic_back.dart';
import 'package:maharashtra_board_books/presentation/widgets/lottie_loading.dart';
import 'package:maharashtra_board_books/presentation/widgets/txt.dart';

import 'subjects.dart';



class BoardScreen extends StatefulWidget {
  final int homeIndex;
  final String title;
  final List<BoardWiseSubjects> boardList;

  const BoardScreen({Key? key, required this.homeIndex,  required this.title, required this.boardList}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<BoardScreen> {
  late Future<bool> _future;
  late bool isApiDataAvailable = true;

  @override
  void initState() {
    super.initState();
    _future = getDataFromApi();
  }


  Future<bool> getDataFromApi() async {
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
    } catch(error){
      print("Error: $error");
    }
    return isApiDataAvailable;
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
          if(widget.boardList.isNotEmpty){
            if(isApiDataAvailable){
              return SlideInUp(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 24, top: 8),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.boardList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                            decoration: BoxDecoration(color: Colors.grey.shade100,
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
                                          blurRadius: 3,
                                          spreadRadius: 3,
                                        ),
                                      ],
                                    ),

                                    child: Center(
                                      child: Txt(
                                        txt: widget.boardList[index].boardName?[0] ?? '*',
                                        txtColor: Colors.white,
                                        txtSize: 14,
                                        fontWeight: FontWeight.bold,
                                        padding: 5,
                                      ),
                                    ),
                                  ),),

                                Expanded(
                                  flex: 3,
                                  child: Txt(
                                    txt: widget.boardList[index].boardName!,
                                    txtColor: Colors.black,
                                    txtSize: 14,
                                    fontWeight: FontWeight.bold,
                                    padding: 5,
                                  ),
                                ),


                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration:  BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade200,
                                          blurRadius: 1,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),

                                    child: const Center(
                                      child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          onTap: (){
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => BoardSubject(indexHome: widget.homeIndex, indexBoard: index, title:widget.boardList[index].boardName!,)),
                            );
                          },
                        );
                      }),
                ),
              );
            } else{
              return const LottieLoading();
            }
            //else { return NoDataFound(txt: 'No data found', onRefresh: (){});}
          } else {return const Padding(
            padding: EdgeInsets.only(bottom: 50, top: 5),
            child: Center(
              child: Text('No data found',
                style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.normal, wordSpacing: 0),
              ),
            ),
          );
          }
        },
      ),
    );
  }
}

