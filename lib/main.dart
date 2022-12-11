import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_flutter_app/asset/palette.dart';
import 'package:stock_flutter_app/screens/ChartPage.dart';
import 'package:stock_flutter_app/screens/MyPage.dart';
import '/screens/ListPage.dart';
import './screens/SearchPage.dart';
import 'firebase/FirestoreService.dart';
import 'screens/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import './firebase/auth_service.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() {

//   runApp(const MyApp());
// }
Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized(); // main 함수에서 async 사용하기 위함
  // await Firebase.initializeApp(); // firebase 앱 시작
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => FirestoreService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
  final auth = FirebaseAuth.instance;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _widgetOptions = <Widget>[
    ListPage(
      title: "title",
      dayPriceList: [],
    ),
    SearchPage(title: "title"),
    MyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 메인 위젯
  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreService>(
        builder: (context, FirestoreService, child) {
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
            selectedItemColor: Palette.outlineColor,
            onTap: _onItemTapped),
      );
    });
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
