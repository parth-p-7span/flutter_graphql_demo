// import 'package:flutter/material.dart';
//
// class DropDown extends StatefulWidget {
//   final List<String?>? spinnerItems;
//   const DropDown({Key? key, this.spinnerItems}) : super(key: key);
//
//   @override
//   _DropDownState createState() => _DropDownState();
// }
//
// class _DropDownState extends State<DropDown> {
//   String dropdownValue = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: dropdownValue,
//       underline: Container(
//         height: 1,
//         color: Colors.deepPurpleAccent,
//       ),
//       onChanged: (data) {
//         setState(() {
//           dropdownValue = data.toString();
//         });
//       },
//       items: widget.spinnerItems != null
//           ? widget.spinnerItems
//               ?.map<DropdownMenuItem<String>>((item) => DropdownMenuItem(
//                     child: Text(item ?? ""),
//                     value: item,
//                   )),
//       // items: widget.spinnerItems!
//       //     .map<DropdownMenuItem<String>>(
//       //         (String? item) => DropdownMenuItem<String>(
//       //               child: Text(item ?? ''),
//       //               value: item,
//       //             ))
//       //     .toList(),
//     );
//   }
// }
