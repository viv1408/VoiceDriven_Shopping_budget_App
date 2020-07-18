import 'package:flutter/material.dart';
import 'places_page.dart';
import 'data/order-data.dart';
import 'widgets/order-card.dart';
import 'models/orders.dart';

class OrderHistory extends StatefulWidget {

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
 final List<Orders> order = Orderdata.getOrders();
  
  Widget _buildOrderList() {
    return Container(
      child:order.length>0
      ? ListView.builder(
        itemCount:order.length,
        itemBuilder:(BuildContext context,int index){
          return Dismissible(
            onDismissed:(DismissDirection direction){
              setState(() {
                order.removeAt(index);
              });
            },
            secondaryBackground:Container(
              child:Center(
                child:Text(
                  'Delete',
                  style:TextStyle(color:Colors.white),
                ) ,),
                color:Colors.red,
            ),
            background:Container(),
            child:OrderCard(order : order[index]),
            key:UniqueKey(),
            direction:DismissDirection.endToStart,
          );
        },
      )
      :Center(child:Text('no items')),
    );
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text('order history'),
      ) ,
      body:_buildOrderList(),
      );
  }
}