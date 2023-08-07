import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:rusipe_app/constants.dart';
import 'package:rusipe_app/data.dart';
import 'package:rusipe_app/detail.dart';
import 'package:rusipe_app/shared.dart';
import 'package:rusipe_app/recipeForm.dart';
import 'package:rusipe_app/userProfile.dart';
class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {

  List<bool> optionSelected = [true,false,false];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[50],

      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: Icon(
          Icons.sort_sharp,
          color: Colors.white,
        ),
        actions: [

          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => recipeForm() ));
            },
            child: Padding(
              padding: EdgeInsets.only(right:16),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => userPro() ));
            },
            child: Padding(
              padding: EdgeInsets.only(right:16),
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    height: 20,
                  ),

                  buildTextTitleVariation1('Rusipe'),
                  buildTextSubTitleVariation1('Get ready with your tastebuds'),

                  SizedBox(
                    height: 32,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      option('Vegetable', 'assets/icons/salad.png', 0),

                      SizedBox(
                        width:10,
                      ),
                      option('Rice', 'assets/icons/rice.png', 1),

                      SizedBox(
                        width: 8,
                      ),
                      option('Fruit', 'assets/icons/fruit.png', 2),

                    ],
                  ),

                ],
              ),
             ),

            SizedBox(
              height: 24,
            ),

            Container(
              height: 350,
              child: ListView(
               physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: buildRecipes(),
              ),
            ),

            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  
                  buildTextTitleVariation2('Popular', false),
                  
                  SizedBox(
                    width: 8,
                  ),
                  /*buildTextTitleVariation2('Food', false),*/
                ],
              ),
            ),

            Container(
              height: 200,
              child: PageView(
                physics: BouncingScrollPhysics(),
                children: buildPopulars(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget option(String text, String image, int index){
    return GestureDetector(
      onTap: () {
        setState(() {
          for(var i=optionSelected.length-1;i>=0;i--){
            optionSelected[i]=false;
          }
          optionSelected[index] = !optionSelected[index];
        });
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: optionSelected[index] ? kPrimaryColor : Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [kBoxShadow],
        ),
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [

            SizedBox(
              height: 32,
              width: 32,
              child: Image.asset(
                image,
                color: optionSelected[index] ? Colors.white : Colors.black,
              ),
            ),

            SizedBox(
              width: 8,
            ),

            Text(
              text,
              style: TextStyle(
                color: optionSelected[index] ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: optionSelected[index] ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildRecipes(){
    List<Widget> list = [];
    for (var i = 0; i < getRecipes().length; i++) {
      list.add(buildRecipe(getRecipes()[i], i));
    }
    return list;
  }

  Widget buildRecipe(Recipe recipe, int index){
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(recipe: recipe)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [kBoxShadow],
        ),
        margin: EdgeInsets.only(right: 25, left: index == 0 ? 25 : 0, bottom: 25, top: 8),
        padding: EdgeInsets.all(15),
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Expanded(

                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(recipe.image),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),


            SizedBox(
              height: 8,
            ),

            buildRecipeTitle(recipe.title),

            buildTextSubTitleVariation2(recipe.description),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                buildCalories(recipe.calories.toString() + " Kcal"),

                GestureDetector(
                  onTap: (){

                  },
                    child: Icon(
                    Icons.favorite_border,
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

  List<Widget> buildPopulars(){
    List<Widget> list = [];
    for (var i = 0; i < getPopular().length; i++) {
      list.add(buildPopular(getPopular()[i],i));
    }
    return list;
  }

  Widget buildPopular(Recipe recipe,int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(recipe: recipe)),
        );
      },
      child: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [kBoxShadow],
        ),
        child: Row(
          children: [
            Hero(
              tag: recipe.image,
              child:
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(recipe.image),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
            ),


            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    buildRecipeTitle(recipe.title),

                    buildRecipeSubTitle(recipe.description),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        buildCalories(recipe.calories.toString() + " Kcal"),

                        Icon(
                          Icons.favorite_border,
                        )

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}