import 'dart:io';
import 'dart:typed_data';

import 'package:claim_investigation/base/base_page.dart';
import 'package:claim_investigation/models/case_model.dart';
import 'package:claim_investigation/util/app_log.dart';
import 'package:claim_investigation/util/size_constants.dart';
import 'package:claim_investigation/widgets/video_player_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CaseDetailScreen extends BasePage {
  static const routeName = '/caseDetailScreen';

  @override
  _CaseDetailScreenState createState() => _CaseDetailScreenState();
}

class _CaseDetailScreenState extends BaseState<CaseDetailScreen> {
  CaseModel _case;
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'en_IN');
  final dateFormatter = DateFormat('dd/MM/yyyy');
  final _descFocusNode = FocusNode();
  String descText = '';
  TextEditingController descTextController = TextEditingController();
  File _imageFile, _videoFile, _pdfFile1, _pdfFile2, _pdfFile3;
  Uint8List _thumbnail;
  String _pdfFileName1, _pdfFileName2, _pdfFileName3;

  @override
  void initState() {
    _case = Get.arguments;
    descTextController.text = _case.caseDescription;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Case Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
                child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Policy No. : ',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      Text(
                        '${_case.policyNumber}',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('SumAssured : ',
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text('${formatCurrency.format(_case.sumAssured)}',
                          style: TextStyle(color: Colors.black, fontSize: 14)),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('IntimationType : ',
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text('${_case.intimationType}',
                          style: TextStyle(color: Colors.black, fontSize: 14)),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('InvestigationType : ',
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text('${_case.investigation.investigationType}',
                          style: TextStyle(color: Colors.black, fontSize: 14)),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status : ',
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text('${_case.caseStatus}',
                          style: TextStyle(color: Colors.black, fontSize: 14)),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )),
            Card(
              child: ListTile(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Insured Name : ',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    Text(
                      '${_case.insuredName}',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Insured DOB : ',
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                        Text('${dateFormatter.format(_case.insuredDob)}',
                            style:
                                TextStyle(color: Colors.black, fontSize: 14)),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Insured DOD : ',
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                        Text('${dateFormatter.format(_case.insuredDod)}',
                            style:
                                TextStyle(color: Colors.black, fontSize: 14)),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Insured Address : ',
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                        Flexible(
                          child: Text('${_case.insuredAddress.trim()}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nominee Name : ',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        Text(
                          '${_case.nomineeName}',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text('Nominee Contact No. : ',
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                        Text('${_case.nomineeContactNumber}',
                            style:
                                TextStyle(color: Colors.black, fontSize: 14)),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nominee Address : ',
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                        Flexible(
                          child: Text('${_case.nomineeAddress.trimRight()}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'City : ',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        Text(
                          '${_case.location.city}',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text('State : ',
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                        Text('${_case.location.state}',
                            style:
                                TextStyle(color: Colors.black, fontSize: 14)),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text('Zone : ',
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                        Text('${_case.location.zone.trim()}',
                            style:
                                TextStyle(color: Colors.black, fontSize: 14)),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description : ',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    _buildTextField(),
                  ],
                ),
              ),
            ),
            _buildImageAndVideo(),
            Card(
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'PDF Attachments : ',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextField(
                            focusNode: _descFocusNode,
                            controller: descTextController,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.headline3,
                            decoration: InputDecoration(
                              hintText: "Select PDF 1",
                              filled: false,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        RaisedButton(
                          onPressed: () async {
                            FilePickerResult result = await FilePicker.platform
                                .pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf'],
                                    allowCompression: true);
                            if (result != null) {
                              PlatformFile platformFile = result.files.first;
                              _pdfFile1 = File(result.files.single.path);
                              _pdfFileName1 = platformFile.name;
                            } else {
                              // User canceled the picker
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text('Select'),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextField(
                            focusNode: _descFocusNode,
                            controller: descTextController,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.headline3,
                            decoration: InputDecoration(
                              hintText: "Select PDF 2",
                              filled: false,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        RaisedButton(
                          onPressed: () async {
                            FilePickerResult result = await FilePicker.platform
                                .pickFiles(
                                    allowedExtensions: ['pdf'],
                                    allowCompression: true);
                            if (result != null) {
                              PlatformFile platformFile = result.files.first;
                              _pdfFile2 = File(result.files.single.path);
                              _pdfFileName2 = platformFile.name;
                            } else {
                              // User canceled the picker
                            }
                          },
                          child: Text('Select'),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextField(
                            focusNode: _descFocusNode,
                            controller: descTextController,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.headline3,
                            decoration: InputDecoration(
                              hintText: "Select PDF 3",
                              filled: false,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        RaisedButton(
                          onPressed: () async {
                            FilePickerResult result = await FilePicker.platform
                                .pickFiles(
                                    allowedExtensions: ['pdf'],
                                    allowCompression: true);

                            if (result != null) {
                              PlatformFile platformFile = result.files.first;
                              _pdfFile3 = File(result.files.single.path);
                              _pdfFileName1 = platformFile.name;
                            } else {
                              // User canceled the picker
                            }
                          },
                          child: Text('Select'),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: double.maxFinite,
                child: CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Submit Report',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageAndVideo() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          SizedBox(
            width: SizeConfig.screenWidth,
            child: Text(
              'UPLOAD IMAGE',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            children: [
              InkWell(
                onTap: () {
                  imagePickerDialog(() async {
                    //camera
                    _imageFile = await getImageFile(ImageSource.camera);
                    setState(() {});
                  }, () async {
                    //gallery
                    _imageFile = await getImageFile(ImageSource.gallery);
                    setState(() {});
                  });
                },
                child: _imageFile == null
                    ? Container(
                        height: SizeConfig.screenHeight * .3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/ic_upload_placeholder.png',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    : SizedBox(
                        height: SizeConfig.screenHeight * .3,
                        width: SizeConfig.screenWidth,
                        child: Image.file(
                          _imageFile,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: SizeConfig.screenWidth,
            child: Text(
              'UPLOAD VIDEO',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            children: [
              InkWell(
                onTap: () {
                  videoPickerDialog(() async {
                    //camera
                    await getVideoFile(ImageSource.camera).then((file) async {
                      _thumbnail = await VideoThumbnail.thumbnailData(
                        video: file.path,
                        imageFormat: ImageFormat.JPEG,
                        maxWidth: 500,
                        quality: 25,
                      );
                      setState(() {
                        _videoFile = file;
                      });
                    });
                  }, () async {
                    //gallery
                    await getVideoFile(ImageSource.gallery).then((file) async {
                      _thumbnail = await VideoThumbnail.thumbnailData(
                        video: file.path,
                        imageFormat: ImageFormat.JPEG,
                        maxWidth: 500,
                        quality: 25,
                      );
                      setState(() {
                        _videoFile = file;
                      });
                    });
                  });
                },
                child: _videoFile == null
                    ? Container(
                        height: SizeConfig.screenHeight * .3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/ic_upload_placeholder.png',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    : SizedBox(
                        height: SizeConfig.screenHeight * .3,
                        width: SizeConfig.screenWidth,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.memory(
                              _thumbnail,
                              fit: BoxFit.fill,
                            ),
                            InkWell(
                              child: Icon(
                                Icons.play_circle_filled_sharp,
                                color: Theme.of(context).primaryColor,
                                size: 70,
                              ),
                              onTap: () {
                                Get.toNamed(VideoPlayerScreen.routeName,
                                    arguments: {'file': _videoFile});
                              },
                            ),
                          ],
                        ),
                      ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    final maxLines = 5;

    return Container(
      height: maxLines * 24.0,
      child: TextField(
        focusNode: _descFocusNode,
        controller: descTextController,
        maxLines: maxLines,
        style: Theme.of(context).textTheme.headline3,
        decoration: InputDecoration(
          hintText: "Enter description here...",
          filled: false,
        ),
        onChanged: (text) {
          descText = text;
        },
      ),
    );
  }
}
