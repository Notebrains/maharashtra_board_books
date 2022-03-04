import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class ApiConstants {
  ApiConstants._();

  static const String BASE_URL = "https://teracotta.in/demo/projects/books_management/webservices/";

  static const String getAllSubjects = "get_all_subjects";
  static const String addSubjects = "store_pdf";
  static const String deleteSubjects = "delete_pdf";



  //Sample AdMob app ID: ca-app-pub-3940256099942544~3347511713
  static const String testDevice = 'ca-app-pub-3940256099942544~3347511713';
  static const String liveAppId = 'ca-app-pub-4879097646007209~5472441070';
  static const String liveUnitId = 'ca-app-pub-4879097646007209/2560827960';

  static const String testUnitIdAndroid = 'ca-app-pub-3940256099942544/1033173712';
  static const String testUnitIdIos = 'ca-app-pub-3940256099942544/4411468910';


  static  String testUnitId = Platform.isAndroid ? ApiConstants.testUnitIdAndroid : ApiConstants.testUnitIdIos;
  static  String liveUnitIds = Platform.isAndroid ? ApiConstants.liveUnitId : ApiConstants.liveUnitId;


  static const int maxFailedLoadAttempts = 3;

  static const AdRequest adMobRequest = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
}
