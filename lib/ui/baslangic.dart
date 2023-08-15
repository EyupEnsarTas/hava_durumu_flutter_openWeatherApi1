import 'package:flutter/material.dart';
import 'package:hava_durumu/models/tasarim.dart';
import 'package:hava_durumu/ui/welcome.dart';

class Baslangic extends StatefulWidget {
  const Baslangic({super.key});

  @override
  State<Baslangic> createState() => _BaslangicState();
  
}

class _BaslangicState extends State<Baslangic> {

 
 
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor:birincilRenk,
         appBar: AppBar(
          backgroundColor: ikincilRenk.withOpacity(0.5),
          centerTitle: true,
          title: Text(' Hoş Geldiniz '),
          titleTextStyle: TextStyle(
            color: Colors.green,
            fontSize: 18,
            fontWeight: FontWeight.w600
          ),
         ),


          body: Container(
            width: size.width,
            height: size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/get-started.png'),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => Welcome(), ));
                    },
                     child: Container(
                  height: 50,
                  width: size.width * 0.7,
                  decoration:  BoxDecoration(
                    color:ikincilRenk,
                    borderRadius:  BorderRadius.all(Radius.circular(10)),
                  ),
                  child:  Center(
                    child:Text('TIKLA', style: TextStyle(color:birincilRenk, fontSize: 18,), )
                  ),
                ),
                    
                  )

                ],
              ),
            ),
          ),
    );
  }
}