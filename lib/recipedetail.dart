import 'package:flutter/material.dart';
import 'package:rusipe_app/constants.dart';
import 'package:rusipe_app/shared.dart';

class recipeDetail extends StatefulWidget {

  var recipe;

  recipeDetail({
    this.recipe
  });

  @override
  State<recipeDetail> createState() => _recipeDetailState();
}

class _recipeDetailState extends State<recipeDetail> {
  @override
  Widget build(BuildContext context) {
    print(widget.recipe);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  buildTextTitleVariation1(widget.recipe["recipeName"]),

                  buildTextSubTitleVariation1(widget.recipe["description"]),

                ],
              ),
            ),

            SizedBox(
              height: 16,
            ),

            Container(
              height: 310,
              padding: EdgeInsets.only(left: 16),
              child: Stack(
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      buildTextTitleVariation2('Nutritions', false),

                      SizedBox(
                        height: 16,
                      ),

                      buildNutrition(widget.recipe["calories"], "Calories", "Kcal"),

                      SizedBox(
                        height: 16,
                      ),

                      buildNutrition(widget.recipe["carbo"], "Carbo", "g"),

                      SizedBox(
                        height: 16,
                      ),

                      buildNutrition(widget.recipe["protein"], "Protein", "g"),

                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 16,),

                  buildTextTitleVariation2('Recipe preparation', false),

                  buildTextSubTitleVariation1(widget.recipe["recipePreparation"]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildNutrition(String value, String title, String subTitle){
    return Container(
      height: 60,
      width: 150,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        boxShadow: [kBoxShadow],
      ),
      child: Row(
        children: [

          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
              boxShadow: [kBoxShadow],
            ),
            child: Center(
              child: Text(
                value.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(
            width: 20,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                subTitle,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[400],
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}
