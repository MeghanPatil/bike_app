import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'BikeData.dart';

class JsonImageList extends StatefulWidget {
  JsonImageListWidget createState() => JsonImageListWidget();
}

class JsonImageListWidget extends State<JsonImageList> {
  final String apiURL = 'http://192.168.225.197/bikes/getBikeList.php';
  List <BikeData>listOfBikes;
  List data;
  List imagesUrl = [];
  int _current =0;

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  Future<String> fetchDataFromApi() async {
    var jsonData = await http.get(
        'http://192.168.225.197/bikes/getBikeList.php');

    var fetchData = jsonDecode(jsonData.body);
    print(fetchData);
    setState(() {
      data = fetchData;
      print(data);
      data.forEach((element) {
        imagesUrl.add(element['bike_image_url']);
      });
    });
    print('imagesUrl::$imagesUrl');
    return "Success";
  }

  List<T> map<T>(List list,Function handler){
    List<T> result = [];
    for(var i=0;i<list.length;i++){
      result.add(handler(i,list[i]));
    }
    return result;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('List Of Images'),
        centerTitle: true,

      ),

      body:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CarouselSlider(
              height: 400,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: true,
              reverse: false,
              autoPlayInterval: Duration(seconds: 2),
              enableInfiniteScroll: false,
              autoPlayAnimationDuration: Duration(microseconds: 2000),
              pauseAutoPlayOnTouch: Duration(seconds: 5),
              scrollDirection: Axis.horizontal,
              onPageChanged: (index){
                setState(() {
                  _current = index;
                });
              },
              items: imagesUrl.map((imgUrl){
                return Builder(
                  builder: (BuildContext context){
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.green                        
                      ),
                      child: GestureDetector(
                        child: Image.network(imgUrl,fit: BoxFit.fill),
                          onTap: () {
                            Navigator.push<Widget>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageScreen(imgUrl),
                              ),
                            );
                          }
                      ),                       
                    );
                  },
                );
            }).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(imagesUrl, (index,url){
                return Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.red : Colors.green,
                ),
                );
            }),
            ),
          ],
        ),
      ),

    );
  }
}

class ImageScreen extends StatefulWidget {
  final String url;

  ImageScreen(this.url);

  ImageScreenWidget createState() => ImageScreenWidget(url);
}

class ImageScreenWidget extends State<ImageScreen>{
 final String url;
  ImageScreenWidget(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Container(
      width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
              color: Colors.green
          ),

            child: Image.network(url,fit: BoxFit.fill),
          ),
      SizedBox(
        height:20
      ),
      ],
    )
      )
    );
  }
}

