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
        url: "https://dev-efarmacia.pantheonsite.io",
        consumerKey: "ck_bc2ecd768856437896ff7a657804b76052366b29",
        consumerSecret: "cs_76161f0a6af61566169db06b0e430ba4830b865d");

    var products = await wooCommerceAPI.getAsync("products?per_page=100");
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
                  /*onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(todo: todos[index]),
                      ),
                    );
                  },*/
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
