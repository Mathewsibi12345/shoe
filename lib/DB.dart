class Shoe {
  String id;
  String name;
  String description;
  double price;
  String imageUrl;

  Shoe({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });



  Map<String, dynamic> toMap() {
    return {
      'shoe_id': id,
      'name': name,
      'description': description,
      'price': price,
      
      'imageUrl': imageUrl,
      
    };
  }

factory Shoe.fromMap(Map<String, dynamic> map) {
  return Shoe(
    id: map['id'].toString(),
    name: map['name'] ?? '',
    description: map['description'] ?? '',
    price: map['price'] ?? 0.0,

    imageUrl: map['imageUrl'] ?? '',
  );
}

}