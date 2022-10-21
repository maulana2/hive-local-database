import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final controller = TextEditingController();

  final ValueChanged<String> onChange;
  SearchWidget({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: Colors.grey)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            const Icon(Icons.search),
            const SizedBox(
              width: 20,
            ),
            // ignore: prefer_const_constructors
            Expanded(
                // ignore: prefer_const_constructors
                child: TextField(
              controller: controller,
              decoration: const InputDecoration.collapsed(
                hintText: 'Search...',
              ),
              onChanged: onChange,
            )),
          ],
        ),
      ),
    );
  }
}
