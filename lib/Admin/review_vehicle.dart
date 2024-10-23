import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sofrwere_project/pages/vehicle_detail.dart';
import 'package:sofrwere_project/services/database.dart';
import 'package:sofrwere_project/widget/support_widget.dart';

class ReviewVehicle extends StatefulWidget {
  const ReviewVehicle({super.key});

  @override
  State<ReviewVehicle> createState() => _ReviewVehicleState();
}

class _ReviewVehicleState extends State<ReviewVehicle> {
  Stream? vehicleStream;

  // Fetch the vehicles from the database
  getontheload() async {
    vehicleStream = await DatabaseMethods().getAllVehicles();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getontheload();
  }

  Widget allVehicle() {
    return StreamBuilder(
      stream: vehicleStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return const Center(child: Text('No vehicles available.'));
        }

        return ListView.builder(
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
                          // Navigate to vehicle details
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
                          child: const Icon(Icons.details, color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // Confirm deletion
                          bool confirmDelete = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Delete Vehicle'),
                                content: const Text('Are you sure you want to delete this vehicle?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );

                          if (confirmDelete) {
                            // Call delete method
                            await DatabaseMethods().deleteVehicle(ds.id);
                            // Refresh the vehicle list
                            getontheload();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFfd6f3e),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Icon(Icons.delete_forever, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "All Vehicle",
            style: AppWidget.boldTextFeildStyle(),
          ),
        ),
      ),
      body: Container(
        height: 700, // Adjust height as needed
        child: Column(
          children: [
            Expanded(child: allVehicle()),
          ],
        ),
      ),
    );
  }
}
