import 'dart:io';
import 'package:http/http.dart' as http;

//http://armdriver.orgfree.com/index.php/?ledstatus=1
onMotor() async {
  var url =
      Uri.http('armdriver.orgfree.com', '/index.php', {'ledstatus': '1'});
  var response = await http.get(url);
  if (response.statusCode == 200) {
    print(response.statusCode);
    print(url);
  }
}

offMotor() async {
  var url =
      Uri.http('armdriver.orgfree.com', '/index.php', {'ledstatus': '0'});
  var response = await http.get(url);
  if (response.statusCode == 200) {
    print(response.statusCode);
    print(url);
  }
}