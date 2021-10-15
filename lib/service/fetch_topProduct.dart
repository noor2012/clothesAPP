import 'package:clothesapp/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<ProductModel> product = [];

class Product {
  static String title='';
  static String storeName='';
  static String des='';
  static String price='';
  static String discount='';
  static String img='';
  static double rat=0.0;

  static Future fetchTopProduct()async{
    product = [];
    CollectionReference _reference = FirebaseFirestore.instance.collection("topProduct");
    QuerySnapshot querySnapshot =
        await _reference.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      await _reference.doc(querySnapshot.docs[i].id).get().then((value){
        print(value.get("code"));
        title = value.get("title");
        storeName = value.get("storeName");
        des = value.get("des");
        rat = value.get("rat");
        img = value.get("img");
        price = value.get("price");
        discount = value.get("discount");
      }).whenComplete((){
        product.add( ProductModel(
          rat:rat,
          title: title,
          storeName: storeName,
          price: price,
          img: img,
          des: des,
          discount: discount,
        ),
        );
      });
    }
  }
}