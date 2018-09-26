import 'package:flutter/material.dart';

void main() {
  runApp(new SampleApp());
}

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'SmapleApp',
      theme: new ThemeData(
          primaryColor: Colors.indigo
      ),
      home: new SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  _SampleAppPageState createState() => new _SampleAppPageState();

}

class _SampleAppPageState extends State<SampleAppPage> with TickerProviderStateMixin {
  AnimationController controller;
  bool toggle = true;
  CurvedAnimation curvedInAnimation;
  CurvedAnimation curvedOutAnimation;

  @override
  void initState() {
    controller = new AnimationController(duration: const Duration(milliseconds: 2000),vsync: this);
    curvedInAnimation = new CurvedAnimation(parent: controller, curve: Curves.easeIn);
    curvedOutAnimation = new CurvedAnimation(parent: controller, curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      body: new Center(
//        child: _getFadeOut(),
//      ),
    body: new Signature(),
//      floatingActionButton: new FloatingActionButton(
//        onPressed: _fade,
//        tooltip: 'Fade',
//        child: new Icon(Icons.brush),
//      ),
    );
  }

  void _toggle() {
    setState(() {
      toggle = !toggle;
    });
  }

  _getToggleChild() {
    if (toggle) {
      return new Text('Toggle One');
    } else {
      return new MaterialButton(
        onPressed: () {}, child: new Text('Toggle Two'),);
    }
  }

  Widget _getFadeIn(){
    return new Center(
      child: new Container(
        child: new FadeTransition(
            opacity: curvedInAnimation,
            child: new FlutterLogo(
              size: 100.0,
            ),
        ),
      ),
    );
  }
  Widget _getFadeOut(){
    return new Center(
      child: new Container(
        child: new FadeTransition(
            opacity: curvedOutAnimation,
            child: new FlutterLogo(
              size: 100.0,
            ),
        ),
      ),
    );
  }
  void _fade(){
//    setState(() {
//      toggle = !toggle;
//    });
    controller.forward();
  }
}

class Signature extends StatefulWidget{
  @override
  SignatureState createState()=> SignatureState();
}

class SignatureState extends State<Signature>{
  List<Offset> _points = <Offset>[];
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        GestureDetector(
          onPanUpdate: (DragUpdateDetails details){
            RenderBox referenceBox = context.findRenderObject();
            Offset localPosition = referenceBox.globalToLocal(details.globalPosition);
            setState(() {
              _points = new List.from(_points)..add(localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),
        ),
        new CustomPaint(painter: new SignaturePainter(_points),),
      ],
    );
  }

}
class SignaturePainter extends CustomPainter{
  SignaturePainter(this.points);
  final List<Offset> points;
  void paint(Canvas canvas, Size size) {
    var paint = new Paint()
        ..color = Colors.black
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 5.0;
    for(int i = 0; i < points.length - 1;i++){
      if(points[i] != null && points[i + 1] != null){
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
    
  }
  bool shouldRepaint(SignaturePainter other) => other.points != points;
}