import 'package:flutter/material.dart';

class LakeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Startup Name Generator",
      theme: new ThemeData(
        primaryColor: Colors.indigo,
      ),
      home: new LakeWidget(),
    );
  }
}

class LakeWidget extends StatefulWidget {
  @override
  createState() => new LakeWidgetState();
}

class LakeWidgetState extends State {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new Text(
                      'Oeschinen Lake Campground',
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: new Text(
                      'Kandersteg, Switzerland',
                      style: new TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  )
                ],
              )),
          new FavoriteWidget(),
//          new Icon(
//            Icons.star,
//            color: Colors.red[500],
//          ),
//          new Text('41')
        ],
      ),
    );

    Widget buttonSetion = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildButtonColumn(Icons.call, 'CALL'),
          buildButtonColumn(Icons.near_me, 'ROUTE'),
          buildButtonColumn(Icons.share, 'SHARE'),
        ],
      ),
    );

    Widget textSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
        '''
      Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
         ''',
        softWrap: true,
      ),
    );

    Widget pavlova = _buildPavlova();

    return new Scaffold(
      body: new ListView(
        children: [
          new Image.asset(
            'images/lake.jpeg',
            width: 600.0,
            height: 240.0,
            fit: BoxFit.cover,
          ),
          titleSection,
          buttonSetion,
          textSection,
          pavlova,
          new ParentWidget(),

        ],
      ),
    );
  }

  Column buildButtonColumn(IconData icon, String label) {
    Color primaryColor = Theme
        .of(context)
        .primaryColor;
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Icon(
          icon,
          color: primaryColor,
        ),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: new Text(
            label,
            style: new TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: primaryColor,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPavlova() {
    Widget _stars = _buildStars();

    return new Row(
      children: <Widget>[
        new Expanded(
          flex: 2,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Container(
                padding:
                const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: new Text(
                  'Strawberry Pavlova',
                  style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              new Container(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  '''
                    Pavlova is a meringue-based dessert named after the Russian ballerina Anna Pavlova. It is a meringue dessert with a crisp crust and soft, light inside, usually topped with fruit and whipped cream.
                    ''',
                  style: new TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
              _stars,
            ],
          ),
        ),
        new Expanded(
          flex: 3,
          child: new Container(
            padding: const EdgeInsets.all(8.0),
            child: new Image.asset(
              'images/pavlova.jpg',
              width: 300.0,
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStars() {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new Icon(
                Icons.star,
                color: Colors.black,
                size: 10.0,
              ),
              new Icon(
                Icons.star,
                color: Colors.black,
                size: 10.0,
              ),
              new Icon(
                Icons.star,
                color: Colors.black,
                size: 10.0,
              ),
              new Icon(
                Icons.star,
                color: Colors.black,
                size: 10.0,
              ),
              new Icon(
                Icons.star,
                color: Colors.black,
                size: 10.0,
              ),
            ],
          ),
          new Text(
            '170 Reviews',
            style: new TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 10.0,
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => new _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State {
  bool _isFavorite = true;
  int _favoriteCount = 41;

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(0.0),
          child: new IconButton(
            icon: _isFavorite ? new Icon(Icons.star) : new Icon(
                Icons.star_border),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        new SizedBox(
          width: 23.0,
          child: new Container(
            child: new Text('$_favoriteCount'),
          ),
        )
      ],
    );
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorite) {
        _favoriteCount -= 1;
        _isFavorite = false;
      } else {
        _favoriteCount += 1;
        _isFavorite = true;
      }
    });
  }
}

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => new _ParentWidgetState();

}

class _ParentWidgetState extends State {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapboxC(active: _active, onChanged: _handleTapBoxChanged),
    );
  }

  void _handleTapBoxChanged(bool value) {
    setState(() {
      _active = value;
    });
  }
}

class TapBoxB extends StatelessWidget {
  TapBoxB({Key key, this.active: false, @required this.onChanged})
      :super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            active ? 'ACTIVE' : 'INACTIVE',
            style: new TextStyle(
              fontSize: 32.0,
              color: Colors.white,
            ),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],

        ),
      ),
    );
  }


  void _handleTap() {
    onChanged(!active);
  }
}

class TapboxC extends StatefulWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  TapboxC({Key key, this.active, this.onChanged}) : super(key: key);

  @override
  _TapboxCState createState() => new _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: new Container(
        child: new Center(
          child: new Text(
            widget.active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color:
            widget.active ? Colors.lightGreen[700]:Colors.grey[600],
          border: _highlight ? new Border.all(
            color: Colors.teal[700],
            width: 10.0,
          ):null,
        ),
      ),
    );
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

}

//buildButtonColumn(IconData call, String s) {
//
//}
