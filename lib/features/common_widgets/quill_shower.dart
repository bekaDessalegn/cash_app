import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class QuillShowerWidget extends StatefulWidget {

  String quillContent;

  QuillShowerWidget({required this.quillContent});

  @override
  State<QuillShowerWidget> createState() => _QuillShowerWidgetState();
}

class _QuillShowerWidgetState extends State<QuillShowerWidget> {

  var quillDescriptionController = quill.QuillController.basic();
  var quillEmptyController = quill.QuillController.basic();

  @override
  void initState() {
    var quillEmptyJSON = jsonDecode(widget.quillContent);
    quillEmptyController = quill.QuillController(
        document: quill.Document.fromJson(quillEmptyJSON),
        selection: TextSelection.collapsed(offset: 0));
    var quillDescriptionJSON = jsonDecode(widget.quillContent);
    quillDescriptionController = quill.QuillController(
        document: quill.Document.fromJson(quillDescriptionJSON),
        selection: TextSelection.collapsed(offset: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 0,
          child: quill.QuillEditor.basic(
              controller: quillEmptyController, readOnly: true),
        ),
        quill.QuillEditor.basic(
            controller: quillDescriptionController, readOnly: true),
      ],
    );
  }
}
