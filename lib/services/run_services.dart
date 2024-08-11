import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project_tally/models/output_model.dart';
import 'package:http/http.dart' as http;
import 'package:project_tally/utils/custom_snackbars.dart';
class RunServices{
  Future<CommandMetrics> getToken(BuildContext context,String input,int number,String stdin) async{
    print(input);
    Map<int,String> lang = {62:"java", 92:"python", 54:"cpp"};
    String url=dotenv.env['url']!;
    log(jsonEncode({
      "code":input,
      "language":lang[number]
    }));
    try{
      http.Response res=await http.post(Uri.parse(url),
          headers:{
            "Access-Control-Allow-Origin": "*",
            "Content-Type":"application/json",
            "Accept": "*/*"
          },
          body:jsonEncode({
            "code":input,
            "language":lang[number],
            "input":stdin
          })
      );
      if(res.statusCode==200){
        // ShowSuccessSnackBar(context, "Done");
        Map<String,dynamic> json=jsonDecode(res.body);
        var data=CommandMetrics.fromJson(json);
        print(json);
        return data;
      }
      else{
        ShowFailureSnackBar(context, res.body);
        throw "Something wrong happened";

      }
    }catch(e){
      print("this is printing");
      rethrow;
    }
  }
}