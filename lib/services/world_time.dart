import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  String location; // location name for UI
  String time; // time of the location
  String flag; // url to an asset flag location
  String url; // location url for api endpoint

  WorldTime({ this.location, this.flag, this.url});

  Future<void> getTime() async {
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
    time = now.toString(); // set time property
  }
}