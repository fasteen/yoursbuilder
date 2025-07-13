import 'package:flutter/material.dart';

class ServicePage extends StatefulWidget{

  @override
  State<ServicePage> createState()=> ServicePageState();
}

class ServicePageState extends State<ServicePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Welcom to page of Service"),),
    );
  }
}