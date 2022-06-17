// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

import 'package:flutter_app/screens/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/date_time.dart';
import 'package:flutter_app/screens/homeuser.dart';
import 'package:flutter_app/screens/index.dart';

// ignore: must_be_immutable
class servicesPage extends StatefulWidget {
  var name, address, category;
  // ignore: use_key_in_widget_constructors
  servicesPage(this.name, this.address, this.category);

  @override
  // ignore: library_private_types_in_public_api
  _servicesPageState createState() =>
      // ignore: no_logic_in_create_state
      _servicesPageState(name, address, category);
}

// ignore: duplicate_ignore
class _servicesPageState extends State<servicesPage> {
  var name, address, category;
  _servicesPageState(this.name, this.address, this.category);
  var selectedService = -1;
  var selected;
  getservice service = getservice();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(153.0), // here the desired height
          child: AppBar(
            backgroundColor: const Color(0xffF8C80E),
            flexibleSpace: const Image(
              image: AssetImage('assets/logo3.png'),
              fit: BoxFit.none,
            ),
            /* title: Image.asset('assets/logo3.png',
                width: 150, height: 150, fit: BoxFit.fill

                // height: 200,
                ),*/
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "btn2",
                onPressed: () async {
                  print(name);
                  print(address);
                  print(category);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectService(name: name)));
                },
                child: Icon(Icons.navigate_before),
                backgroundColor: Color(0xffE63220),
              ),
              FloatingActionButton(
                heroTag: "btn1",
                onPressed: () async {
                  print(widget.name);
                  print(category);
                  print(address);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DateAndTime(name, address, category, selected)));
                },
                child: Icon(Icons.navigate_next),
                backgroundColor: Color(0xffE63220),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                    child: FadeAnimation(
                  1,
                  Padding(
                    padding:
                        EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
                    child: Text(
                      'Choose the type of service',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ))
              ];
            },
            body: Padding(
              padding: EdgeInsets.all(20.0),
              child: FutureBuilder<List>(
                  future: service.getAllCategory(),
                  builder: (context, snapshot) {
                    //  print(snapshot.data);
                    if (snapshot.hasData) {
                      //print(snapshot.data);
                      var d = snapshot.data?.length;
                      List<int> neededservices = [];
                      for (var i = 0; i < snapshot.data!.length; i++) {
                        if (snapshot.data![i]['catname'] == category) {
                          neededservices.add(i);
                        }
                      }
                      if (neededservices.length == 0) {
                        return const Center(child: Text('No Data Found'));
                      } else {
                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 5.0,
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 10.0,
                            ),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: neededservices.length,
                            itemBuilder: (context, index) {
                              return FadeAnimation(
                                  (1.0 + index) / 4,
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected =
                                            snapshot.data![index]['service'];
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
                                              : Color(0xffF8C80E)
                                                  .withOpacity(0),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Row(children: [
                                        Image.asset(
                                          snapshot.data![neededservices[index]]
                                                  ['Img']
                                              .toString(),
                                          width: 35,
                                          height: 35,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          snapshot.data![neededservices[index]]
                                              ['service'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ));
                            });
                      }
                    } else {
                      return const Center(
                        child: Text('No Data Found'),
                      );
                    }
                  }),
            )));
  }
}
