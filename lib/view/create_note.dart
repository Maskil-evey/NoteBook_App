// import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/controller/note_controler.dart';
import 'package:note/model/noteModel.dart';
import 'package:note/util/custom/custom_icons.dart';
// import 'package:note/util/widgets/custom_bottom_item.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class CreateNote extends StatefulWidget {
  CreateNote({
    super.key,
    this.note,
    this.isEditing,
    this.index,
  });

  NoteModel? note;
  bool? isEditing;
  int? index;

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {

  // bool? isEditing;

  List<Color> itemColors = [
    Colors.green,
    const Color.fromARGB(255, 3, 131, 236),
    Colors.red,
    Colors.purple,
    Colors.orange
  ].obs;

 
 

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoteController>(
      init: NoteController(),
      initState: (_) {},
      builder: (_) {
        if(widget.isEditing == true){
          _.noteText.value.text = widget.note?.note ?? '';
          _.selected.value = _.itemHint.indexOf('${widget.note?.type}') ;
        }
        else{
          _.noteText.value.text = '';
          _.selected.value = 0;
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.2,
            leadingWidth: 100,
            leading: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 18),
              child: TextButton(
                onPressed: () {
                  Get.back();
                  _.resetPage();
                },
                child: Text(
                  'Cancel',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            // ellaevation: 0.1,
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 18),
                child: TextButton(
                  onPressed: () {
                    if (widget.isEditing == true) {
                      _.updateNote(
                        note: _.noteText.value.text,
                        type: _.itemHint[_.selected.value],
                        index: widget.index ?? 0,
                      );
                      Get.back();
                      _.resetPage();
                    } else {
                      _.addNote();
                      Get.back();
                      _.resetPage();
                    }
                  
                  },
                  child: Text(
                    'Save',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                ),
      
        )
        ],
        toolbarHeight: 50,
        shadowColor: Colors.grey[300],
        backgroundColor: Colors.white70,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: TextField(
            controller: _.noteText.value,
            decoration:const InputDecoration(
              border: InputBorder.none,
              hintText: 'Type Note',
              hintStyle: TextStyle(
                fontSize: 13,
                color: Colors.grey,
                // fontFamily: 'SystemFont',
              ),
            ),
            maxLines: null,
            minLines: 1,
            keyboardType: TextInputType.multiline,
            maxLength: 1700,
            style: GoogleFonts.roboto(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      ),

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(() => BottomNavigationBar(
              onTap: _.ontapped,
              currentIndex: _.selected.value,
              // controller.selectedItemColor:  itemColors[controller.selected.value],
              unselectedItemColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: _.selected.value == 0
                      ? Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: Image.asset(
                            CustomIcons.uncategroizedFull,
                            color: itemColors[_.selected.value],
                            width: 17,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child:
                              Image.asset(CustomIcons.uncategroized, width: 18),
                        ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _.selected.value == 1
                      ? Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: Image.asset(CustomIcons.briefcaseFull,
                              color: itemColors[_.selected.value], width: 18),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: Image.asset(CustomIcons.briefcaseOutline,
                              width: 18),
                        ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _.selected.value == 2
                      ? Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: Image.asset(CustomIcons.homeFull,
                              color: itemColors[_.selected.value], width: 18),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child:
                              Image.asset(CustomIcons.homeOutline, width: 18),
                        ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _.selected.value == 3
                      ? Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: Image.asset(CustomIcons.bookFull,
                              color: itemColors[_.selected.value], width: 18),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: Image.asset(CustomIcons.bookOuline, width: 18),
                        ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _.selected.value == 4
                      ? Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: Image.asset(CustomIcons.userFull,
                              color: itemColors[_.selected.value], width: 18),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child:
                              Image.asset(CustomIcons.userOutline, width: 18),
                        ),
                  label: '',
                ),
              ],
            )),
      ),
    );
      }
);}
}