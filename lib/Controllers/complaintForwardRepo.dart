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
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helpers/loader_helper.dart';
import '../screens/generalFunction.dart';
import 'baseurl.dart';


class ComplaintForwardRepo
{
  GeneralFunction generalFunction = GeneralFunction();
 // List complaitForwardList = [];
  Future complaintForward(BuildContext context, selectedHoldValue, iCompCode) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    String? iUserId = prefs.getString('iUserId');

    print('-----22---$sToken');
    print('-----23---$iUserId');
    print('----52---$selectedHoldValue');
    print('----53---$iCompCode');
    try
    {
      showLoader();
      var baseURL = BaseRepo().baseurl;
      var endPoint = "ComplaintTransferJETOJE/ComplaintTransferJETOJE";
      var complaintForwardApi = "$baseURL$endPoint";
      print('------------17---complaintForwardApi---$complaintForwardApi');


      var headers = {
        'token': '$sToken',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('$complaintForwardApi'));
      request.body = json.encode({
        "iCompCode": "$iCompCode",
        "sUserid": "$iUserId",
        "iNewUser": "$selectedHoldValue"
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      var map;
      var data = await response.stream.bytesToString();
      map = json.decode(data);
      print('----------93--- Response----$map');
      if (response.statusCode == 200)
      {
        hideLoader();
        print('----------83-----$map');
        return map;

      } else if(response.statusCode ==200){
        generalFunction.logout(context);
      }
      else{
        print('---95---Not call--');
        hideLoader();
        return map;
      }
    } catch (e)
    {
      hideLoader();
      throw (e);
    }
  }
}