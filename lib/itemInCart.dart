//Description : To map the items need to be added in cart
//Coded by Vignesh
class CartItem{
  int id;
  String name;
  int price;
  double rating;
  String image;

  CartItem(this.name, this.price, this.rating, this.image);

  CartItem.map(dynamic obj){
    this.name = obj['name'];
    this.price = obj['price'];
    this.rating = obj['rating'];
    this.image = obj['image'];
  }

  Map<String,dynamic> toMap(){
    var map = new Map<String,dynamic>();
    map['name']=name;
    map['price']=price;
    map['rating']=rating;
    map['image']=image;

    if(id != null){
      map['id'] = id;
    }
    return map;
  }

  CartItem.fromMap(Map<String,dynamic> map){
    this.name = map['name'];
    this.price = map['price'];
    this.rating = map['rating'];
    this.image = map['image'];
  }

}