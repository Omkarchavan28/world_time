import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name
  String time; //time of the location
  String flag; //url to asset flag
  String url; //path of the url of location
  bool isDaytime; // true if day false for night
  WorldTime({this.location, this.flag, this.url});
  Future<void> getTime() async {
    try {
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'];

      String offsetHours = offset.substring(1, 3);
      String offsetMinutes = offset.substring(4, 6);
      DateTime now = DateTime.parse(datetime);
      Duration duration = Duration(
          hours: int.parse(offsetHours), minutes: int.parse(offsetMinutes));
      now = now.add(duration);
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now); //set time property
    } catch (e) {
      print(e);
      print('TIME VARIABLE ERROR');
      time = 'could not load time';
    }
  }
}
