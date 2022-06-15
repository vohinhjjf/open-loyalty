import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductModel {
  late String productSku;
  late String productName;
  late String brand;
  late double price;
  late String warrantyId;
  late DateTime purchaseDate;
  late DateTime warrantyExpired;
  late String image;
  late String store;

  ProductModel(item) {
    productSku = item["productSku"];
    productName = item["productName"];
    brand = item["brand"];
    price = double.parse(item["price"]);
    warrantyId = item["warrantyId"];
    purchaseDate = DateTime.parse(item["purchaseDate"]);
    warrantyExpired = DateTime.parse(item["warrantyExpired"]);
    image = item["image"];
    store = item["store"];
  }
}
Object addProduct(int i) {
  FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  var id = user?.uid;

  var product = FirebaseFirestore.instance.collection('Products').doc('$id');
  // Call the user's CollectionReference to add a new user
  for (int i = 0; i < products.length; i++) {
     product.update({
      'product $i': {
        'productSku': productData[i]["productSku"],
        'productName': productData[i]["productName"],
        'brand': productData[i]["brand"],
        'price': productData[i]["price"],
        'warrantyId': productData[i]["warrantyId"],
        'purchaseDate': productData[i]["purchaseDate"],
        'warrantyExpired': productData[i]["warrantyExpired"],
        'image': productData[i]["image"],
        'store': productData[i]["store"],
      }
    })
        .then((value) => print("Product Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  return 'null';
}

List<ProductModel> products =
    productData.map((item) => ProductModel(item)).toList();
var productData = [
  {
    "productSku": "FW1231",
    "productName": "Điện thoại iPhone 12 Pro Max 128GB",
    "brand": "Apple",
    "price": "30490000",
    "warrantyId": "00000000-0000-3333-1111-000000000004",
    "purchaseDate": "2021-06-27T08:49:20+0200",
    "warrantyExpired": "2020-06-27T08:49:20+0200",
    "image": "assets/images/ip.jpg",
    "store": "Cửa hàng A"
  },
  {
    "productSku": "DD1231",
    "productName": "Laptop Lenovo Legion 5 15IMH05 i7",
    "brand": "Lenovo",
    "price": "25990000",
    "warrantyId": "00000000-0000-3333-1111-000000000002",
    "purchaseDate": "2021-07-01T08:49:20+0200",
    "warrantyExpired": "2022-07-01T08:49:20+0200",
    "image": "assets/images/lap.jpg",
    "store": "Cửa hàng B"
  },
  {
    "productSku": "VY3832",
    "productName": "Điện thoại Samsung Galaxy S21 5G ",
    "brand": "Samsung",
    "price": "17990000",
    "warrantyId": "00000000-0000-3333-1111-000000000003",
    "purchaseDate": "2021-06-27T08:49:20+0200",
    "warrantyExpired": "2020-06-27T08:49:20+0200",
    "image": "assets/images/ss.jpg",
    "store": "Cửa hàng C"
  },
  {
    "productSku": "DV1231",
    "productName": "Samsung Galaxy Watch Active 2 40mm",
    "brand": "Samsung",
    "price": "3000000",
    "warrantyId": "00000000-0000-3333-1111-000000000000",
    "purchaseDate": "2021-06-27T08:49:20+0200",
    "warrantyExpired": "2022-06-27T08:49:20+0200",
    "image": "assets/images/watch.jpg",
    "store": "Cửa hàng D"
  },
  {
    "productSku": "IP1233",
    "productName": "Máy tính bảng iPad Air 4 Wifi 64GB (2020)",
    "brand": "Apple",
    "price": "16190000",
    "warrantyId": "00000000-0000-3333-1111-000000000009",
    "purchaseDate": "2021-06-25T08:49:20+0200",
    "warrantyExpired": "2022-06-25T08:49:20+0200",
    "image": "assets/images/ipad.jpg",
    "store": "Cửa hàng E"
  },
];

ProductModel? getProduct(String productSku) {
  for (int i = 0; i < products.length; i++) {
    if (productSku == products[i].productSku) {
      return products[i];
    }
  }
  return null;
}
