// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:tut_application/model/state_list_model.dart';
//
// class StateRepo {
//   final baseUrl = "http://49.50.79.121:8080/jci-api/api/allState";
//   // var headers = {'API-Token': 'token'};
//
//   //Fetch Country Data
//   // Future<CountryDataModel?>
//  Future<StateList?> getStateList() async {
//     var client = http.Client();
//     final url = baseUrl;
//
//     try {
//       var response = await client.get(Uri.parse(url));
//       var jsonStr = jsonDecode(response.body);
//
//       debugPrint(response.body);
//       if (response.statusCode == 200) {
//         var json = response.body;
//         Map<String, dynamic> mapData = jsonDecode(json);
//         print("State List: ${StateList.fromJson(mapData)}");
//         return StateList.fromJson(mapData);
//       }
//     } catch (e) {
//       print(e);
//       throw e;
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helpers/loader_helper.dart';
import 'baseurl.dart';


class BindAjencyRepo
{
  List bindajencyList = [];
  Future<List> bindajency() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    String? iUserId = prefs.getString('iUserId');

    print('-----22---$sToken');
    print('-----23---$iUserId');
    try
    {
      showLoader();
      var baseURL = BaseRepo().baseurl;
      var endPoint = "BindJE/BindJE";
      var bindajencyApi = "$baseURL$endPoint";
      print('------------17---bindajencyApi---$bindajencyApi');

      var headers = {
        'token': '$sToken'
      };
      var request = http.Request('GET', Uri.parse('$bindajencyApi'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200)
      {
        hideLoader();
        var data = await response.stream.bytesToString();
        Map<String, dynamic> parsedJson = jsonDecode(data);
        bindajencyList = parsedJson['Data'];
      //  print("Dist list bindajencyList Api ----81------>:$bindajencyList");
        return bindajencyList;
      } else
      {
        hideLoader();
        return bindajencyList;
      }
    } catch (e)
    {
      hideLoader();
      throw (e);
    }
  }
}