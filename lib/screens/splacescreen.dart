import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noidaone/resources/assets_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Controllers/appversionrepo.dart';
import '../Helpers/customdialog.dart';
import '../resources/values_manager.dart';
import 'loginScreen_2.dart';
import 'loginscreen.dart';



class Splace extends StatefulWidget {
  const Splace({super.key});

  @override
  State<Splace> createState() => _SplaceState();
}

class _SplaceState extends State<Splace> {

  bool ActiveConnection = false;
  String T = "";
  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          T = "Turn off the data and repress again";
          versionAliCall();
          //displayToast(T);
        });
      }
    } on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
        T = "Turn On the data and repress again";
        displayToast(T);
      });
    }
  }

  String? _appVersion ;

  // get app Version
  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
      print('----31-----$_appVersion');
    });
   // print('----32--$_appVersion');
  }
  //url
  void _launchGooglePlayStore() async {
    const url = 'https://play.google.com/store/apps/details?id=com.instagram.android&hl=en_IN&gl=US'; // Replace <YOUR_APP_ID> with your app's package name
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //
  void displayToast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    CheckUserConnection();
    _getAppVersion();
   // versionAliCall();

    super.initState();
  }
  versionAliCall() async{
    /// TODO HERE YOU SHOULD CHANGE APP VERSION FLUTTER VERSION MIN 3 DIGIT SUCH AS 1.0.0
    /// HERE YOU PASS variable _appVersion
    var loginMap = await AppVersionRepo().appversion(context,'6');
    var result = "${loginMap['Result']}";
    var msg = "${loginMap['Msg']}";
    print('---73--$result');
    print('---74--$msg');
    if(result=="1"){
      // Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) =>
      //                     const LoginScreen_2()));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen_2()),
      );
     // displayToast(msg);
    }else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('New Version Available'),
            content: Text('Download the latest version of the app from the Play Store.'),
            actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      _launchGooglePlayStore(); // Close the dialog
                    },
                    child: Text('Downlode'),
                  ),

            ],
          );
        },
      );
      displayToast(msg);
      print('----F---');
    }

    //print('----42---$result');
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplaceScreen(),
    );
  }
}

class SplaceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: AppSize.s50),
            // Top bar with two images
            SizedBox(
              height: AppSize.s75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                     margin: const EdgeInsets.all(AppSize.s10),
                     decoration: const BoxDecoration(
                       image: DecorationImage(
                         image: AssetImage(ImageAssets.roundcircle), // Replace with your image asset path
                         fit: BoxFit.cover,
                       ),
                     ),
                     width: AppSize.s50,
                     height: AppSize.s50,
                     child: Image.asset(ImageAssets.noidaauthoritylogo, // Replace with your image asset path
                       width: AppSize.s50,
                       height: AppSize.s50,
                     ),
                   ),
                  Padding(
                    padding: const EdgeInsets.only(right: AppSize.s10),
                    child: Container(
                       margin: EdgeInsets.all(AppSize.s10),
                       child: Image.asset(
                         ImageAssets.favicon,
                         width: AppSize.s50,
                         height: AppSize.s50,
                         fit: BoxFit.cover,
                       ),
                     ),
                  ),
                ],
              ),
            ),
            // Centered image
            Expanded(
              child: Center(
                child: Container(
                  height: AppSize.s160,
                  width: AppSize.s160,
                  margin: EdgeInsets.all(AppMargin.m20),//20
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageAssets.roundcircle,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    child: Image.asset(
                      ImageAssets.loginIcon, // Replace with your image asset path
                      width: AppSize.s160,
                      height: AppSize.s160,
                      fit: BoxFit.contain, // Adjust as needed
                    ),
                  ),
                ),
              ),
              ),
          ],
        ),
      ),
    );
  }

}