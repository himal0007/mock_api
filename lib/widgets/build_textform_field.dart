import 'package:flutter/material.dart';
import 'package:mock_api/provider/home_page_provider.dart';
import 'package:provider/provider.dart';

class BuildTextformField extends StatelessWidget {
  const BuildTextformField({super.key, this.hint});
  final String? hint;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.height * 0.4,
          child: TextFormField(
            controller: context.read<HomePageProvider>().endpointController,
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
          )),
    );
  }
}
