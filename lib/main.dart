import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MethodChannelImplementation(),
    );
  }
}

class MethodChannelImplementation extends StatefulWidget {
  @override
  _MethodChannelImplementationState createState() =>
      _MethodChannelImplementationState();
}

class _MethodChannelImplementationState
    extends State<MethodChannelImplementation> {
  //Aim : we will call method channel and it will return device details'
  String? methodChannelValue;
  static const methodChannel = MethodChannel('deviceinfo');

  @override
  void initState() {
    super.initState();
    methodChannelValue = 'Not initiated';
  }

  void initMethodChannel() async {
    String? returnedValue = await methodChannel.invokeMethod<String>('getSystemDetail');
    if (returnedValue != null)
      setState(() {
        methodChannelValue = returnedValue;
      });
  }

  @override
  Widget build(BuildContext context) {
    // FlutterFromAndroid(showProgress, context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Info'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              methodChannelValue??'loading..',
              style: Theme.of(context).textTheme.headline5,
            ),
            ElevatedButton(
              onPressed: initMethodChannel,
              child: Text("Initiate Method channel"),
            )
          ],
        ),
      ),
    );
  }
}
