import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  PermissionStatus? _permissionCameraStatus;
  PermissionStatus? _permissionStorageStatus;
  PermissionStatus? _permissionGallery;
  PermissionStatus? _permissionLocation;
  PermissionStatus? _permissionMicrophone;
  PermissionStatus? _permissionNotification;

  void _askPermissionTogether() {
    Permission.camera
        .onPermanentlyDeniedCallback(() {
          print("Camera permission is denied");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Camera permission is denied'),
              action: SnackBarAction(
                label: "OK",
                onPressed: (){},
              ),
            ),
          );
        })
        .request()
        .then((value) {
          print("Camera permission status: $value");
          setState(() {
            _permissionCameraStatus = value;
          });
        })
        .then((_) => Permission.photos
            .onPermanentlyDeniedCallback(() {
              print('Photos permission is denied');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Photos permission is denied'),
                  action: SnackBarAction(
                    label: "OK",
                    onPressed: (){},
                  ),
                ),
              );
            })
            .request()
            .then((value) {
              print("Photos permission status: $value");
              setState(() {
                _permissionGallery = value;
              });
            })
            .catchError((e) {
              print(e);
            }))
        .then((_) => Permission.storage
            .onPermanentlyDeniedCallback(() {
              print("Storage permission is denied");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Storage permission is denied'),
                  action: SnackBarAction(
                    label: "OK",
                    onPressed: (){},
                  ),
                ),
              );
            })
            .request()
            .then((value) {
              print("Storage permission status: $value");
              setState(() {
                _permissionStorageStatus = value;
              });
            }))
        .then((_) => Permission.location
            .onPermanentlyDeniedCallback(() {
              print("Location Permission is denied");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Location Permission is denied'),
                  action: SnackBarAction(
                    label: "OK",
                    onPressed: (){},
                  ),
                ),
              );
            })
            .request()
            .then((value) {
              print("Location permission status: $value");
              setState(() {
                _permissionLocation = value;
              });
            }))
        .then((_) => Permission.microphone
            .onPermanentlyDeniedCallback(() {
              print("Microphone permission is denied");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Microphone permission is denied'),
                  action: SnackBarAction(
                    label: "OK",
                    onPressed: (){},
                  ),
                ),
              );
            })
            .request()
            .then((value) {
              print("Microphone permission status: $value");
              setState(() {
                _permissionMicrophone = value;
              });
            }))
        .then((value) => Permission.notification
            .onPermanentlyDeniedCallback(() {
              print("Notification permission is denied");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Notification permission is denied'),
                  action: SnackBarAction(
                    label: "OK",
                    onPressed: (){},
                  ),
                ),
              );
            })
            .request()
            .then((value) {
              print("Notification permission status: $value");
              setState(() {
                _permissionNotification = value;
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('camera: $_permissionCameraStatus'),
            if (Platform.isIOS) Text('gallery: $_permissionGallery'),
            Text('storage: $_permissionStorageStatus'),
            Text('location: $_permissionLocation'),
            Text('microphone: $_permissionMicrophone'),
            Text('notification: $_permissionNotification'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _askPermissionTogether,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
