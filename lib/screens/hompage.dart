import 'dart:async';

import 'package:ev_app/http/http_requests.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool status1 = false;
  double tempDegree = 12.0;
  double actualSpeed = 120.0;
  int setPointSpeed = 75;

  @override
  void initState() {
    super.initState();
    getTemperaturePeriodically();
    getSpeedPeriodically();
  }

  @override
  Widget build(BuildContext context) {
    const gridColor = Color.fromARGB(255, 64, 63, 65);
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Electric Vehicle App',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                _showMyDialog(context);
              },
              icon: const Icon(Icons.error),
            ),
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          // Motor Start/Stop **************************************************
          Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 10, bottom: 5, right: 5),
            child: Container(
              decoration: const BoxDecoration(
                color: gridColor,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              width: _width * 0.5,
              height: _width * 0.5,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Motor Start/Stop',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            'Off',
                            style: TextStyle(
                                fontSize: 15,
                                color: status1 == false
                                    ? Colors.red
                                    : Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        FlutterSwitch(
                          width: 75.0,
                          height: 40.0,
                          toggleSize: 20.0,
                          value: status1,
                          borderRadius: 30.0,
                          padding: 2.0,
                          toggleColor: const Color.fromRGBO(225, 225, 225, 1),
                          switchBorder: Border.all(
                            color: status1 ? Colors.green : Colors.red,
                            width: 6.0,
                          ),
                          toggleBorder: Border.all(
                            color: status1 ? Colors.green : Colors.red,
                            width: 5.0,
                          ),
                          activeColor: const Color.fromARGB(255, 120, 237, 143),
                          inactiveColor:
                              const Color.fromARGB(255, 248, 109, 99),
                          onToggle: (val) {
                            setState(() {
                              status1 = val;
                              if (status1 == true) {
                                // on Led (write 1 on server)
                                onMotor();
                              } else if (status1 == false) {
                                // off Led (write 0 on server)
                                offMotor();
                              }
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            'On',
                            style: TextStyle(
                                fontSize: 15,
                                color: status1 == true
                                    ? Colors.green
                                    : Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Closed Motor Start/Stop *******************************************

          // Temperature Sensor ************************************************
          Padding(
            padding:
                const EdgeInsets.only(left: 5, top: 10, bottom: 5, right: 10),
            child: Container(
              decoration: const BoxDecoration(
                color: gridColor,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              width: _width * 0.5,
              height: _width * 0.5,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Motor Temperature',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.05,
                  ),
                  CircularPercentIndicator(
                    radius: 40.0,
                    lineWidth: 5.0,
                    percent: (tempDegree / 100.0),
                    center: Text(
                      tempDegree.toString() + ' °C',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    progressColor: Colors.orange,
                  )
                ],
              ),
            ),
          ),
          // Closed Temperature Sensor *****************************************

          // Speed Control *****************************************************
          Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 5, bottom: 10, right: 5),
            child: Container(
              decoration: const BoxDecoration(
                color: gridColor,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              width: _width * 0.5,
              height: _width * 0.5,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Measured Speed',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.01,
                  ),
                  CircularPercentIndicator(
                    radius: 50.0,
                    lineWidth: 8.0,
                    percent: (actualSpeed / 150.0),
                    center: Text(
                      actualSpeed.toString() + ' RPM',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    progressColor: Color.fromARGB(255, 239, 26, 143),
                  ),
                  SizedBox(
                    height: _height * 0.03,
                  ),
                  Text(
                    actualSpeed.toString() + ' RPM',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          // Closed Speed Control *****************************************

          Padding(
            padding:
                const EdgeInsets.only(left: 5, top: 5, bottom: 10, right: 10),
            child: Container(
              decoration: const BoxDecoration(
                color: gridColor,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              width: _width * 0.5,
              height: _width * 0.5,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Speed Control',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.06,
                  ),
                  Slider(
                    value: setPointSpeed/1.0,
                    max: 150.0,
                    divisions: 10,
                    label: (setPointSpeed / 100).round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        setPointSpeed = value.round();
                      });
                      controlSpeed(setPointSpeed);
                    },
                  ),
                  Text(
                    setPointSpeed.toString() + ' RPM',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          // Closed Speed Control **********************************************
        ],
      ),
    );
  }

/* Functions********************************************************************/
/* get Temperature Periodically ************************************************/
  getTemperaturePeriodically() async {
    var temp;
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      temp = await getTemp();
      print(temp);
      setState(() {
        tempDegree = temp / 1.0;
        tempDegree > 100 ? tempDegree = 100.0 : tempDegree = tempDegree;
      });
    });
  }

/* get speed Periodically ******************************************************/
  getSpeedPeriodically() async {
    var speed;
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      speed = await getSpeed();
      print(speed);

      setState(() {
        actualSpeed = speed / 1.0;
      });
    });
  }

/* control speed Periodically ******************************************************/
 /* controlSpeedOnChange() async {
    Timer.periodic(const Duration(seconds: 3), (timer) async {
      await controlSpeed();
      setState(() {});
    });
  }
*/
//* About My App ***************************************************************/
  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('About'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'This app is monitoring and controling an electric vehicle with Arm-based Embedded system and ESP2866 Wi-Fi module.'),
                SizedBox(
                  height: 20,
                ),
                Text(
                    'This software is licensed under MIT License, ©MohamedRagab.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
