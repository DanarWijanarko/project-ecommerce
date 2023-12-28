// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_ecommerce/components/_components.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/functions/firestore_services.dart';
import 'package:project_ecommerce/functions/storage_services.dart';
import 'package:project_ecommerce/models/product_model.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => AddProductState();
}

class AddProductState extends State<AddProduct> {
  File? imageFile;

  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController soldController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      imageFile = File(pickedImage!.path);
    });
  }

  void handlePressedAddProductBtn() async {
    final imgUrl = await StorageServices().uploadImgToStorage(imageFile);

    final product = Product(
      imgUrl: imgUrl,
      name: nameController.text,
      type: typeController.text,
      price: priceController.text,
      discount: discountController.text,
      rating: ratingController.text,
      sold: soldController.text,
      description: descriptionController.text,
    );

    final result = await FirestoreService().addData(product.toJson());

    FirestoreService.handleAddDataResult(result, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Product",
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 5),
            MyImagePicker(
              title: "Product Image",
              imageFile: imageFile,
              pickImage: pickImage,
            ),
            const SizedBox(height: 10),
            MyTextFieldCustom(
              controller: nameController,
              textFieldTitle: "Product Name",
              hintText: "e.g. Rexus",
            ),
            const SizedBox(height: 10),
            MyTextFieldCustom(
              controller: typeController,
              textFieldTitle: "Product Type",
              hintText: "e.g. MX5.2",
            ),
            const SizedBox(height: 10),
            MyTextFieldCustom(
              controller: priceController,
              textFieldTitle: "Product Price",
              hintText: "e.g. 165000",
            ),
            const SizedBox(height: 10),
            MyTextFieldCustom(
              controller: discountController,
              textFieldTitle: "Product Discount",
              hintText: "e.g. 0",
            ),
            const SizedBox(height: 10),
            MyTextFieldCustom(
              controller: ratingController,
              textFieldTitle: "Product rating",
              hintText: "e.g. 165000",
            ),
            const SizedBox(height: 10),
            MyTextFieldCustom(
              controller: soldController,
              textFieldTitle: "Product Sold Out",
              hintText: "e.g. 165000",
            ),
            const SizedBox(height: 10),
            MyTextFieldCustom(
              controller: descriptionController,
              textFieldTitle: "Product Description",
              hintText: "e.g. haloooo",
            ),
            const SizedBox(height: 15),
            MyButtonCustom(
              onPressed: handlePressedAddProductBtn,
              bgColor: black,
              bgRadius: 15,
              onTapColor: textGrey,
              onTapRadius: 15,
              padding: const EdgeInsets.all(7),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Add Product",
                  style: TextStyle(
                    color: white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
