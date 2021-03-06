import 'dart:convert';
import 'dart:isolate';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ShoppingListItem.dart';

class ListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'List App',
      theme: new ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: new ShoppingList(
        products: <Product>[
          new Product(name: 'Eggs'),
          new Product(name: 'Flour'),
          new Product(name: 'Chocolate chips'),
        ],
      ),
    );
  }
}

class ListAppPage extends StatefulWidget {
  ListAppPage({Key key}) : super(key: key);

  @override
  _ListAppPageState createState() => new _ListAppPageState();
}

class _ListAppPageState extends State<ListAppPage> {
  List widgets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    print('initState');

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: getBody(),
    );
  }

  void loadData() async {
    /*String dataURL = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(dataURL);
    setState(() {
      widgets = json.decode(response.body);
    });*/
    ReceivePort receivePort = new ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);
    SendPort sendPort = await receivePort.first;
    List msg = await sendReceive(
        sendPort, "https://jsonplaceholder.typicode.com/posts");
    setState(() {
      widgets = msg;
    });
  }

  static dataLoader(SendPort sendPort) async {
    ReceivePort port = new ReceivePort();
    sendPort.send(port.sendPort);
    await for (var msg in port) {
      String data = msg[0];
      SendPort replyTo = msg[1];
      String dataUrl = data;
      http.Response response = await http.get(dataUrl);
      replyTo.send(json.decode(response.body));
    }
  }

  Widget getRow(int position) {
    return new Padding(
      padding: new EdgeInsets.all(10.0),
      child: new Text("$position ${widgets[position]["title"]}"),
    );
  }

  sendReceive(SendPort sendPort, String s) {
    ReceivePort response = new ReceivePort();
    sendPort.send([s, response.sendPort]);
    return response.first;
  }

  getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  showLoadingDialog() {
    if (widgets.length == 0) {
      return true;
    }
    return false;
  }

  ListView getListView() => new ListView.builder(
        itemBuilder: (BuildContext context, int position) {
          return getRow(position);
        },
        itemCount: widgets.length,
      );

  getProgressDialog() {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }
}

class ShoppingList extends StatefulWidget{
  ShoppingList({Key key,this.products}): super(key : key);
  final List<Product> products;

  @override
  State<StatefulWidget> createState() => _ShoppingListState();

}

class _ShoppingListState extends State<ShoppingList>{

  Set<Product> _shoppingCart = new Set<Product>();

  void _handleCartChanged(Product product,bool inCart){
    setState(() {
      if(inCart){
        _shoppingCart.add(product);
      }else{
        _shoppingCart.remove(product);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product){
          return new ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }

}