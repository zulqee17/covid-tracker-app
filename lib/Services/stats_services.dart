import 'dart:convert';

import 'package:covid_tracker_app/Models/world_states_model.dart';
import 'package:covid_tracker_app/Services/Utilities/app_urls.dart';
import 'package:http/http.dart' as http;

class WorldStatsServices{

  Future<WorldStatesModel> fetchWorldStats() async{
    final response=await http.get(Uri.parse(AppUrl.worldstatesApi));
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception('Error...');
    }
  }

  Future<dynamic> countriesListApi() async{
    var data;
    final responce=await http.get(Uri.parse(AppUrl.countriesList),);
    if(responce.statusCode==200){
      data=jsonDecode(responce.body.toString());
      return data;
    }else{
      throw Exception('Error...');
    }
  }

}