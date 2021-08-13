import 'package:contactor_picker/contactor_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/contact_controller.dart';

class ContactView extends GetView<ContactController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('ContactView'),
      //   centerTitle: true,
      // ),
      body: ContactorView(
        title: '联系人',
        dataList: [
          ContactorDataListData(
            name: '呵呵呵',
            id: 001,
            pinyin: 'hehe',
            headerImageUrl: 'https://picsum.photos/250?image=9',
            code: '329889',
            groupCode: '23',
          ),
          ContactorDataListData(
            name: '张子',
            id: 34,
            pinyin: 'zhangzi',
            headerImageUrl: 'https://picsum.photos/250?image=9',
            code: 'sd',
            groupCode: 'sdrer',
          ),
          ContactorDataListData(
            name: '六好的哈哈',
            id: 3232,
            pinyin: 'liuhaop',
            headerImageUrl: 'https://picsum.photos/250?image=9',
            code: 'wqwe',
            groupCode: 'erre',
          ),
          ContactorDataListData(
            name: 'able',
            id: 902193,
            pinyin: 'able',
            headerImageUrl: 'https://picsum.photos/250?image=9',
            code: 'sd',
            groupCode: '23',
          ),
        ],
        onSelectedData: (ContactorDataListData data) {

        },
      ),
    );
  }
}
