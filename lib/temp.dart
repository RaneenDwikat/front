// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_app/screens/FadeAnimation.dart';
import 'package:flutter_app/screens/index.dart';

class MyApp extends StatefulWidget {
//MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var selectedService = -1;
  getcat service = getcat();
  @override
  void initState() {
    service.getAllCategory();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: service.getAllCategory(),
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.hasData) {
          print(snapshot.data![0]['name']);

          var d = snapshot.data?.length;
          return SafeArea(
            bottom: false,
            child: Column(
              children: <Widget>[
                //CategoryList(),
                SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      // Our background
                      Container(
                        margin: const EdgeInsets.only(top: 60),
                        decoration: const BoxDecoration(
                          color: Color(0xffE63220),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),
                      ListView.builder(
                        // here we use our demo procuts list
                        itemCount: d,
                        itemBuilder: (
                          BuildContext context,
                          int index,
                        ) {
                          // print(snapshot.data![index].image + "okk");
                          return FadeAnimation(
                              (1.0 + index) / 4,
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (selectedService == index)
                                      selectedService = -1;
                                    else
                                      selectedService = index;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: selectedService == index
                                        ? Colors.blue.shade50
                                        : Colors.grey.shade100,
                                    border: Border.all(
                                      color: selectedService == index
                                          ? Color(0xffF8C80E)
                                          : Color(0xffF8C80E).withOpacity(0),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        // Image.asset(snapshot.data![index],
                                        //     height: 60),
                                        // SizedBox(
                                        //   height: 20,
                                        // ),
                                        Text(
                                          snapshot.data![index]['name'],
                                          style: TextStyle(fontSize: 20),
                                        )
                                      ]),
                                ),
                              ));
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('No Data Found'),
          );
        }
      },
    );
  }
}
