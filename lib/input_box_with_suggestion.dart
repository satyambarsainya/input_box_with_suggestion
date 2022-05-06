import 'package:flutter/material.dart';

//ignore: must_be_immutable
class InputBoxWithSuggestion extends StatefulWidget {
  final Set dataSource;
  final MaterialColor inputBoxBgColor;
  final MaterialColor suffixIconColor;
  final MaterialColor textFormFieldFocusedBorderSideColor;
  final MaterialColor textFormFieldEnabledBorderSideColor;
  final MaterialColor suggestionViewSuffixIconColor;
  final MaterialColor suggestionViewPreffixIconColor;
  final Color suggestionViewBgColor;
  final IconData suffixIcon;
  final IconData suggestionViewSuffixIcon;
  final IconData suggestionViewPreffixIcon;
  final String? textFormFieldHint;
  final Color textFormFieldFillColor;
  final Function(int, String) onItemSelected;
  final Function(String) onItemSearched;

  const InputBoxWithSuggestion(
      {Key? key,
      required this.dataSource,
      required this.onItemSelected,
      required this.inputBoxBgColor,
      required this.suffixIcon,
      required this.suffixIconColor,
      required this.textFormFieldHint,
      required this.textFormFieldFillColor,
      required this.textFormFieldFocusedBorderSideColor,
      required this.textFormFieldEnabledBorderSideColor,
      required this.suggestionViewBgColor,
      required this.suggestionViewSuffixIcon,
      required this.suggestionViewSuffixIconColor,
      required this.suggestionViewPreffixIconColor,
      required this.suggestionViewPreffixIcon,
      required this.onItemSearched})
      : super(key: key);

  @override
  State<InputBoxWithSuggestion> createState() => InputBoxWithSuggestionState();
}

class InputBoxWithSuggestionState extends State<InputBoxWithSuggestion>{
  bool showList = false;
  bool showCursor = true;
  late int originalIndex;
  Set filteredDataList = {};
  TextEditingController textEditingController = TextEditingController();

  String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            color: widget.inputBoxBgColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  showCursor: showCursor,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (value) {
                    Set filteredList = {};
                    for (int i = 0; i < widget.dataSource.length; i++) {
                      if ((widget.dataSource.elementAt(i).toLowerCase().toString().startsWith(value.toLowerCase()))) {
                        setState(() {
                          filteredList.add(widget.dataSource.elementAt(i));
                          originalIndex = i;
                        });
                      }
                      filteredDataList.clear();
                      filteredDataList.addAll(filteredList);
                    }
                  },
                  controller: textEditingController,
                  onTap: () {
                    setState(() {
                      showList = true;
                      showCursor = true;
                    });
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        widget.suffixIcon,
                      ),
                      color: widget.suffixIconColor,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() {

                          if (widget.dataSource.isEmpty) {
                            if (textEditingController.text != "" &&
                                textEditingController.text.isNotEmpty) {
                              widget.dataSource.add(textEditingController.text);
                              widget.dataSource
                                  .toList()
                                  .sort((a, b) => a.toString().compareTo(b));
                            }
                          }
                          for (int i = 0; i < widget.dataSource.length; i++) {
                            if (!(widget.dataSource.elementAt(i).toLowerCase()).toString().contains(textEditingController.text.toLowerCase())) {
                              widget.dataSource.add(capitalize(textEditingController.text));
                              widget.dataSource.toList().sort((a, b) => a.toString().compareTo(b));
                            }
                          }
                          filteredDataList.clear();
                          showList = false;
                          widget.onItemSearched(textEditingController.text);
                        });
                      },
                    ),
                    hintText: widget.textFormFieldHint,
                    fillColor: widget.textFormFieldFillColor,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: widget.textFormFieldFocusedBorderSideColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: widget.textFormFieldEnabledBorderSideColor,
                        // color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          showList
              ? Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      color: widget.suggestionViewBgColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.separated(
                        itemCount: filteredDataList.isNotEmpty
                            ? filteredDataList.length
                            : widget.dataSource.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                showCursor = false;
                                textEditingController.text =
                                    filteredDataList.isNotEmpty
                                        ? filteredDataList.elementAt(index)
                                        : widget.dataSource.elementAt(index);
                                widget.onItemSelected(
                                    index,
                                    filteredDataList.isNotEmpty
                                        ? filteredDataList.elementAt(index)
                                        : widget.dataSource.elementAt(index));
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        MediaQuery.removePadding(
                                          context: context,
                                          removeLeft: true,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (filteredDataList
                                                    .isNotEmpty) {
                                                  for (int i = 0;
                                                      i <
                                                          widget.dataSource
                                                              .length;
                                                      i++) {
                                                    if (widget.dataSource
                                                        .elementAt(i)
                                                        .toString()
                                                        .toLowerCase()
                                                        .contains(filteredDataList
                                                            .elementAt(index)
                                                            .toString()
                                                            .toLowerCase())) {
                                                      widget.dataSource.remove(
                                                          widget.dataSource
                                                              .elementAt(i));
                                                    }
                                                  }
                                                  filteredDataList.remove(
                                                      filteredDataList
                                                          .elementAt(index));
                                                } else {
                                                  widget.dataSource.remove(
                                                      widget.dataSource
                                                          .elementAt(index));
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              widget.suggestionViewPreffixIcon,
                                              color: widget
                                                  .suggestionViewPreffixIconColor,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        Text(filteredDataList.isNotEmpty
                                            ? filteredDataList.elementAt(index)
                                            : widget.dataSource
                                                .elementAt(index)),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    widget.suggestionViewSuffixIcon,
                                    color: widget.suggestionViewSuffixIconColor,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
