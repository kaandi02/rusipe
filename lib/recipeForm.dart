import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rusipe_app/constants.dart';
import 'package:rusipe_app/explore.dart';
import 'package:rusipe_app/shared.dart';

class recipeForm extends StatefulWidget {
  const recipeForm({super.key});

  @override
  State<recipeForm> createState() => _recipeFormState();
}

class _recipeFormState extends State<recipeForm> {
  final db = FirebaseFirestore.instance;
  final recipeList = <String>[];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],

      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Recipe Form"),
      ),

      body: SingleChildScrollView(
        child:Form(
          key: _formKey,
          child:Column(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget> [
                  buildTextTitleVariation1('Fill you recipe details!'),
                  Text("Recipe name :"),
                  TextFormField(
                    validator: (recipeName){
                      if(recipeName==null || recipeName.isEmpty){
                        return 'enter text';
                      }
                      recipeList.add(recipeName);
                    },

                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text("Description :"),
                  TextFormField(
                    validator: (ingredients){
                      if(ingredients==null || ingredients.isEmpty){
                        return 'enter text';
                      }
                      recipeList.add(ingredients);
                    },
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text("Recipe Preparation:"),
                  TextFormField(
                    validator: (recPrep){
                      if(recPrep==null || recPrep.isEmpty){
                        return 'enter text';
                      }
                      recipeList.add(recPrep);
                    },
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text("Calories:"),
                  TextFormField(
                    validator: (Calo){
                      if(Calo==null || Calo.isEmpty){
                        return 'enter text';
                      }
                      recipeList.add(Calo);
                    },
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text("Carbo:"),
                  TextFormField(
                    validator: (Car){
                      if(Car==null || Car.isEmpty){
                        return 'enter text';
                      }
                      recipeList.add(Car);
                    },
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text("Protein:"),
                  TextFormField(
                    validator: (Pro){
                      if(Pro==null || Pro.isEmpty){
                        return 'enter text';
                      }
                      recipeList.add(Pro);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: (){
                        if (_formKey.currentState!.validate()) {
                          final data = {
                            "recipeName": recipeList[0],
                            "description": recipeList[1],
                            "recipePreparation": recipeList[2],
                            "calories": recipeList[3],
                            "carbo": recipeList[4],
                            "protein": recipeList[5]
                          };
                          print(recipeList);
                          db.collection("Recipes").add(data).then((documentSnapshot) =>
                              print("Added Data with ID: ${documentSnapshot.id}"));
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Explore()));
                        },
                      child:Text("SUBMIT") )
                ]
              )),
          ],),



        ),)

    );
  }
}
