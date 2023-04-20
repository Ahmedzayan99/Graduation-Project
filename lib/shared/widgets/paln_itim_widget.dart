import 'package:flutter/material.dart';
class NEWScreen extends StatefulWidget {
  const NEWScreen({Key? key}) : super(key: key);

  @override
  State<NEWScreen> createState() => _NEWScreenState();
}

class _NEWScreenState extends State<NEWScreen> {

  bool value=false;
  bool Value=false;
  bool _value=false;
  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),color: Colors.black45

          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundImage: AssetImage('assets/images/abdominal muscles.png'),radius: 50,),
                  Transform.scale(scale: 1.7,child: Checkbox(value: value, onChanged: ( value){

                  } ,activeColor: Colors.blueAccent
                  ),
                  ),
                  Transform.scale(scale: 1.7,child: Checkbox(value: Value, onChanged: (Value){

                  }),),
                  Transform.scale(scale: 1.7,child: Checkbox(value: _value, onChanged: ( _value){


                  }),)



                ],),
              Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  title: Text('SET 1',style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800),),
                  onTap: (){
                    setState(() {
                      value=! value;
                    });
                  },
                ),),
              Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(


                  title: Text('SET 2',style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800),),
                  onTap: (){
                    setState(() {
                      Value=! Value;
                    });
                  },
                ),),
              Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(

                  title: Text('SET 3',style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800),),
                  onTap: (){
                    setState(() {
                      _value=! _value;
                    });
                  },
                ),),
            ],
          ),);


  }
}

/*    Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("images/back.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListView(
              padding: EdgeInsets.only(left: 20,top: 100,right: 20),
              children: [
                Container(padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),color: Colors.tealAccent

                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(backgroundImage: AssetImage('images/gym.jpg'),radius: 50,),
                          Transform.scale(scale: 1.7,child: Checkbox(value: value, onChanged: ( value){


                          } ,activeColor: Colors.blueAccent
                          ),
                          ),
                          Transform.scale(scale: 1.7,child: Checkbox(value: Value, onChanged: (Value){

                          }),),
                          Transform.scale(scale: 1.7,child: Checkbox(value: _value, onChanged: ( _value){


                          }),)



                        ],),
                      Card(
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(

                          title: Text('SET 1',style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800),),
                          onTap: (){
                            setState(() {
                              value=! value;
                            });
                          },
                        ),),
                      Card(
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(


                          title: Text('SET 2',style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800),),
                          onTap: (){
                            setState(() {
                              Value=! Value;
                            });
                          },
                        ),),
                      Card(
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(

                          title: Text('SET 3',style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800),),
                          onTap: (){
                            setState(() {
                              _value=! _value;
                            });
                          },
                        ),),
                    ],
                  ),)
              ],
            ),
          ],
        ));*/