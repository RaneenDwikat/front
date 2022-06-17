// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter_app/screens/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/homeuser.dart';
import 'package:flutter_app/screens/services.dart';
import 'package:flutter_app/services/authservice.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// ignore: must_be_immutable
class DateAndTime extends StatefulWidget {
  var name, address, category, service;
  // ignore: use_key_in_widget_constructors
  DateAndTime(this.name, this.address, this.category, this.service);
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _DateAndTimeState createState() =>
      _DateAndTimeState(name, address, category, service);
}

class _DateAndTimeState extends State<DateAndTime> {
  String name, address, category, service;
  _DateAndTimeState(this.name, this.address, this.category, this.service);
  int _selectedDay = 2;
  int _selectedRepeat = 0;
  String _selectedHour = '13:30';
  String selected_h = "";
  // ignore: prefer_final_fields
  ItemScrollController _scrollController = ItemScrollController();
  List<dynamic> selected_d = [];
  final List<dynamic> _days = [
    [1, 'Fri'],
    [2, 'Sat'],
    [3, 'Sun'],
    [4, 'Mon'],
    [5, 'Tue'],
    [6, 'Wed'],
    [7, 'Thu'],
    [8, 'Fri'],
    [9, 'Sat'],
    [10, 'Sun'],
    [11, 'Mon'],
    [12, 'Tue'],
    [13, 'Wed'],
    [14, 'Thu'],
    [15, 'Fri'],
    [16, 'Sat'],
    [17, 'Sun'],
    [18, 'Mon'],
    [19, 'Tue'],
    [20, 'Wed'],
    [21, 'Thu'],
    [22, 'Fri'],
    [23, 'Sat'],
    [24, 'Sun'],
    [25, 'Mon'],
    [26, 'Tue'],
    [27, 'Wed'],
    [28, 'Thu'],
    [29, 'Fri'],
    [30, 'Sat'],
    [31, 'Sun']
  ];

  final List<String> _hours = <String>[
    '08:00AM-11:00AM',
    '11:00AM-02:00PM',
    '02:00PM-05:00PM',
    '05:00PM-08:00PM',
    '08:00PM-11:00PM',
  ];

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () {
      _scrollController.scrollTo(
        index: 24,
        duration: Duration(seconds: 3),
        curve: Curves.easeInOut,
      );
    });
    print("object");
    print(name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "before",
                onPressed: () {
                  print(name);
                  print(category);
                  print(address);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              servicesPage(name, address, category)));
                },
                child: Icon(Icons.navigate_before),
                backgroundColor: Color(0xffE63220),
              ),
              // FloatingActionButton(
              //   heroTag: "next",
              //   onPressed: () {
              //     print(widget.name);
              //     print(address);
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) =>
              //             DateAndTime(name, address, category,service),
              //       ),
              //     );
              //   },
              //   // ignore: sort_child_properties_last
              //   child: const Icon(Icons.navigate_next),
              //   backgroundColor: const Color(0xffE63220),
              // )
            ],
          ),
        ),
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(153.0), // here the desired height
          child: AppBar(
            backgroundColor: const Color(0xffF8C80E),
            flexibleSpace: const Image(
              image: AssetImage('assets/logo3.png'),
              fit: BoxFit.none,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                  child: FadeAnimation(
                1,
                Padding(
                  padding: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
                  child: Text(
                    'Select Date \nand Time',
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                FadeAnimation(
                    1,
                    Row(
                      children: [
                        const Text("October 2022"),
                        const Spacer(),
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            color: Colors.grey.shade700,
                          ),
                        )
                      ],
                    )),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(width: 1.5, color: Colors.grey.shade200),
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _days.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FadeAnimation(
                            (1 + index) / 6,
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected_d = _days[index];
                                  print(selected_d);
                                  _selectedDay = _days[index][0];
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: 62,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: _selectedDay == _days[index][0]
                                      ? Colors.blue.shade100.withOpacity(0.5)
                                      : Colors.blue.withOpacity(0),
                                  border: Border.all(
                                    color: _selectedDay == _days[index][0]
                                        ? Colors.blue
                                        : Colors.white.withOpacity(0),
                                    width: 1.5,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _days[index][0].toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      _days[index][1],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                FadeAnimation(
                    1.2,
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border:
                            Border.all(width: 1.5, color: Colors.grey.shade200),
                      ),
                      child: ScrollablePositionedList.builder(
                          itemScrollController: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: _hours.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected_h = _hours[index];
                                  print(selected_h);
                                  _selectedHour = _hours[index];
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: _selectedHour == _hours[index]
                                      ? Colors.orange.shade100.withOpacity(0.5)
                                      : Colors.orange.withOpacity(0),
                                  border: Border.all(
                                    color: _selectedHour == _hours[index]
                                        ? Colors.orange
                                        : Colors.white.withOpacity(0),
                                    width: 1.5,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _hours[index],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 100.0),
                  child: MaterialButton(
                      minWidth: 150.0,
                      height: 50.0,
                      color: const Color(0xffF8C80E),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Color(0xffF8C80E),
                              width: 2,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50)),
                      child: const Text('Submit',
                          style: TextStyle(
                              color: Color(0xffE63220),
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      onPressed: () {
                        List<String> add = address.split(",");
                        List<String> time = [];
                        time.add(selected_d[0].toString() +
                            " / " +
                            selected_d[1].toString());
                        time.add(selected_h);
                        print(time);
                        print("ok");
                        print(add);

                        AuthService()
                            .addOrder(name, add, category, service, time)
                            .then(
                          (val) {
                            Fluttertoast.showToast(
                                msg: val.data['msg'],
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SelectService(name: name)));
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
