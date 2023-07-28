import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rusipe_app/constants.dart';
import 'package:rusipe_app/recipedetail.dart';

class userPro extends StatefulWidget {
  const userPro({super.key});
  @override
  State<userPro> createState() => _userProState();
}

class _userProState extends State<userPro> {

  final Stream<QuerySnapshot> snapStream = FirebaseFirestore.instance.collection('Recipes').snapshots();

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: snapStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text("User Recipes"),
          ),

          body: SingleChildScrollView(
              child: Column(
                children: snapshot.data!.docs.map((DocumentSnapshot documentSnapshot){
                  Map data=documentSnapshot.data() as Map<String,dynamic>;
                  print(data);
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> recipeDetail(recipe: data,)));
                    },
                    child: Container(
                      child: Text(data["recipeName"]),
                      height: 80,
                      width: 400,
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        boxShadow: [kBoxShadow],
                      ),
                    ),
                  );
                }).toList()
              )
          ),
        );
      },
    );
  }
}
