import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:mock_api/provider/home_page_provider.dart';
import 'package:provider/provider.dart';

class BuildSuccessView extends StatelessWidget {
  const BuildSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 30,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green,
                border: Border.all(color: Colors.black),
              ),
              child: Center(child: Text("Dart")),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 30,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(
                  "React",
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        SyntaxView(
            code: context.watch<HomePageProvider>().code,
            syntax: Syntax.DART,
            syntaxTheme: SyntaxTheme.vscodeDark(),
            fontSize: 12.0,
            withZoom: false,
            withLinesCount: true,
            expanded: false,
            selectable: true),
        SizedBox(
          height: 15,
        ),
        Text("Response:"),
        SizedBox(
          height: 8,
        ),
        SyntaxView(
            code: context.watch<HomePageProvider>().response,
            syntax: Syntax.YAML,
            syntaxTheme: SyntaxTheme.vscodeDark(),
            fontSize: 12.0,
            withZoom: false,
            withLinesCount: true,
            expanded: false,
            selectable: true),
      ],
    );
  }
}
