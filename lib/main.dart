import 'package:flutter/material.dart';
import 'Animated_Window.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'main'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  animation(){
    if(isPressed==true)
      return window();
    else
      return Container();
  }

  Widget Button_Open(){
    return ElevatedButton(
        onPressed: (){
          setState(() {
            isReverse=false;
            isPressed=true;
          });
        },
        child: Text("Open")
    );
  }


  bool isPressed=false;
  bool isReverse=false;

  Animated_Window window(){
    return Animated_Window(
      height: 200,
      width: MediaQuery.of(context).size.width,
      color: Colors.purple,
      borderColor: Colors.black,
      borderWidth: 5,
      borderRadius: BorderRadius.only(topLeft:Radius.circular(30) ,topRight:Radius.circular(30) ,bottomLeft:Radius.circular(0) ,bottomRight:Radius.circular(0)),
      alignment: Alignment.bottomCenter,
      animationDuration: Duration(seconds: 1),
      isReverse: isReverse,
      scale: false,
      child: Stack(
        children: [
          Align(alignment: Alignment.topLeft,child:
          SizedBox(
            child: MaterialButton(
              onPressed: (){
                setState(() {
                  isReverse=true;
                });
              },
              child: Icon(Icons.cancel_outlined,size: 23),
            ),
          )
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        animation(),
        Align(alignment: Alignment.center,child: Button_Open(),),
      ],),
    );
  }
}
