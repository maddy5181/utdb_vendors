import 'dart:async';
import 'package:flutter_login_page_ui/Utils/Network_util.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://127.0.0.1:84/fwiz20/backend/web/tic/utdb-api";
  static final LOGIN_URL = BASE_URL +"/login-users";
  //static final _API_KEY = "2345";


  Future<String> login(String username, String password) {print(LOGIN_URL);
    return _netUtil.createPost(LOGIN_URL, body: {
      "mobile": username,
      "latitude": "345.56",
      "longitude": "234.45",
      "password": password
    }).then((dynamic res) {
      print("retstd"+res.toString());
      return res.toString();
    });



  }
}

