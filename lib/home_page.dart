import 'package:flutter/material.dart';
import 'package:mock_api/provider/home_page_provider.dart';
import 'package:mock_api/widgets/build_body_form_field.dart';
import 'package:mock_api/widgets/build_success_view.dart';
import 'package:mock_api/widgets/build_textform_field.dart';
import 'package:mock_api/widgets/request_method_dropdown.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Select HTTP Method"),
                    RequestMethodDropdown(),
                    BuildTextformField(
                      hint: "Endpoint *",
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text("Headers"),
                            GestureDetector(
                              onTap: () => context
                                  .read<HomePageProvider>()
                                  .setIsFieldVisible(true, false, false),
                              child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black),
                                      color: context
                                              .watch<HomePageProvider>()
                                              .isHeaderVisible
                                          ? Colors.green
                                          : Colors.white)),
                            ),
                          ],
                        ),
                        SizedBox(width: 15),
                        Column(
                          children: [
                            context.watch<HomePageProvider>().dropdownvalue ==
                                    "POST"
                                ? Text("Request *")
                                : Text("Request"),
                            GestureDetector(
                              onTap: () => context
                                  .read<HomePageProvider>()
                                  .setIsFieldVisible(false, true, false),
                              child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black),
                                      color: context
                                              .watch<HomePageProvider>()
                                              .isRequestVisible
                                          ? Colors.green
                                          : Colors.white)),
                            ),
                          ],
                        ),
                        SizedBox(width: 15),
                        Column(
                          children: [
                            Text("Response *"),
                            GestureDetector(
                              onTap: () => context
                                  .read<HomePageProvider>()
                                  .setIsFieldVisible(false, false, true),
                              child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black),
                                      color: context
                                              .watch<HomePageProvider>()
                                              .isResponseVisible
                                          ? Colors.green
                                          : Colors.white)),
                            ),
                          ],
                        )
                      ],
                    ),

                    // _buildHintText(context, "Header", () {
                    //   context
                    //       .read<HomePageProvider>()
                    //       .setIsFieldVisible(true, false, false);
                    // }),
                    context.watch<HomePageProvider>().isHeaderVisible
                        ? BuildBodyFormField(
                            hint: "Header",
                            isVisible: context
                                .watch<HomePageProvider>()
                                .isHeaderVisible,
                            controller: context
                                .read<HomePageProvider>()
                                .headerController,
                            onPressed: () {})
                        : SizedBox.shrink(),
                    // _buildHintText(context, "Request", () {
                    //   context
                    //       .read<HomePageProvider>()
                    //       .setIsFieldVisible(false, true, false);
                    // }),
                    context.watch<HomePageProvider>().isRequestVisible
                        ? BuildBodyFormField(
                            hint: "Request",
                            isVisible: context
                                .watch<HomePageProvider>()
                                .isRequestVisible,
                            controller:
                                context.read<HomePageProvider>().bodyController,
                            onPressed: () {
                              context
                                  .read<HomePageProvider>()
                                  .setIsFieldVisible(false, true, false);
                            })
                        : SizedBox.shrink(),
                    // _buildHintText(context, "Response", () {
                    //   context
                    //       .read<HomePageProvider>()
                    //       .setIsFieldVisible(false, false, true);
                    // }),
                    context.watch<HomePageProvider>().isResponseVisible
                        ? BuildBodyFormField(
                            hint: "Response",
                            isVisible: context
                                .watch<HomePageProvider>()
                                .isResponseVisible,
                            controller: context
                                .read<HomePageProvider>()
                                .responseController,
                            onPressed: () {
                              context
                                  .read<HomePageProvider>()
                                  .setIsFieldVisible(false, false, true);
                            })
                        : SizedBox.shrink(),
                    // _buildDropDown(dropdownvalue, headers),
                    // _buildTextFormField(context, endpointController, "Endpoint"),
                    // _buildBodyField(context, headerController, "Header", isVisible),
                    // _buildBodyField(context, bodyController, "Body", isVisible),
                    // _buildBodyField(context, bodyController, "Response", isVisible),
                    _buildGenerateTextButton()
                  ]),
            ),
            context.watch<HomePageProvider>().showCode
                ? Expanded(
                    child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(children: [BuildSuccessView()]),
                  ))
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Row _buildHintText(
      BuildContext conext, String? hint, void Function() onPressed) {
    return Row(
      children: [
        Text(hint ?? ""),
        IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.keyboard_arrow_down),
        )
      ],
    );
  }

  Widget _buildTextFormField(
      BuildContext context, TextEditingController controller, String? hint) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.2,
          child: TextFormField(
            controller: controller,
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

  _buildBodyField(BuildContext context, TextEditingController controller,
      String? hint, bool isVisible) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(hint ?? ""),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: Icon(Icons.keyboard_arrow_down),
                )
              ],
            ),
            Visibility(
              visible: isVisible,
              child: Expanded(
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
            ),
          ],
        ),
      ),
    );
  }

  TextButton _buildGenerateTextButton() {
    return TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.green),
        ),
        onPressed: () async {
          final validation = context.read<HomePageProvider>().validateInput();
          if (validation is bool && validation == false) {
            _showErrorDialog("Please fill required fields");
            return;
          }
          _showProgressDialog();
          final response = await context.read<HomePageProvider>().makeApiCall(
              endpoint: validation.endpoint,
              method: validation.method,
              headers: validation.header,
              requestBody: validation.body,
              responseBody: validation.responseBody);
          _dismissDialog();
          if (response) {
            context.read<HomePageProvider>().createCode(
                endpoint: validation.endpoint,
                method: validation.method,
                headers: validation.header,
                requestBody: validation.body,
                responseBody: validation.responseBody);
            // _showSuccessDialog();
          } else {
            _showErrorDialog("Something went wrong");
          }
        },
        child: Text(
          "Generate Api",
          style: TextStyle(color: Colors.white),
        ));
  }

  DropdownButton<String> _buildDropDown(
      String dropdownvalue, List<String> headers) {
    return DropdownButton(
      value: dropdownvalue,

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: headers.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),

      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
        });
      },
    );
  }

  _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  _showProgressDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Please wait"),
            content: CircularProgressIndicator(),
          );
        });
  }

  _dismissDialog() {
    Navigator.of(context).pop();
  }

  _showSuccessDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Api generated successfully"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
