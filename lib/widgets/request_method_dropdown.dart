import 'package:flutter/material.dart';
import 'package:mock_api/provider/home_page_provider.dart';
import 'package:provider/provider.dart';

class RequestMethodDropdown extends StatelessWidget {
  const RequestMethodDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: context.watch<HomePageProvider>().dropdownvalue,

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: context.read<HomePageProvider>().headers.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),

      onChanged: (newValue) {
        context.read<HomePageProvider>().setDropDownValue(newValue!);
      },
    );
  }
}
