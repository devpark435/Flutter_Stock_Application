import 'package:flutter/material.dart';
import '../../widgets/customWidget.dart';
import 'package:flutter/material.dart';
import '../asset/palette.dart';
import '../screens/ChartPage.dart';

var items = List<String>.generate(50, (i) => "카카오");
var logos = List<Widget>.generate(
    50, (i) => Image.asset('/Users/ryeol/Desktop/logoKakao.png'));
var rates = List<String>.generate(50, (i) => "Rate $i");
var price = List<String>.generate(50, (i) => "Price $i");

class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.title});
  final String title;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    //MARK: DefaultTabController
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        //MARK: Custom AppBar
        appBar: AppBar(
          title: const Text(
            'Stock Application',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Palette.containerColor,
          centerTitle: false,
          elevation: 0,
          //MARK: bottom in tabBar
          bottom: TabBar(
            indicatorColor: Palette.containerShadow,
            isScrollable: true,
            indicatorWeight: 3,
            tabs: <Widget>[
              Tab(
                child: Text("Ctg1"),
              ),
              Tab(child: Text("Ctg2")),
              Tab(child: Text("Ctg3")),
            ],
          ),
        ),
        backgroundColor: Palette.bgColor,
        body:
            //MARK: TabBarView
            TabBarView(
          children: <Widget>[
            //MARK: Using Class ListContainer
            Tab(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    itemCount: items == null ? 0 : items.length,
                    itemBuilder: (BuildContext context, int index) {
                      var itemDatas = items![index];
                      var logoDatas = logos![index];
                      var rateDatas = rates![index];
                      var priceDatas = price![index];
                      return SizedBox(
                        height: 80,
                        child: Card(
                          shadowColor: Palette.containerShadow,
                          // color: Palette.containerColor,
                          elevation: 3,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChartPage(
                                          title: 'ComparePage',
                                          items: itemDatas,
                                          logos: logoDatas,
                                          rates: rateDatas,
                                          prices: priceDatas)));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Palette.containerColor),
                                  // decoration: BoxDecoration(
                                  //   shape: BoxShape.circle,
                                  // image: DecorationImage(
                                  //     fit: BoxFit.fill,
                                  //     image: Image.asset('${logoDatas}')
                                  //     // image: AssetImage(
                                  //     //     '/Users/ryeol/Desktop/logoKakao.png')
                                  //         )
                                  // ),
                                  // child: logoDatas,
                                ),
                                Text(itemDatas),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [Text(priceDatas), Text(rateDatas)],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                // child: ListView(
                //   scrollDirection: Axis.vertical,
                //   padding: EdgeInsets.zero,
                //   children: [
                //     Padding(
                //       padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                //       child: GestureDetector(
                //         child: ListBox(),
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ),
            Tab(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: GestureDetector(
                          //   onTap: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) =>
                          //                 ChartPage(title: 'ChartPage')));
                          //   },
                          // child: ListBox(),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
