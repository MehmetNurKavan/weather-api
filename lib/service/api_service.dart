import 'dart:io';
import 'package:http/http.dart' as  http;

class ApiService{
  static Future getWeatherDataByCity(String city) async{
    String uri= "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=$city";
    return await http.get(Uri.parse(uri),
    headers: {
      HttpHeaders.authorizationHeader:'apikey 7H5BgSQj8961SEANHTUexi:5WiUVbqRpVXGlQ99q2suVA', //This is personal private API key
      HttpHeaders.contentTypeHeader: 'application/json',
    }
    );
  }
}