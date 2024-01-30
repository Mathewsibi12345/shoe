// ignore_for_file: sized_box_for_whitespace

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_shoeadd/DB.dart';
import 'package:flutter_application_shoeadd/DBH.dart';
import 'package:flutter_application_shoeadd/add.dart';
import 'package:flutter_application_shoeadd/page.dart';


class ShoePage extends StatefulWidget {
  const ShoePage({Key? key}) : super(key: key);

  @override
  _ShoePageState createState() => _ShoePageState();
}

class _ShoePageState extends State<ShoePage> {
   List<Shoe> shoesList = [];// used for grid view

  @override
  void initState() {
    super.initState();//access
    fetchShoes();
  }

  Future<void> fetchShoes() async {
    try {
      DatabaseHelper databaseHelper = DatabaseHelper();
      List<Shoe> fetchedShoes = await databaseHelper.getShoes();
      setState(() {
        shoesList = fetchedShoes;
      });
    } catch (e) {
      print('Error fetching shoes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Center(
            child: Text(
              "COMMON PROJECTS",
              style: TextStyle(color: Colors.black, fontSize: 18),
              textAlign: TextAlign.center,
            ),
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
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  InputPage()),
                );
              },
              icon: const Icon(
                Icons.add_home_work_outlined,
                color: Colors.black,
              ),
            ),
          ],
          elevation: 0,
        ),
        body: Column(children: [
          const Divider(height: 1, thickness: 1),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  width: size.width / 2,
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Center(
                    child: Text(
                      "Refine products",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: size.width / 2,
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        child: Text(
                          'Sorted by',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                    
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 1, thickness: 1),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: shoesList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.25,
              ),
              itemBuilder: (context, index) {
                Shoe currentShoe = shoesList[index];//UI input name...

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShoePagenexxt(
              shoe: currentShoe,
              imageUrl: currentShoe.imageUrl, // Pass the image URL
            ),
                      ),
                    );
                  },
                  child: ShoeCard(
                    key: ValueKey<String>(currentShoe.id.toString()),
                    currentShoe: currentShoe,
                  ),
                );
              },
            ),
          ),
        ]));
  }
}

class ShoeCard extends StatelessWidget {
  final Shoe currentShoe;

  const ShoeCard({
    Key? key,
    required this.currentShoe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Column(
          children: [
            Card(
              elevation: 0,
              child: Container(
                height: 120,
                width: 250,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 247, 245, 245),
                ),
                child: _buildShoeImage(),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              currentShoe.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Text(
              currentShoe.description,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Text('Price: ${currentShoe.price}', style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 5),

          ],
        ),
      )
    ]);
  }

  Widget _buildShoeImage() {
    log(currentShoe.imageUrl);
    if (currentShoe.imageUrl.isNotEmpty &&
        currentShoe.imageUrl.startsWith('http')) {
      return Image.network(//is used to load an image from the specified URL
        currentShoe.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading image: $error');
          return Container(
            color: Colors.grey,
            child: const Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
          );
        },
      );
    } else {
      print('Invalid image URL: ${currentShoe.imageUrl}');

      return const Placeholder(
        color: Colors.grey,
      );
    }
  }
}

void main() {
  runApp(const MaterialApp(
    home: ShoePage(),
  ));
}