import 'package:cartlistmurchant/FUNCTION/apiCallback.dart';
import 'package:cartlistmurchant/MODAL/categoryModal.dart';
import 'package:cartlistmurchant/PROVIDER/categoryProvider.dart';
import 'package:cartlistmurchant/PROVIDER/registrationProvider.dart';
import 'package:cartlistmurchant/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class selectcategory extends StatefulWidget {
  const selectcategory({super.key});

  @override
  State<selectcategory> createState() => _selectcategoryState();
}

class _selectcategoryState extends State<selectcategory> {
  @override
  void initState() {
    super.initState();
    getCategoryResponse(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final registerProvider = Provider.of<RegistrationProvider>(context);
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        elevation: 0,
        leading: const SizedBox(),
        leadingWidth: 0,
        backgroundColor: colorWhite,
        title: Text(
          registerProvider.typeID.toString(),
          style: const TextStyle(color: colorPrimary, fontSize: 16),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                width: 30,
                height: 10,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                width: 30,
                height: 10,
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                width: 30,
                height: 10,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: categoryProvider.postList.length,
          itemBuilder: (context, index) {
            CategoryModal modalResponse =
                categoryProvider.getPostByIndex(index);
            return CategoryCard(
              categoryImage: modalResponse.categoryImage,
              categoryName: modalResponse.categoryName,
              categoryId: modalResponse.categoryId,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.arrow_circle_right),
      ),
    );
  }
}

class CategoryCard extends StatefulWidget {
  final String categoryImage;
  final String categoryName;
  final String categoryId;
  const CategoryCard(
      {super.key,
      required this.categoryImage,
      required this.categoryName,
      required this.categoryId});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool checkedValue = false;

  var typeNumber;
  @override
  Widget build(BuildContext context) {
    final registerProvider =
        Provider.of<RegistrationProvider>(context, listen: false);
    return Card(
      child: ListTile(
        leading: Image.network(widget.categoryImage),
        title: Text(widget.categoryName),
        subtitle: Text(widget.categoryId),
        trailing: Checkbox(
          value: checkedValue,
          onChanged: (newValue) {
            setState(() {
              checkedValue = newValue!;
              if (checkedValue == true) {
                typeNumber =
                    registerProvider.typeID + int.parse(widget.categoryId);
                registerProvider.setTypeID(typeNumber);
              } else {
                typeNumber =
                    registerProvider.typeID - int.parse(widget.categoryId);
                registerProvider.setTypeID(typeNumber);
              }
            });
          }, //  <-- leading Checkbox
        ),
      ),
    );
  }
}
