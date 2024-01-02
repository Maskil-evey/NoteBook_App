// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:hive_flutter/adapters.dart';
import 'package:note/controller/note_controler.dart';
// import 'package:note/model/noteModel.dart';
import 'package:note/util/widgets/note_tile.dart';
import 'package:note/view/read_note.dart';

class NoteList extends StatelessWidget {
  NoteList({Key? key}) : super(key: key);

  final controller = Get.find<NoteController>(tag: 'NoteController');
  // RxBool _isPressed = false.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoteController>(
        init: NoteController(),
        initState: (_) {},
        builder: (_) {
          return ListView.builder(
            itemCount: _.notes.length,
            itemBuilder: (context, index) {
              var noteBook = _.notes[index];
              var date = _.dateFormat(noteBook.editedTime);
              return Padding(
                padding: const EdgeInsets.only(top: 1.0),
                child: NoteTile(
                  date: date,
                  note: noteBook.note,
                  type: noteBook.type,
                  onTap: () {
                    Get.to(Note(note: noteBook,date: date,index: index,));
                  },
                  onLongPress: () {
                    _.onLonpressed( noteBook);
                  },
                  onChanged: (p0) {
                    _.onChanged(p0, noteBook);
                  },
                  isDeleting: noteBook.isSelected ?? false,
                ),
              );
            },
          );
        });

    // return ValueListenableBuilder(
    //   valueListenable: controller.noteBox?.listenable(),
    //    builder: (context,Box<Object>? note,child){
    //     if (note == null) {
    //     return const Center(child: CircularProgressIndicator(),); // Return an empty widget or a loading indicator
    //   }
    //     return  ListView.builder(
    //           itemCount: note.length,
    //           itemBuilder: (context, index) {
    //             var noteBook = note.getAt(index) as NoteModel;
    //             // var date = _.dateFormat(noteBook.editedTime);
    //             return Padding(
    //               padding: const EdgeInsets.only(top: 1.0),
    //               child: NoteTile(
    //                 date: controller.dateFormat(noteBook.editedTime),
    //                 note: noteBook.note,
    //               type:noteBook.type,
    //             onTap: () {
    //               controller.delete(noteBook);
    //             },
    //           ),
    //         );
    //    }
    //    );
    // });
  }
}
