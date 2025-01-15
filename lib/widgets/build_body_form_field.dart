import 'package:flutter/material.dart';

class BuildBodyFormField extends StatelessWidget {
  const BuildBodyFormField(
      {super.key,
      this.hint,
      required this.isVisible,
      required this.controller,
      required this.onPressed});
  final String? hint;
  final bool isVisible;
  final TextEditingController controller;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                maxLines: null, // Set this
                expands: true, // and this
                textAlign: TextAlign.start,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    label: Text(
                      hint ?? "",
                      style: TextStyle(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
