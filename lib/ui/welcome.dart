import 'package:flutter/material.dart';
import 'package:hava_durumu/models/tasarim.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


const apiKey = '4a1a3d9495c66dc1d63f6d9b36b8cc28'; // OpenWeatherMap API anahtarınızı buraya ekleyin



Future<Map<String, dynamic>> getWeatherData(String city) async {
  final response = await http.get(Uri.parse(
    
      'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));

  if (response.statusCode == 200) {
    print(response.body);
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load weather data');
  }
}
/////


/////

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
//////////////////


String city = '';
bool loading=true;
  Map<String, dynamic> weatherData = {};

  void _getWeatherData() async {
    try {
      var data = await getWeatherData(city);
      setState(() {
        weatherData = data;

        loading=false;
        
      });
    } catch (e) {
      print(e);
    }
  }
  
  
  //rString iconlar = '${weatherData['weather'][0]['description']}';



String getFormattedDate(int? unixTimestamp) {
  if (unixTimestamp == null) {
    return "";
  }
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp! * 1000);
  String formattedDate = '${dateTime.day}.${dateTime.month}.${dateTime.year}';
  return formattedDate;
}


//////////////////
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: birincilRenk,
         title:  TextField(
         onChanged: (value) {
              city = value;
            },
            decoration: InputDecoration(
              hintText: 'Şehir adını girin',
            ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _getWeatherData,//_performSearch,
          ),
        ],
      ),




      body: loading ? Center(child: CircularProgressIndicator(),): Container(
        padding:  EdgeInsets.all(20),
        child:   Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //apideki şehri buraya atçaz 
            Text('${weatherData['name']}', style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              ),  
              ),
              //valla tarih olayı karışık ama burdan halletçez bi şekilde
              /// 
               Text('${getFormattedDate(weatherData!['dt'])}', style: TextStyle(
                ///
                color: Colors.grey,
                fontSize: 16,
              ),),
              const SizedBox(
                height: 50,
              ),
              Container(
                width: size.width,
                height: 200,
                decoration: BoxDecoration(
                  color: birincilRenk,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(
                    color: birincilRenk.withOpacity(.5),
                    offset: const Offset(0, 25),
                    blurRadius: 10,
                    spreadRadius: -12,
                  )],
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -40,
                      left: 20,
                      //alttaki imageyi ayrı bir klasörde isflicez ordan verie göre imagelicez
                      child: getWeatherIcon(weatherData['weather'][0]['icon']),
                      width: 150,
                    ),
                    Positioned(
                      bottom: 30,
                      left: 20,
                      child: Text(
                        //alttaki texte CLear gibi genel hava durmunu yazcaz
                        '${weatherData['weather'][0]['description']}',
                        style: TextStyle(
                          color: ikincilRenk,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                    ),
                    Positioned(
                      child: Text('${weatherData['main']['temp']}°C', style: TextStyle(
                        color: ikincilRenk,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                         ),),
                      top: 20,
                      right: 20,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //rüzgar hızı bu columda
                    Column(
                      children: [
                        Text('Rüzgar Hızı',style: TextStyle(
                          color: Colors.black,                          
                        ),),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 122, 226, 126),
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Image.asset('assets/windspeed.png'),  
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        //aşttaki yere rüzgar hızını yazcaz  
                         Text('${weatherData['wind']['speed']} km', style: TextStyle(fontWeight: FontWeight.bold,),)
                      ],
                    ),



                    //nem
                    Column(
                      children: [
                        const Text('Nem Oranı',style: TextStyle(
                          color: Colors.black,                          
                        ),),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 122, 226, 126),
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Image.asset('assets/humidity.png'),  
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        //aşttaki yere rüzgar hızını yazcaz  
                         Text('${weatherData['main']['humidity']}', style: TextStyle(fontWeight: FontWeight.bold,),)
                      ],
                    ),




                       //maximum sıcaklık 
                    Column(
                      children: [
                        const Text('Max Derece',style: TextStyle(
                          color: Colors.black,                          
                        ),),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 122, 226, 126),
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Image.asset('assets/max-temp.png'),  
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        //aşttaki yere rüzgar hızını yazcaz  
                         Text('${weatherData['main']['temp_max']} km', style: TextStyle(fontWeight: FontWeight.bold,),)
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Bu Gün', style: TextStyle(
                    fontWeight:FontWeight.bold, 
                    fontSize: 24,
                  ),
                  ),
                  Text('diğer günler',style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: birincilRenk
                  ),)

                ],
              ),
              const SizedBox(
                height: 10,
              ),
             Container(
              height: 110,
              width: size.width,
              color: Colors.transparent,
              child: ListView(
                scrollDirection: Axis.horizontal,
                 padding: EdgeInsets.symmetric(horizontal: 8.0),
                children: [
                  Center(
                    child: Container(
                      
                      height: 90,
                      width: 100,
                      decoration:  BoxDecoration(
                        color: birincilRenk,
                        borderRadius: BorderRadius.circular(46),
                        boxShadow: [BoxShadow(
                          color: birincilRenk.withOpacity(.5),
                          offset: const Offset(0, 10),
                          blurRadius: 10,
                          spreadRadius: -1,
                         )],
                      ),
                  
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -10,
                            
                            child: getWeatherIcon(weatherData['weather'][0]['icon']),
                            width: 50,
                            height: 50,
                            ),
                          Center(
                            child: Container(
                                 padding: EdgeInsets.all(16),
                                 child: Text('${weatherData['weather'][0]['description']}',style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ikincilRenk,
                                      fontSize: 12
                                 ),),
                              ),
                          ),
                          
                        ],
                      ),                    
                      
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                   Center(
                    child: Container(
                      
                      height: 90,
                      width: 100,
                      decoration:  BoxDecoration(
                        color: birincilRenk,
                        borderRadius: BorderRadius.circular(46),
                        boxShadow: [BoxShadow(
                          color: birincilRenk.withOpacity(.5),
                          offset: const Offset(0, 10),
                          blurRadius: 10,
                          spreadRadius: -1,
                         )],
                      ),
                  
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -10,
                            
                            child: Image.asset('assets/snow.png'),
                            width: 50,
                            height: 50,
                            ),
                          Center(
                            child: Container(
                                 padding: EdgeInsets.all(16),
                                 child: Text('snow',style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ikincilRenk,
                                      fontSize: 12
                                 ),),
                              ),
                          ),
                          
                        ],
                      ),                    
                      
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Center(
                    child: Container(
                      
                      height: 90,
                      width: 100,
                      decoration:  BoxDecoration(
                        color: birincilRenk,
                        borderRadius: BorderRadius.circular(46),
                        boxShadow: [BoxShadow(
                          color: birincilRenk.withOpacity(.5),
                          offset: const Offset(0, 10),
                          blurRadius: 10,
                          spreadRadius: -1,
                         )],
                      ),
                  
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -10,
                            
                            child: Image.asset('assets/showers.png'),
                            width: 50,
                            height: 50,
                            ),
                          Center(
                            child: Container(
                                 padding: EdgeInsets.all(16),
                                 child: Text('Showers',style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ikincilRenk,
                                      fontSize: 12
                                 ),),
                              ),
                          ),
                          
                        ],
                      ),                    
                      
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                   Center(
                    child: Container(
                      
                      height: 90,
                      width: 100,
                      decoration:  BoxDecoration(
                        color: birincilRenk,
                        borderRadius: BorderRadius.circular(46),
                        boxShadow: [BoxShadow(
                          color: birincilRenk.withOpacity(.5),
                          offset: const Offset(0, 10),
                          blurRadius: 10,
                          spreadRadius: -1,
                         )],
                      ),
                  
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -10,
                            
                            child: Image.asset('assets/lightcloud.png'),
                            width: 50,
                            height: 50,
                            ),
                          Center(
                            child: Container(
                                 padding: EdgeInsets.all(16),
                                 child: Text('cloudy',style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ikincilRenk,
                                      fontSize: 12
                                 ),),
                              ),
                          ),
                          
                        ],
                      ),                    
                      
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                   Center(
                    child: Container(
                      
                      height: 90,
                      width: 100,
                      decoration:  BoxDecoration(
                        color: birincilRenk,
                        borderRadius: BorderRadius.circular(46),
                        boxShadow: [BoxShadow(
                          color: birincilRenk.withOpacity(.5),
                          offset: const Offset(0, 10),
                          blurRadius: 10,
                          spreadRadius: -1,
                         )],
                      ),
                  
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -10,
                            
                            child: Image.asset('assets/lightrain.png'),
                            width: 50,
                            height: 50,
                            ),
                          Center(
                            child: Container(
                                 padding: EdgeInsets.all(16),
                                 child: Text('light rain',style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ikincilRenk,
                                      fontSize: 12
                                 ),),
                              ),
                          ),
                          
                        ],
                      ),                    
                      
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
             ),

          ],
        ),
      )
    );
  }
}