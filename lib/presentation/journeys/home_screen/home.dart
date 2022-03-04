import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:maharashtra_board_books/common/constants/strings.dart';
import 'package:maharashtra_board_books/common/extensions/common_fun.dart';
import 'package:maharashtra_board_books/data/core/api_constants.dart';
import 'package:maharashtra_board_books/data/data_sources/api_functions.dart';
import 'package:maharashtra_board_books/data/models/SubjectsApiResModel.dart';
import 'package:maharashtra_board_books/presentation/journeys/home_screen/board_screen.dart';
import 'package:maharashtra_board_books/presentation/widgets/app_bar_home.dart';
import 'package:maharashtra_board_books/presentation/widgets/drawer.dart';
import 'package:maharashtra_board_books/presentation/widgets/lottie_loading.dart';

import 'home_list_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Home> {
  late Future<bool> _future;
  late bool isApiDataAvailable = false;
  SubjectsApiResModel model = SubjectsApiResModel();

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
      await ApiFun.apiGetWithParams(ApiConstants.getAllSubjects, deviceId).then((jsonDecodeData) => {
        model = SubjectsApiResModel.fromJson(jsonDecodeData),
      });

      if(model.status == 1) {
        isApiDataAvailable = true;
      }
    } catch(error){
      print("Error: $error");
    }
    return isApiDataAvailable;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context, Strings.appName),
      drawer: const NavigationDrawer(),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: _future,
        builder: (context, snapShot){
          if(snapShot.hasData && snapShot.connectionState == ConnectionState.done){
            if(isApiDataAvailable){
              return SlideInUp(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12, top: 8),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: model.response?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HomeListWidget(
                          response: model.response!,
                          index: index,
                          onTapOnList: () {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => BoardScreen( title: model.response![index].categoryName!, boardList: model.response![index].boardWiseSubjects!, homeIndex: index,)),
                            );
                          },
                        );
                      }),
                ),
              );
            }
            else { return const Padding(
              padding: EdgeInsets.only(bottom: 50, top: 5),
              child: Center(
                child: Text('No data found',
                  style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.normal, wordSpacing: 0),
                ),
              ),
            );}
          } else {
            return const LottieLoading();
          }
        },
      ),
    );
  }
}
