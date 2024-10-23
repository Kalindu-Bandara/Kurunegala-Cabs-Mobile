import 'package:flutter/material.dart';
import 'package:sofrwere_project/Admin/add_vehicle.dart';
import 'package:sofrwere_project/Admin/all_orders.dart';
import 'package:sofrwere_project/Admin/review_vehicle.dart';
import 'package:sofrwere_project/widget/support_widget.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: Color(0xfff2f2f2),
        title: Center(
          child: Text(
            "Home Admin",
            style: AppWidget.boldTextFeildStyle(),
          ),
        ),
      ),
      body: Container(
        margin:EdgeInsets.only(left: 20,right: 20),
        child:Column(
        children: [
          SizedBox(height: 50.0,),
          GestureDetector(
            onTap:(){
              Navigator.push(context,MaterialPageRoute(builder: (context) => AddVehicle(),));
            },
            child: Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(10),
            child:Container(
              padding: EdgeInsets.only(top:10.0,bottom:10.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.add,size: 50,),
              SizedBox(height: 30,),
              Text("Add Vehicles",style: AppWidget.boldTextFeildStyle(),)],
            ),
                    )),
          ),
        SizedBox(height: 80.0,),
          GestureDetector(
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => AllOrders(),));
            },
            child: Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(10),
            child:Container(
              padding: EdgeInsets.only(top:10.0,bottom:10.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.shopping_bag_outlined,size: 50,),
              SizedBox(width: 30,),
              Text("All Orders",style: AppWidget.boldTextFeildStyle(),)],
            ),
                    )),
          ),
          SizedBox(height: 80.0,),
          GestureDetector(
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => ReviewVehicle(),));
            },
            child: Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(10),
            child:Container(
              padding: EdgeInsets.only(top:10.0,bottom:10.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.reviews_outlined,size: 50,),
              SizedBox(width: 30,),
              Text("Review Vehicle",style: AppWidget.boldTextFeildStyle(),)],
            ),
                    )),
          ),
        ],
      ) ,),
    );
  }
}