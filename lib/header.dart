import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color.fromARGB(251, 255, 255, 255),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image.asset(
            "assets/images/d.jpg",
          ),
        ),
         Padding(
          padding:const EdgeInsets.only(right: 10),
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "قیمت نرخ ارز",
                style: Theme.of(context).textTheme.headlineLarge
              )),
        ),
        const Expanded(
            child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.menu,
            color: Colors.black,
            size: 35,
          ),
        )),
        const SizedBox(
          width: 16,
        ),
      ],
    );
  }
}