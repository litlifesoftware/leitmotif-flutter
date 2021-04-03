// import 'package:flutter/material.dart';
// import 'package:lit_ui_kit/lit_ui_kit.dart';

// class InstructionCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final TextStyle titleTextStyle;
//   final TextStyle descriptionTextStyle;
//   final Color titleBackgroundColor;
//   final int maxLines;
//   const InstructionCard({
//     Key? key,
//     required this.title,
//     required this.description,
//     this.titleTextStyle = LitTextStyles.sansSerifTitle,
//     this.descriptionTextStyle = LitTextStyles.sansSerif,
//     this.titleBackgroundColor = LitColors.lightGrey,
//     this.maxLines = 9,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 32.0,
//       ),
//       child: BluredBackgroundContainer(
//         blurRadius: 4.0,
//         borderRadius: BorderRadius.circular(25.0),
//         child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(25.0),
//               color: LitColors.mediumGrey.withOpacity(0.40),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(24.0),
//                       color: titleBackgroundColor,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 8.0,
//                         horizontal: 24.0,
//                       ),
//                       child: ClippedText(
//                         title,
//                         style: titleTextStyle,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     bottom: 16.0,
//                     top: 8.0,
//                     left: 32.0,
//                     right: 32.0,
//                   ),
//                   child: ClippedText(
//                     description,
//                     style: descriptionTextStyle,
//                     maxLines: 9,
//                   ),
//                 ),
//               ],
//             )),
//       ),
//     );
//   }
// }
