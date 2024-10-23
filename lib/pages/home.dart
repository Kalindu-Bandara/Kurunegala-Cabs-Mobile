import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sofrwere_project/pages/category_Vehicle.dart';
import 'package:sofrwere_project/pages/vehicle_detail.dart';
import 'package:sofrwere_project/services/database.dart';
import 'package:sofrwere_project/services/shared_pref.dart';
import 'package:sofrwere_project/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool search = false;
  List<String> categories = [
    "images/Van.png",
    "images/SUV.png",
    "images/Car.png",
    "images/Jeep.png",
  ];


  List categoryname = [
    "Van",
    "SUV",
    "Car",
    "Jeep",

    ///these are same to the add_Vehicle.dart
  ];

  var queryResultSet = [];
  var tempSearchStore = [];
  TextEditingController searchcontroller = new TextEditingController();

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    
    setState(() {
      search = true;
    });
    var CapitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);
    if (queryResultSet.isEmpty && value.length == 1) {
      DatabaseMethods().search(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          queryResultSet.add(docs.docs[i].data());
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element["UpdateName"].startsWith(CapitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  String? name, image;
  getthesharedprefas() async {
    name = await SharedPreferenceHelper().getUserName();
    image = await SharedPreferenceHelper().getUserImage();
    setState(() {});
  }

  ontheload() async {
    await getthesharedprefas();
    setState(() {});
  }
/*
  @override
  void initState() {
    ontheload();
    super.initState();
  }*/
  
  Stream? vehicleStream;

  getontheload()async{
    vehicleStream=await DatabaseMethods().getAllVehicles();
    setState(() {
      
    });
  }

  @override
  void initState() {
    ontheload();
    getontheload();
    super.initState();
    
  }
  Widget allVehicle() {
  return StreamBuilder(
    stream: vehicleStream,
    builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasData
          ? ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        ds["Image"],
                        height: 130,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Name: " + ds["Name"],
                        style: AppWidget.semiboldTextFeildStyle(),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$" + ds["Price"],
                            style: const TextStyle(
                              color: Color(0xFFfd6f3e),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VehicleDetail(
                                    detail: ds["Detail"],
                                    image: ds["Image"],
                                    name: ds["Name"],
                                    price: ds["Price"],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFfd6f3e),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: const Icon(Icons.add, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            )
          : Container(); // Fallback when no data is available
    },
  );
}

  

  



  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        body: name == null
            ? Center(child: CircularProgressIndicator())
            : Stack(children: [
              Positioned(
            top: -50,
            right: -30,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF0000), // Pure red color for squares
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 15,
                      spreadRadius: 3,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 150,
            right: 40,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF0000),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -40,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF0000),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 3,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
              ),
            ),
          ),
              SingleChildScrollView(
                  child: Container(
                    margin:
                        const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hey, " + name!,
                                  style: AppWidget.boldTextFeildStyle(),
                                ),
                                Text(
                                  "Good Morning",
                                  style: AppWidget.lightTextFeildStyle(),
                                ),
                              ],
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                image!,
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: TextField(
                            controller: searchcontroller,
                            onChanged: (value) {
                              initiateSearch(value.toUpperCase());
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search Vehicles",
                              hintStyle: AppWidget.lightTextFeildStyle(),
                              prefixIcon: search
                                  ? GestureDetector(
                                      onTap: () {
                                        search = false;
                                        tempSearchStore = [];
                                        queryResultSet = [];
                                        searchcontroller.text = "";
                                        setState(() {});
                                      },
                                      child: Icon(Icons.close))
                                  : Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        search
                            ? ListView(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                primary: false,
                                shrinkWrap: true,
                                children: tempSearchStore.map((element) {
                                  return buildResultCard(element);
                                }).toList(),
                              )
                            : Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Categories",
                                      style: AppWidget.semiboldTextFeildStyle(),
                                    ),
                                    const Text(
                                      "See all",
                                      style: TextStyle(
                                        color: Color(0xFFfd6f3e),
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
              
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Container(
                                      height: 130,
                                      padding: const EdgeInsets.all(20),
                                      margin: const EdgeInsets.only(right: 20.0),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFfd6f3e),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "All",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: 130,
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: categories.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return CategoryTile(
                                              image: categories[index],
                                              name: categoryname[index],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "All Vehicles",
                                      style: AppWidget.semiboldTextFeildStyle(),
                                    ),
                                    const Text(
                                      "See all",
                                      style: TextStyle(
                                        color: Color(0xFFfd6f3e),
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                Container(
                                  
                                  height: 330, // Adjust height as needed
                                  child: Column(
                                    children: [
                                       Expanded(child: (allVehicle())),
                                    ],
                                  ),
                                ),
              
                                // Add some bottom padding to ensure last items are visible
                                SizedBox(height: 20.0),
                              ]),
                      ],
                    ),
                  ),
                ),
                ],
            ),
      ),
    );
  }

  Widget buildResultCard(data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VehicleDetail(
                    detail: data["Detail"],
                    image: data["Image"],
                    name: data["Name"],
                    price: data["Price"])));
      },
      child: Container(
        padding: EdgeInsets.only(left: 20.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 100,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                data["Image"],
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Text(data["Name"], style: AppWidget.semiboldTextFeildStyle())
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String image, name;
  CategoryTile({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryVehicle(category: name)));
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        height: 90,
        width: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              image,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}

class VehicleTile extends StatelessWidget {
  final String image, name;
  VehicleTile({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryVehicle(category: name)));
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        height: 90,
        width: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              image,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
