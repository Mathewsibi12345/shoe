class Shoe {
  String id;
  String name;
  String description;
  double price;
  String imageUrl;

  Shoe({
    required this.id, //this keyword is used to refer to the current instance of the class
    required this.name,//  The required keyword is used to specify that both id and name and
    required this.description,
    required this.price,
    required this.imageUrl,
  });



  Map<String, dynamic> toMap() {//data is stored as keys and values
    return {
      'shoe_id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      };
  }

factory Shoe.fromMap(Map<String, dynamic> map)
 {
  //Unlike a regular constructor, a factory constructor is not required to
  // return a new instance of the class; it can return an existing instance
  
  return Shoe(
    id: map['id'].toString(),
    name: map['name'] ?? '',
    description: map['description'] ?? '',
    price: map['price'] ?? 0.0,

    imageUrl: map['imageUrl'] ?? '',
  );
}

}