import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(new ShareApp());
}

class ShareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'SmapleApp',
      theme: new ThemeData(
          primaryColor: Colors.indigo
      ),
      home: new ShareAppPage(),
    );
  }
}

class ShareAppPage extends StatefulWidget {
  ShareAppPage({Key key}) : super(key: key);

  @override
  _ShareAppPageState createState() => new _ShareAppPageState();

}

class _ShareAppPageState extends State<ShareAppPage>{
  static const platform = const MethodChannel('app.channel.shared.data');
  String dataShared = "No Data";

  @override
  void initState() {
    super.initState();
    getSharedText();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text(dataShared),
      ),
    );
  }
  getSharedText() async {
    var sharedData = await platform.invokeMethod("getSharedText");
    if(sharedData != null){
      setState(() {
        dataShared = sharedData;
      });
    }
  }

}
