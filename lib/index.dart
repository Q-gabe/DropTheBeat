import 'package:flutter/material.dart';
import 'navigation_icon_view.dart';
import 'beatMap.dart';
import 'settings.dart';

// Create a stateful Widget Index
class Index extends StatefulWidget {
 // Fixed Writing
 @override
 State<StatefulWidget> createState() => new _IndexState();
}

// To enable the main page Index to support dynamic effects, add a mixin-type object TickerProviderStateMixin to its definition
class _IndexState extends State<Index> with TickerProviderStateMixin{

  int _currentIndex = 0; // Index value of current interface
  List<NavigationIconView> _navigationViews; // Bottom Button Area
  List<StatefulWidget> _pageList; // Pages used to store our icons
  StatefulWidget _currentPage; // Current Display Page

  // Define an empty method for setting state values
  void _rebuild() {
    setState((){});
  }

  @override
  void initState() {
    super.initState();

    // Initialize navigation icon
    _navigationViews = <NavigationIconView>[
      new NavigationIconView (
        icon: new Icon(Icons.map),
        title: new Text ("BeatMap"), 
        vsync: this,
      ), // Vsync default attributes and parameters
      new NavigationIconView (
        icon: new Icon(Icons.settings),
        title: new Text ("Settings"),
        vsync: this,
      ),
    ];

    // Add listening to each button area
    for (NavigationIconView view in _navigationViews) {
      view.controller.addListener(_rebuild);
    }

    // Store the page corresponding to the button icon on our bottomBar for us to click on
    _pageList = <StatefulWidget>[
      new BeatMapPage(),
      new SettingsPage(),
    ];
    _currentPage = _pageList[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {

    // Declare the definition of a toolbar for bottom navigation
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      items: _navigationViews
      .map((NavigationIconView navigationIconView) => navigationIconView.item).toList(),
      currentIndex: _currentIndex, // Index value currently clicked
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        _navigationViews[_currentIndex].controller.reverse();
        _currentIndex = index;
        _navigationViews[_currentIndex].controller.forward();
        _currentPage = _pageList[_currentIndex];
      },
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.black,
    );

    return new MaterialApp(
      home: new Scaffold(
        body: new Center(
          child: _currentPage //Dynamic presentation of our current page
        ),
        bottomNavigationBar: bottomNavigationBar, // Bottom toolbar
      ),

      theme: new ThemeData(
        primarySwatch: Colors.grey, /// Setting Theme Colors
      ),
    );
  }

}