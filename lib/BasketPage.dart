import 'package:final_project/HomePage.dart';
import 'package:final_project/Robot.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BasketPage extends StatefulWidget {
  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    var central = Provider.of<MyStore>(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("Shopping Cart"),
          actions: [
            IconButton(
              icon: Icon(Icons.delete), onPressed: () { central.clearBasket(); },
            )
          ],
        ),
        persistentFooterButtons: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text ("Subtotal " + central.getBasketTotal().toString() + " Baht",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.blue
              ),),
              SizedBox (
                width: 50,
              ),
              RaisedButton(
                color: Colors.blueAccent,
                onPressed: () {
                  print(central.loginuser.cusId);
                  central.baskets.customerId = central.loginuser.cusId;
                central.makeOrder();
                central.clearBasket();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context) => HomePage()
                ), (route) => false);
                },
                child: Text("Purchase"),
              ),
            ],
          )
        ],
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: central.baskets.orderFoods.length,
                  itemBuilder: (context, index){
                return Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    width: w,
                    height: h*0.13,
                    child: ListTile(

                      trailing: Text("x"+central.baskets.orderFoods[index].quantity.toString()),
                      title: Text(central.baskets.orderFoods[index].food.name),
                      subtitle: Text("Total: " + (central.baskets.orderFoods[index].quantity*central.baskets.orderFoods[index].food.price).toString() + " Baht"),
                      leading: Container(
                        width: w*0.2,
                        height: h * .60,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(central.baskets.orderFoods[index].food.image), fit:BoxFit.scaleDown )
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ));
  } } //ec
