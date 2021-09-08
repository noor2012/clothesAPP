import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final NetworkImage imageUrl;
  final String name;

  CategoryCard(this.imageUrl, this.name);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.blueGrey
            )
          ],
        ),
        width: size.width * 0.4,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Image.network(''),
              SizedBox(height: 10,),
              Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
