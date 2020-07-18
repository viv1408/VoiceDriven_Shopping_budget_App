import '../models/orders.dart';
import 'package:flutter/material.dart';

double val;
String vala;
double cur;
String curr;
double bud;
String budg;

class OrderCard extends StatelessWidget{
  final Orders order;

  OrderCard({this.order});


 @override
  Widget build(BuildContext Context) {
    return Card(
      child: Column(
        children:<Widget>[
          ListTile(
            title: Text(order.shopname),
            subtitle: Text('Spent:'+'${order.currspend}'+' '+'Budget:'+'${order.budget}',
            style: TextStyle(color:Colors.blueAccent),),
            trailing: Text('${order.budget-order.currspend}',
            style: TextStyle(
              color: (order.budget-order.currspend)<0?Colors.red:Colors.green
            ) 
                        
            ),
          )
        ],
      ),
    );
  }
}