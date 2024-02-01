class Shoe {//class
  String id;// Declaring instance variables for the shoe's properties
  String name;
  String description;
  double price;
  String imageUrl;

  Shoe({// Constructor for initializing the shoe with required parameters
    required this.id, //this keyword is used to refer to the current instance of the class
    required this.name,//  The required keyword is used to specify that both id and name and
    required this.description,
    required this.price,
    required this.imageUrl,
  });

// Method to convert Shoe object to a map for database operations

  Map<String, dynamic> toMap() {//data is stored as keys and values
    return {
      'shoe_id': id,
      'name': name,
      'description': description,
      'price': price,// Mapping instance variables to keys for database storage
      'imageUrl': imageUrl,
      };
  }
// Factory constructor to create a Shoe object from a map (database query result)
factory Shoe.fromMap(Map<String, dynamic> map)
 {
  //Unlike a regular constructor, a factory constructor is not required to
  // return a new instance of the class; it can return an existing instance
  
  return Shoe(// Extracting values from the map and providing default values if they are null
    id: map['id'].toString(),
    name: map['name'] ?? '',
    description: map['description'] ?? '',
    price: map['price'] ?? 0.0,

    imageUrl: map['imageUrl'] ?? '',
  );
}

}