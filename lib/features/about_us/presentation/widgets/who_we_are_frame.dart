// import 'dart:html';
// import 'dart:ui' as ui;
//
// import 'package:flutter/material.dart';
//
// class WhoAreWeIframeScreen extends StatefulWidget {
//
//   String? url;
//   double frameHeight, frameWidth;
//   WhoAreWeIframeScreen({required this.url, required this.frameHeight, required this.frameWidth});
//
//   @override
//   State<WhoAreWeIframeScreen> createState() => _WhoAreWeIframeScreenState();
// }
//
// class _WhoAreWeIframeScreenState extends State<WhoAreWeIframeScreen> {
//   final IFrameElement _iFrameElement = IFrameElement();
//
//   @override
//   void initState() {
//     _iFrameElement.style.height = '100%';
//     _iFrameElement.style.width = '100%';
//     _iFrameElement.src = 'https://www.youtube.com/embed/${widget.url}';
//     _iFrameElement.style.border = 'none';
//     _iFrameElement.style.backgroundColor = '#E4E4E4';
//
// // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory(
//       'iframeWhoWeAreElement',
//           (int viewId) => _iFrameElement,
//     );
//
//     super.initState();
//   }
//
//   final Widget _iframeWidget = HtmlElementView(
//     viewType: 'iframeWhoWeAreElement',
//     key: UniqueKey(),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         children: [
//           SizedBox(
//             height: widget.frameHeight,
//             width: widget.frameWidth,
//             child: _iframeWidget,
//           )
//         ],
//     );
//   }
// }
