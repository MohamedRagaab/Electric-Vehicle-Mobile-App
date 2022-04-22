import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

/* Motor Turn On/Off ***********************************************************/
var urlWeb = 'driver.6te.net';
onMotor() async {
  var url = Uri.http(urlWeb, '/index.php', {'on_off': '1'});
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var motor = jsonResponse['on_off'];
    print('motor is: $motor');
    print(url);
  }
}

offMotor() async {
  var url = Uri.http(urlWeb, '/index.php', {'on_off': '0'});
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var motor = jsonResponse['on_off'];
    print('motor is: $motor');
    print(url);
  }
}

/* Monitoring Temperature ******************************************************/
getTemp() async {
  var url = Uri.http(urlWeb, '/index.php', {'getTemp': '5000'});
  var response = await http.get(url);
  var temp;
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    temp = jsonResponse['temp'];
    print('The Teperature is: $temp');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  return temp;
}

/* Monitoring Speed ******************************************************/
getSpeed() async {
  var url = Uri.http(urlWeb, '/index.php',
      {'getSpeed': '5000', 'client': 'flutter'});
  print(url);
  var response = await http.get(url);
  var speed;
  print(speed);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    speed = jsonResponse['speed'];
    print('The Speed is: $speed');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  return speed;
}

/* Control Speed ******************************************************/
controlSpeed(int speed) async {
  var url = Uri.http(urlWeb, '/index.php',
      {'getSpeed': speed.toString(), 'client': 'flutter', 'mode': 'control'});
  print(url);
  var response = await http.get(url);

  if (response.statusCode == 200) {
  
  }
  return speed;
}
