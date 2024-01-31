import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_shoeadd/DB.dart';



class ShoePagenexxt extends StatefulWidget {
  final Shoe shoe;
final String imageUrl;
  const ShoePagenexxt({
    Key? key,
    required this.shoe,
    required this.imageUrl, // Add this line
  }) : super(key: key);

  @override
  _ShoePage2State createState() => _ShoePage2State();
}


// class ShoePagenexxt extends StatefulWidget {
//   const ShoePagenexxt({Key? key, required Shoe shoe}) : super(key: key);

//   @override
//   _ShoePage2State createState() => _ShoePage2State();
// }

class _ShoePage2State extends State<ShoePagenexxt> {
  final myItems = [
    Image.asset('images/shoe.png', fit: BoxFit.cover),
    Image.asset('images/shoe.png', fit: BoxFit.cover),
    Image.asset('images/shoe.png', fit: BoxFit.cover),
    Image.asset('images/shoe.png', fit: BoxFit.cover),
  ];
  final _color = [ 'Red', 'blue'];
  final _size = ['1', '2', ];
  int myCurrentIndex = 0;

  String _selectedColors = 'Red';
  String _selectedSize = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(
          child: Text("COMMON PROJECTS",
              style: TextStyle(color: Colors.black, fontSize: 18),
              textAlign: TextAlign.center),
        ),
        backgroundColor: Colors.white,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: IconButton(
                icon: const Icon(Icons.menu_rounded, color: Colors.black, size: 25),
                onPressed: () {},
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton(
                icon: const Icon(Icons.search, color: Colors.black, size: 25),
                onPressed: () {},
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.zoom_in_outlined,
                color: Colors.black,
              ))
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                  CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        height: 200,
        onPageChanged: (index, reason) {
          setState(() {
            myCurrentIndex = index;
          });
        },
      ),
      items: myItems.map((item) {
        return Image.network(
          widget.imageUrl, // Use the provided image URL
          fit: BoxFit.cover,
        );
      }).toList(),
    ),

            const SizedBox(height: 20),
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  //widget.shoe?.name ?? 'No Name',
                  widget.shoe.name, // Displaying the shoe name dynamically
                  style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                 SizedBox(height: 5),
                Text(
                  widget.shoe.description , //invalid constant value
                  // Displaying the shoe description dynamically
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text(
                  'Price: ${widget.shoe.price}', // Displaying the shoe price dynamically
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 5),
              ],
            ),
       
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 50,
                        width: 170,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Align(
                              child: Text(
                                "COLOR:",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 2),
                            Container(
                              height: 50,
                              width: 70,
                              child: DropdownButton<String>(
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedColors = value!;
                                    });
                                    print(value);
                                  },
                                  value: _selectedColors,
                                  items:
                                      _color.map<DropdownMenuItem<String>>((e) {
                                    return DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  underline: Container(
                                    height: 0,
                                  ),
                                  isExpanded: true,
                                  style: const TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.bold),
                                  itemHeight: 50),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 50,
                        width: 170,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Align(
                              child: Text(
                                "SIZE:",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 2),
                            Container(
                              height: 50,
                              width: 50,
                              child: DropdownButton<String>(
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSize = value!;
                                    });
                                    print(value);
                                  },
                                  value: _selectedSize,
                                  items: _size.map<DropdownMenuItem<String>>((e) {
                                    return DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  underline: Container(
                                    height: 0,
                                  ),
                                  isExpanded: true,
                                  style: const TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.bold),
                                  itemHeight: 50),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
  height: 50,
  width: 420,
  color: Colors.black,
  child: const Center(
    child: Text(
      "ADD TO CART   \$410",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ),
),

              const SizedBox(height: 30),
              const Column(
                children: [
                  Text(
                    "DESCRIPTION",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Common Projects leather sneakers have gained cult status thanks to their minimalist design and superior construction. This white version is perfect for creating crisp city-smart looks",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 13, height: 1.8, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(height: 5, thickness: 2),
              const SizedBox(height: 20),
              const SingleChildScrollView(
                child: Column(
                  children: [
                    Text("SIZE & FIT",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Divider(height: 5, thickness: 2),
                    SizedBox(height: 25),
                    Text("DETAILS & CARE",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
        ),
            ]
      ),
         
    ),
      ),
      );
  }
}