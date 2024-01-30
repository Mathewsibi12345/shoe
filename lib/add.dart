import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_shoeadd/DB.dart';
import 'package:flutter_application_shoeadd/DBH.dart';
import 'package:flutter_application_shoeadd/page.dart';
import 'package:image_picker/image_picker.dart';

class InputPage extends StatefulWidget {
  //const InputPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  

  File? _image;
  Map<String, dynamic> _getShoeDetails() {
    return {
      'name': _nameController.text,
      'description': _descriptionController.text,
      'price': double.parse(_priceController.text),
      'imageUrl': _imageUrlController.text,
      'imageFile': _image,
    };
  }

  @override
  void dispose() {//method is used to clean up resources or perform cleanup operations before an object is no longer needed
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
     _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Input'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
             
              TextField(
                controller: _nameController,
                //The _nameController is assigned to a TextField widget using the controller property
                decoration: const InputDecoration(border: OutlineInputBorder(),  labelText: 'Name'),
              ),
               const SizedBox(height: 5),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(border: OutlineInputBorder(),  labelText: 'Description'),
              ), SizedBox(height: 5),
              
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(border: OutlineInputBorder(),  labelText: 'Price'),
              ), SizedBox(height: 5),
             
              TextField(
                controller: _imageUrlController,
                decoration: const InputDecoration(border: OutlineInputBorder(),  labelText: 'Image URL'),
              ), SizedBox(height: 5),
              // ElevatedButton(
              //   onPressed: () {
              //     _pickImage();
              //   },
              //   child: const Text('Select Image'),
              // ),
              _image != null
                  ? Image.file(
                      _image!,
                      height: 50,
                    )
                  : _imageUrlController.text.isNotEmpty
                      ? Image.network(
                          _imageUrlController.text,
                          height: 50,
                        )
                      : Container(),
              const SizedBox(height: 10),
              ElevatedButton(
  onPressed: () {
    if (_validateInputs()) {
      _saveShoe();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShoePagenexxt(shoe: Shoe.fromMap(_getShoeDetails()), imageUrl: '',),
        ),
      );
    }
  },
  child: Text("Add data"),
),

            //  ElevatedButton(
            //     onPressed: () {
            //       if (_validateInputs()) {
            //         _saveShoe();
            //         Navigator.pop(context, _getShoeDetails());
            //       }
            //     },
            //      child: Text(" Add data") 
                // IconButton(
                //     icon: const Icon(Icons.add_a_photo_rounded, color: Colors.white, size: 25),
                //     onPressed: () {},
                //   ),
                
              
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _imageUrlController.text = '';
      });
    }
  }
 bool _validateInputs() {
    if (_nameController.text.isEmpty) {
      _showErrorDialog('Field cannot be empty');
      return false;
    }

    if (_descriptionController.text.isEmpty) {
      _showErrorDialog('Field cannot be empty');
      return false;
    }

    if (_priceController.text.isEmpty) {
      _showErrorDialog('Field cannot be empty');
      return false;
    }

    if (_imageUrlController.text.isEmpty && _image == null) {
      _showErrorDialog('Field cannot be empty');
      return false;
    }

    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // bool _validateInputs() {
  
  //   return true;
  // }

  Future<void> _saveShoe() async {
    String name = _nameController.text;
    String description = _descriptionController.text;
    double price = double.parse(_priceController.text);
    String imageUrl = _imageUrlController.text;

    if (_image != null) {
      imageUrl = await _saveImageToStorage(_image!);
    }

    Shoe newShoe = Shoe(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
    );

    try {
      DatabaseHelper databaseHelper = DatabaseHelper();
      await databaseHelper.insertShoe(newShoe);
      databaseHelper.close();
      print('Shoe saved successfully!');
    } catch (e) {
      print('Error saving shoe: $e');
    }
  }

  Future<String> _saveImageToStorage(File imageFile) async {
   
   
    return 'path/to/your/image';
  }
}