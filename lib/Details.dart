import 'package:final_project/FoodItem.dart';
import 'package:final_project/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Robot.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {

    var central = Provider.of<MyStore>(context);
    FoodItem activeFood = central.activeFood;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text("Dessert Details"),
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0.16 * h,
              width: w,
              height: h / 1.36,
              left: 0,
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(70),
                          topRight: Radius.circular(70))),
                  child: Padding(
                    padding: const EdgeInsets.only(top:100.0, bottom: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            activeFood.name, style: TextStyle(
                              fontSize: 30
                          ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("Price: " + activeFood.price.toString() ,style: TextStyle( fontSize: 20),),
                            Container(
                              color: Colors.black,
                              width: 1,
                              height: 30,
                            ),
                            Container(
                              width: 170,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(200)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                        Icons.remove
                                    ), onPressed: () {
                                      setState(() {
                                        if(quantity >1){
                                          quantity-=1;
                                        }

                                      });
                                  },
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(5),
                                    width: 30,
                                    height: 100,
                                    child: Text(
                                      quantity.toString() ,//qty
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                        Icons.add
                                    ), onPressed: () {
                                      setState(() {
                                        quantity+=1;

                                      });
                                  },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          height:  150,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(2),
                                height: 50,
                                width: w*0.35,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.all(Radius.circular(25))
                                ),
                              ),Container(
                                margin: EdgeInsets.all(2),
                                height: 50,
                                width: w*0.35,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.all(Radius.circular(25))
                                ),
                              ),Container(
                                margin: EdgeInsets.all(2),
                                height: 50,
                                width: w*0.35,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.all(Radius.circular(25))
                                ),
                              ),Container(
                                margin: EdgeInsets.all(2),
                                height: 50,
                                width: w*0.35,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.all(Radius.circular(25))
                                ),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          width: w,
                          height: 60,
                          color: Colors.blue,
                          child: RaisedButton(
                            color: Colors.blueGrey,
                            onPressed: () {
                              central.addOneToBasket(activeFood, quantity);

                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                builder: (context) => HomePage()
                              ), (route) => false);
                            },
                            child: Text(
                              "Add to basket", style: TextStyle(
                              color:Colors.white,
                              fontSize: 20,
                            ),
                            ),
                          ),
                        )

                      ],
                    ),
                  )
              ),
            ),
            Positioned(
              top: h*0.02,
              left: w/4,
              child:  Container(

                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            activeFood.image
                        )
                        ,fit: BoxFit.cover
                    )
                ),
              ),
            )
          ],
        ));
  } } //ec
