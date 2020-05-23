import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class Store extends StatefulWidget {
  Store({Key key}) : super(key: key);

  //final String title;

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  Future _getProducts() async {
    //Inicializacion de API
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
      url: "https://dev-fujartestore.pantheonsite.io", 
      consumerKey: "ck_b5e36b87949bb47c360d3efb606f1a9ea6d65895", 
      consumerSecret: "cs_e0598359d0644833906fecb6b375bb60c3f3dbae");

      var products = await wooCommerceAPI.getAsync("products");
      return products;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Title"),
      ),*/
      body: FutureBuilder(
        future: _getProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // Create a list of products
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    child:
                        Image.network(snapshot.data[index]["images"][0]["src"]),
                  ),
                  title: Text(snapshot.data[index]["name"]),
                  subtitle:
                      Text("Buy now for \$ " + snapshot.data[index]["price"]),
                );
              },
            );
          }

          // Show a circular progress indicator while loading products
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}