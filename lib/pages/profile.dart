import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:sofrwere_project/pages/onboarding.dart';
import 'package:sofrwere_project/services/auth.dart';
import 'package:sofrwere_project/services/shared_pref.dart';
import 'package:sofrwere_project/widget/support_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? image, name, email;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  getthesharedpref() async {
    image = await SharedPreferenceHelper().getUserImage();
    name = await SharedPreferenceHelper().getUserName();
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  @override
  void initState() {
    getthesharedpref();
    super.initState();
  }

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    uploadItem();
    setState(() {});
  }

  uploadItem() async {
    if (selectedImage != null) {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImage").child(addId);

      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      var dowloadUrl = await (await task).ref.getDownloadURL();

      await SharedPreferenceHelper().saveUserImage(dowloadUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff2f2f2),
        title: Center(
          child: Text(
            "Profile",
            style: AppWidget.boldTextFeildStyle(),
          ),
        ),
      ),
      backgroundColor: const Color(0xfff2f2f2),
      body: name == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Column(
                children: [
                  selectedImage!=null? GestureDetector(
                    onTap: (){
                      getImage();
                    },
                    child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                              selectedImage!,
                              height: 150.0,
                              width: 150.0,
                              fit: BoxFit.cover,
                                ),
                        )),
                  )
                  :GestureDetector(
                    onTap: (){
                      getImage();
                    },
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          image!,
                          height: 150,
                          width:150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                Container(
                  margin: EdgeInsets.only(left: 20.0,right: 20.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 3.0,
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 10,bottom:10 ),
                      width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white,),
                    child: Row(children: [
                      Icon(Icons.person_2_outlined,size: 35.0,),
                      SizedBox(width:10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name",style: AppWidget.lightTextFeildStyle(),),
                        Text(name!,style: AppWidget.semiboldTextFeildStyle(),),
                      ],
                      
                    )],),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                  margin: EdgeInsets.only(left: 20.0,right: 20.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 3.0,
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 10,bottom:10 ),
                      width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white,),
                    child: Row(children: [
                      Icon(Icons.mail_outline,size: 35.0,),
                      SizedBox(width:10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email",style: AppWidget.lightTextFeildStyle(),),
                        Text(email!,style: AppWidget.semiboldTextFeildStyle(),),
                      ],
                      
                    )],),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                GestureDetector(
                  onTap: ()async{
                    await AuthMethods().SignOut().then((value){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Onboarding()));
                    });
                    
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20.0,right: 20.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 3.0,
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 10,bottom:10 ),
                        width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.white,),
                      child: Row(children: [
                        Icon(Icons.logout_outlined,size: 35.0,),
                        SizedBox(width:10.0),
                        Text("Log Out",style: AppWidget.semiboldTextFeildStyle(),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined)
                        ],),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                GestureDetector(
                  onTap: ()async {
                    await AuthMethods().deleteuser().then((value){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Onboarding(),));
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20.0,right: 20.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 3.0,
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 10,bottom:10 ),
                        width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.white,),
                      child: Row(children: [
                        Icon(Icons.delete_outline,size: 35.0,),
                        SizedBox(width:10.0),
                        Text("Delete Account",style: AppWidget.semiboldTextFeildStyle(),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined)
                        ],),
                      ),
                    ),
                  ),
                ),
                

                ],
              ),
            ),
    );
  }
}