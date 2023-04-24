import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shineradio/model/messages.dart';

class MessageController extends GetxController {
  final Rx<List<Messages>> _messageList = Rx<List<Messages>>([]);

  List<Messages> get messagesList => _messageList.value;

  @override
  void onInit() {
    super.onInit();

    // _messageList.bindStream(
    //   FirebaseFirestore.instance
    //       .collection('messages')
    //       .snapshots()
    //       .map((QuerySnapshot query) {
    //     List<Messages> retVal = [];
    //     for (var element in query.docs) {
    //       retVal.add(
    //         Messages.fromMap(element),
    //       );
    //     }
    //     print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    //     print(retVal.length);
    //     print(retVal[0].author);
    //     print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
    //     return retVal;
    //   }),
    // );
  }
  // likeVideo(String id) async {
  //   DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
  //   var uid = authController.user.uid;
  //   if ((doc.data()! as dynamic)['likes'].contains(uid)) {
  //     await firestore.collection('videos').doc(id).update({
  //       'likes': FieldValue.arrayRemove([uid]),
  //     });
  //   } else {
  //     await firestore.collection('videos').doc(id).update({
  //       'likes': FieldValue.arrayUnion([uid]),
  //     });
  //   }
  // }
}
