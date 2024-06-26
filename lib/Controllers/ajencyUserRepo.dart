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

class AjencyUserRepo
{
  List ajencyUserList = [];
  Future<List>  ajencyuser(int ajencyCode) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    String? iUserId = prefs.getString('iUserId');


    print('-----ajencyCode---$ajencyCode');
    try
    {
      showLoader();
      var baseURL = BaseRepo().baseurl;
      var endPoint = "AgencyUsers/AgencyUsers";
      var ajencyUserApi = "$baseURL$endPoint";
      print('------------17---ajencyUserApi---$ajencyUserApi');

      var headers = {
        'token': '$sToken',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('$ajencyUserApi'));
      request.body = json.encode({
        "iAgencyCode": ajencyCode
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // var map;
      //
      // var data = await response.stream.bytesToString();
      // map = json.decode(data);

      if (response.statusCode == 200)
      {
        var data = await response.stream.bytesToString();
        Map<String, dynamic> parsedJson = jsonDecode(data);

        ajencyUserList = parsedJson['Data'];
        //print('')
       // ajencyUserList = parsedJson as List;
        hideLoader();
        return ajencyUserList;
      } else
      {
        hideLoader();
        return ajencyUserList;
      }
    } catch (e)
    {
      hideLoader();
      throw (e);
    }
  }

}