// import 'package:cash/core/constants.dart';
// import 'package:cash/core/global.dart';
// import 'package:flutter/material.dart';
// import 'package:iconify_flutter/iconify_flutter.dart';
// import 'package:iconify_flutter/icons/mi.dart';
//
// class AffiliateProductSearchWidget extends StatefulWidget {
//
//   final VoidCallback onChange;
//   AffiliateProductSearchWidget({required this.onChange});
//
//   @override
//   State<AffiliateProductSearchWidget> createState() => _AffiliateProductSearchWidgetState();
// }
//
// class _AffiliateProductSearchWidgetState extends State<AffiliateProductSearchWidget> {
//
//   String? value;
//
//   List<String> filter = ["Latest", "Old"];
//
//   final searchController = TextEditingController();
//
//   @override
//   void dispose() {
//     searchController.dispose();
//     // TODO: implement dispose
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: searchController,
//             onChanged: (value) {
//               setState(() {
//                 affiliateProductSearchValue = value;
//               });
//               widget.onChange();
//             },
//             textAlignVertical: TextAlignVertical.center,
//             style: TextStyle(color: onBackgroundColor),
//             decoration: InputDecoration(
//               contentPadding: EdgeInsets.all(0),
//               filled: true,
//               fillColor: surfaceColor,
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide.none
//               ),
//               hintText: "Search....",
//               hintStyle: TextStyle(
//                   color: textInputPlaceholderColor
//               ),
//               prefixIcon: Icon(Icons.search),
//               prefixIconColor: textInputPlaceholderColor,
//             ),
//           ),
//         ),
//         Container(
//           width: 40,
//           margin: EdgeInsets.only(right: 10),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               icon: Visibility(visible: false, child: Icon(Icons.arrow_downward)),
//               // value: values,
//               isExpanded: true,
//               hint: Iconify(Mi.filter, size: 40, color: onBackgroundColor,),
//               focusColor: Colors.transparent,
//               items: filter.map(buildMenuLocation).toList(),
//               onChanged: (value) => setState(() {
//                 this.value = value;
//                 print(value);
//               }),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   DropdownMenuItem<String> buildMenuLocation(String filter) => DropdownMenuItem(
//     value: filter,
//     child: Text(
//       filter,
//       style: TextStyle(
//         color: onBackgroundColor,
//         fontSize: 14,
//       ),
//     ),
//   );
//
// }