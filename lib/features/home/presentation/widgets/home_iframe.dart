// import 'dart:html';
// import 'dart:ui' as ui;
//
// import 'package:flutter/material.dart';
//
// class HomeIframeScreen extends StatefulWidget {
//
//   String? url;
//   double frameHeight;
//   HomeIframeScreen({required this.url, required this.frameHeight});
//
//   @override
//   State<HomeIframeScreen> createState() => _HomeIframeScreenState();
// }
//
// class _HomeIframeScreenState extends State<HomeIframeScreen> {
//   final IFrameElement _iFrameElement = IFrameElement();
//
//   @override
//   void initState() {
//     _iFrameElement.style.height = '100%';
//     _iFrameElement.style.width = '100%';
//     _iFrameElement.src = 'https://www.youtube.com/embed/${widget.url}';
//     _iFrameElement.style.border = 'none';
//
// // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory(
//       'iframeHomeElement',
//           (int viewId) => _iFrameElement,
//     );
//
//     super.initState();
//   }
//
//   final Widget _iframeWidget = HtmlElementView(
//     viewType: 'iframeHomeElement',
//     key: UniqueKey(),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: widget.frameHeight,
//           width: double.infinity,
//           child: _iframeWidget,
//         )
//       ],
//     );
//   }
// }
