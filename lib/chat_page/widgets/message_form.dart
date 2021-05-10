import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scarla/flutter_flow/flutter_flow_theme.dart';
import 'package:scarla/flutter_flow/upload_media.dart';

class MessageForm extends StatefulWidget {
  final ValueChanged<Map> onSubmit;

  MessageForm({Key key, this.onSubmit}) : super(key: key);

  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  final _controller = TextEditingController();
  String _message;

  void _onPressed() {
    Map msgMap = Map();
    msgMap['value'] = _message;
    msgMap['type'] = 0;
    widget.onSubmit(msgMap);
    _message = '';
    _controller.clear();
    setState(() {});
  }

  Future getImage({bool isVideo = false}) async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    if(isVideo) {
      pickedFile = await imagePicker.getVideo(source: ImageSource.gallery);
    } else {
      pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    }
    Map msgMap = Map();
    if (pickedFile != null) {
      final isValid = validateFileFormat(pickedFile.path, context);
      if(isValid) {
        msgMap['value'] = pickedFile.path;
        msgMap['type'] = isVideo ? 2 : 1;
        widget.onSubmit(msgMap);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            (FlutterFlowTheme.isUploading)
                ? Material(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.0),
                      child: IconButton(
                        icon: Icon(Icons.file_upload),
                        onPressed: () {},
                        color: FlutterFlowTheme.primaryColor,
                      ),
                    ),
                    color: Colors.transparent,
                  )
                : Material(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.0),
                      child: IconButton(
                        icon: Icon(Icons.image),
                        onPressed: getImage,
                        color: FlutterFlowTheme.primaryColor,
                      ),
                    ),
                    color: Colors.transparent,
                  ),
            Material(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 1.0),
                child: IconButton(
                  icon: Icon(Icons.video_collection),
                  onPressed: () {
                    getImage(isVideo: true);
                  },
                  color: FlutterFlowTheme.primaryColor,
                ),
              ),
              color: Colors.transparent,
            ),
            Expanded(
                child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Send a Chat',
                hintStyle: FlutterFlowTheme.bodyText2.override(
                  fontFamily: 'Poppins',

                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(10),
              ),
              style: FlutterFlowTheme.bodyText2.override(
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
              minLines: 1,
              maxLines: 4,
              onChanged: (value) {
                setState(() {
                  _message = value;
                });
              },
            )),
            SizedBox(
              width: 5,
            ),
            RawMaterialButton(
              onPressed:
                  _message == null || _message.trim().isEmpty ? null : _onPressed,
              fillColor: _message == null || _message.trim().isEmpty
                  ? Colors.blueGrey
                  : FlutterFlowTheme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'SEND',
                  style: FlutterFlowTheme.subtitle2
                      .override(fontFamily: 'Poppins', fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
