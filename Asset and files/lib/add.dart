// ignore_for_file: no_leading_underscores_for_local_identifiers, library_private_types_in_public_api, prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_shoeadd/DB.dart';
import 'package:flutter_application_shoeadd/DBH.dart';
import 'package:image_picker/image_picker.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  // Declaring the State class for InputPage
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   // GlobalKey to uniquely identify the Form widget
  final TextEditingController _nameController = TextEditingController();
   // Controllers for handling text input fields
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  File? _image;
// File variable to store the selected image

  Map<String, dynamic> _getShoeDetails() {
    // Method to get shoe details from the input fields
      // ignore: unused_local_variable
      double price = 0.0; // Default value if parsing fails

  try {
    price = double.parse(_priceController.text);
  } catch (e) {
    // Handle the exception, show an error message, and return from the method
    _showErrorDialog('Invalid');
    return {};
  }
    return {// Return a map with shoe details
      'name': _nameController.text,
      'description': _descriptionController.text,
      'price': double.parse(_priceController.text),
      'imageUrl': _imageUrlController.text,
    };
  }

  bool _submitted = false;
// Variable to track whether the form has been submitted
  @override
  void dispose() {
    // Dispose method to release resources when the widget is disposed no ret
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override//Build method to create the widget tree
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Input'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,// Using the declared GlobalKey for the Form
            child: Column(
              children: [
                TextFormField(// Text input field for the name
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    // Display error if the field is empty and submitted
                    errorText: _submitted && _nameController.text.isEmpty
                        ? 'Please enter your name'
                        : null,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(// Text input field for the description
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                    // Display error if the field is empty and submitted
                    errorText: _submitted &&
                            _descriptionController.text.isEmpty
                        ? 'Please enter the description'
                        : null,
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(// Text input field for the price
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                     // Display error if the field is empty and submitted
                    errorText: _submitted && _priceController.text.isEmpty
                        ? 'Please enter the price'
                        : null,
                  ),
                ),
                SizedBox(height: 5),
                TextFormField( // Text input field for the image URL
                  controller: _imageUrlController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Image URL',
                    errorText: (_submitted &&_imageUrlController.text.isEmpty && _image == null)
                        ? 'Please enter the image URL or select an image'
                        : null,
                  ),
                ),
                SizedBox(height: 5),
                _image != null// Display selected image or image from URL
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
                ElevatedButton(// Button to trigger form validation and save shoe data
  onPressed: () {
    setState(() {
      _submitted = true;
    }); // Get shoe details and validate inputs
    Map<String, dynamic> shoeDetails = _getShoeDetails();
    if (shoeDetails.isNotEmpty && _validateInputs()) {
      _saveShoe();
      Navigator.pop(context, shoeDetails);
    }
  },
  child: Text("Add data"),
),
              ],
            ),
          ),
        ),
      ),
    );
  }
// Method to pick an image from the device's gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {// Update the state with the selected image and clear the image URL field
      setState(() {
        _image = File(pickedFile.path);
        _imageUrlController.text = '';
      });
    }
  }

  // Method to validate the form inputs
  bool _validateInputs() {
    if (_formKey.currentState!.validate()) {
      // Additional validation if needed
      return true;
    }
    return false;
  }

  void _showErrorDialog(String message) {
    showDialog(// Method to show an error dialog with a given message
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

  Future<void> _saveShoe() async {// Method to save the shoe data to the database
    String name = _nameController.text; // Retrieve values from text controllers
    String description = _descriptionController.text;
    double price = double.parse(_priceController.text);
    String imageUrl = _imageUrlController.text;

    if (_image != null) {// If an image is selected, save it to storage and get the URL
      imageUrl = await _saveImageToStorage(_image!);
    }

    Shoe newShoe = Shoe(// Create a new Shoe object
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
    );

    try {// Insert the shoe into the database
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