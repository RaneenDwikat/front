import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/screens/services.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter_app/screens/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/screens/index.dart';
import 'package:flutter_app/screens/map.dart';
import 'package:flutter_app/screens/signupworker.dart';
import 'package:flutter_app/services/authservice.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SelectService extends StatefulWidget {
  var name;

  SelectService({this.name});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _SelectServiceState createState() => _SelectServiceState(name);
}

class _SelectServiceState extends State<SelectService> {
  var name, address;
  _SelectServiceState(this.name);
  getcat service = new getcat();
  var selectedcat;
  var n = 0;
  int selectedService = -1;
  var txt = TextEditingController();
  @override
  void initState() {
    service.getAllCategory();
    super.initState();
    setState(() {});
    setaddress();
  }

  setaddress() async {
    AuthService().getlocation(name).then((val) {
      address = val.data['msg'];
      txt.text = address;
    });
  }

  gridview(AsyncSnapshot<dynamic> snapshot) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GridView.count(
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          crossAxisCount: 2,
          childAspectRatio: 2,
          children: snapshot.data.map((service) {
            return GestureDetector(
                child: const GridTile(
                  child: Text("dymmy"),
                ),
                onTap: () {});
          })),
    );
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
                heroTag: "btn1",
                onPressed: () {
                  print(name);
                  print(address);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Icon(Icons.navigate_before),
                backgroundColor: Color(0xffE63220),
              ),
              FloatingActionButton(
                heroTag: "next",
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              servicesPage(name, address, selectedcat)));
                },
                child: Icon(Icons.navigate_next),
                backgroundColor: Color(0xffE63220),
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xffE63220),
          title: Text('Hello , $name'),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications),
            ),
            //  IconButton(
            //  onPressed: () {},
            //  icon: Icon(Icons.more_vert),
            //   ),
            /* TextButton(
              onPressed: () {},
              child: const Text('Action 2'),
            )*/
          ],
        ),
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                // <-- SEE HERE

                decoration: BoxDecoration(
                    color: const Color(0xffE63220),
                    image: DecorationImage(
                      image: AssetImage("assets/logo3.png"),
                      scale: 2.3,

                      // fit: BoxFit.fill,

                      alignment: FractionalOffset.center,
                    )),

                accountName: Text(
                  "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                accountEmail: Text(
                  "services at your fingertips",
                  style: TextStyle(
                    height: 4,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                //   currentAccountPicture: FlutterLogo(),
              ),
              ListTile(
                leading: Icon(
                  Icons.account_circle,
                ),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.shopping_cart,
                ),
                title: const Text('Bookings'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.home_repair_service,
                ),
                title: const Text('sign up as a service provider'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupWPage()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.help,
                ),
                title: const Text('Help'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                ),
                title: const Text('Log out'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        ),
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                    child: FadeAnimation(
                  1.2,
                  Padding(
                    padding:
                        EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
                    child: TextField(
                      controller: txt,
                      readOnly: true,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Map(
                                      name: name,
                                    )));
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: new BorderSide(color: Color(0xffF8C80E)),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            print(name);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Map(
                                          name: name,
                                        )));
                          },
                          icon: Icon(Icons.location_pin),
                          color: Color(0xffE63220),
                          iconSize: 35.0,
                        ),
                        hintText: "address",
                      ),
                    ),
                  ),
                )),
                SliverToBoxAdapter(
                    child: FadeAnimation(
                  1.2,
                  Padding(
                    padding:
                        EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
                    child: Text(
                      'Which service \ndo you need?',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ))
              ];
            },
            body: FutureBuilder<List>(
              future: service.getAllCategory(),
              builder: (context, snapshot) {
                //  print(snapshot.data);
                if (snapshot.hasData) {
                  // print(snapshot.data![0]['name']);

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
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  ),
                                ),
                              ),
                              GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.0,
                                  crossAxisSpacing: 20.0,
                                  mainAxisSpacing: 20.0,
                                ),
                                physics: NeverScrollableScrollPhysics(),
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
                                          selectedcat =
                                              snapshot.data![index]['name'];
                                          //print(selectedcat);
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
                                                  : Color(0xffF8C80E)
                                                      .withOpacity(0),
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Image.asset(
                                                    snapshot.data![index]
                                                        ['image'],
                                                    height: 60),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  snapshot.data![index]['name'],
                                                  style:
                                                      TextStyle(fontSize: 20),
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
            )));
  }

  serviceContainer(String img, String name, int index) {
    print(name);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedService == index)
            selectedService = -1;
          else {
            selectedService = index;
          }
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(img, height: 60),
              SizedBox(
                height: 20,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 20),
              )
            ]),
      ),
    );
  }
}

//CleaningPage() {}
