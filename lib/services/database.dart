import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sofrwere_project/Admin/all_orders.dart';

class DatabaseMethods{
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addAllVehicles(Map<String, dynamic> userInfoMap,) async {
    return await FirebaseFirestore.instance
        .collection("Vehicles")
        .add(userInfoMap);
  }

  Future AddVehicle(Map<String, dynamic> userInfoMap, String categoryname) async {
    return await FirebaseFirestore.instance
        .collection(categoryname)
        .add(userInfoMap);
  }

  Future<void> deleteVehicle(String id) async {
  await FirebaseFirestore.instance.collection('vehicles').doc(id).delete();
}

  updateStatus(String id) async {
    return await FirebaseFirestore.instance
        .collection("Orders").doc(id)
        .update({"Status":"Confirmed. Thank you!"});
  }



  Future<Stream<QuerySnapshot>>getVehicles(String category)async{
    return await FirebaseFirestore.instance.collection(category).snapshots();
    
  }
  Future<Stream<QuerySnapshot>> getAllVehicles() async {
    return FirebaseFirestore.instance.collection("Vehicles").snapshots();
  }


  Future<Stream<QuerySnapshot>>allOrders()async{
    return await FirebaseFirestore.instance.collection("Orders").where("Status",isEqualTo:"Wait for confirmation").snapshots();
    
  }


   Future<Stream<QuerySnapshot>>getOrders(String email)async{
    return await FirebaseFirestore.instance.collection("Orders").where("Email",isEqualTo: email).snapshots();
    
  }

  Future orderDetails(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("Orders")
        .add(userInfoMap);
  }

  Future<QuerySnapshot>search(String updatedname)async{
    return await FirebaseFirestore.instance.collection("Vehicles").where("SearchKey",isEqualTo: updatedname.substring(0,1).toUpperCase()).get();
  }
  
}


