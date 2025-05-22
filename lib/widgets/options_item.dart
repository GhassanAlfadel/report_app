// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class OptionsItem extends StatelessWidget {
  final String option;
  final Function goToPage;
  const OptionsItem({
    super.key,
    required this.option,
    required this.goToPage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 200,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 138, 157, 167),
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          option,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      onTap: () {
        goToPage();
      },
    );
  }
}
