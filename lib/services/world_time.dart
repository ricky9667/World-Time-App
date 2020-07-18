import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for UI
  String time; // time of the location
  String flag; // url to an asset flag location
  String url; // location url for api endpoint
  bool isDaytime; // true or false if daytime

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // make request
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      print('datetime: $datetime');
      print('offset: $offset');

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set time property
      isDaytime = (now.hour > 6 && now.hour < 20);
      time = DateFormat.jm().format(now);
    } catch (exception) {
      print('exception: $exception');
      time = 'could not get time data';
    }
  }
}
