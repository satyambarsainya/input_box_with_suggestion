import 'package:flutter/material.dart';
import 'package:input_box_with_suggestion/input_box_with_suggestion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Set<String> dataSource = {
    "Apple",
    "OnePlus",
    "Motorola",
    "Micromax",
    "Samsung"
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              InputBoxWithSuggestion(
                inputBoxBgColor: Colors.red,
                suffixIcon: Icons.search,
                suffixIconColor: Colors.grey,
                textFormFieldHint: "Search..",
                textFormFieldFillColor: Colors.white,
                textFormFieldFocusedBorderSideColor: Colors.grey,
                textFormFieldEnabledBorderSideColor: Colors.grey,
                suggestionViewBgColor: Colors.white,
                suggestionViewSuffixIcon: Icons.trending_up,
                suggestionViewSuffixIconColor: Colors.grey,
                suggestionViewPreffixIcon: Icons.close,
                suggestionViewPreffixIconColor: Colors.grey,
                dataSource: dataSource,
                onItemSelected: (index, item) {
                  // print("${index} : ${item}");
                },
                onItemSearched: (value) {
                  print({value});
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
