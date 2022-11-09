import 'package:flutter/material.dart';
import 'package:stock_flutter_app/asset/palette.dart';
import 'package:stock_flutter_app/screens/ChartPage.dart';
import '/screens/ListPage.dart';
import './screens/SearchPage.dart';
import 'screens/loginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MarketPage(),
    );
  }
}

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _widgetOptions = <Widget>[
    ListPage(title: "title"),
    SearchPage(title: "title"),
    LoginPage(title: "title")
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 메인 위젯
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Chart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'MyPage',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightGreen,
        onTap: _onItemTapped,
      ),
      // bottomNavigationBar: BottomAppBar(
      //   color: Palette.containerColor,
      //   child: IconTheme(
      //     data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
      //     child: Row(
      //       children: [
      //         IconButton(onPressed: () => {}, icon: Icon(Icons.bar_chart)),
      //         IconButton(onPressed: () => {}, icon: Icon(Icons.search)),
      //         IconButton(onPressed: () => {}, icon: Icon(Icons.people)),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  @override
  void initState() {
    //해당 클래스가 호출되었을떄
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
