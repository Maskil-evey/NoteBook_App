// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:note/util/widgets/custom_bottomitem.dart';
// google fonts
import 'package:google_fonts/google_fonts.dart';
import 'package:note/util/custom/custom_icons.dart';
import 'package:note/view/create_note.dart';
import 'package:note/view/note_list.dart';

import '../controller/note_controler.dart';

class HomeView extends StatefulWidget {
 const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedItem = '';

  final List<String> dropdownItems = ['Sort by category', 'Sort by date'];

  bool value = false;


  

  @override
  void initState() {

    super.initState();
    selectedItem = dropdownItems[0];
  }
  // final controller = Get.find<NoteController>(tag: 'NoteController');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoteController>(
        init: NoteController(),
        initState: (state) {},
        builder: (_) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: _.longPressActivate.value == true
                ? AppBar(
                    // app bar for mulltiselect
                    title: Text(
                      '${_.selectedNotes}/${_.notes.length}',
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    // elevation: 1,
                    toolbarHeight: 50,
                    shadowColor: Colors.grey[300],
                    backgroundColor: Colors.white70,
                    elevation: 0.2,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        _.closeOnlongPresses();
                      },
                    ),
                    actions: [
                        Checkbox(
                          value:_.isDeleting ,
                          // ignore: avoid_types_as_parameter_names
                          onChanged: (bool) {
                            _.selectAll(bool);
                          },
                          checkColor: Colors.white,
                          // fillColor: MaterialStateProperty.all(Colors.green),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          activeColor: Colors.green,
                          side: const BorderSide(
                              color: Colors.grey,
                              width: 2,
                              style: BorderStyle.solid),
                        )
                      ])
                : AppBar(
                    title: Text(
                      'Notebooks',
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    // elevation: 1,
                    toolbarHeight: 50,
                    shadowColor: Colors.grey[300],
                    backgroundColor: Colors.white70,
                    elevation: 0.2,
                  ),
            body: NoteList(),
            bottomNavigationBar: _.longPressActivate.value
                ? BottomAppBar(
                    height: 70,
                    color: Colors.white.withOpacity(0.5),
                    padding: const EdgeInsets.all(0),

                    // shape: const CircularNotchedRectangle(),
                    // notchMargin: 8.0,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // conteralized deletebutton
                          Stack(
                            children: [
                              Center(
                                child: IconButton(
                                  onPressed: () {
                                    // dialouge
                                    Get.dialog(
                                      AlertDialog(
                                        title: const Text('Delete'),
                                        content: const Text(
                                            'Are you sure you want to delete this note?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              _.deleteSelectedNotes();
                                              Get.back();
                                            },
                                            child: const Text('Delete'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon:
                                      Image.asset(CustomIcons.trash, width: 18),
                                ),
                              ),
                              const Positioned(
                                  top: 50,
                                  right: 5,
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        ]),
                  )
                : BottomAppBar(
                    height: 70,
                    color: Colors.transparent,
                    shape: const CircularNotchedRectangle(),
                    notchMargin: 8.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PopupMenuButton<String>(
                          // key:const Key("popup"),
                          position: PopupMenuPosition.under,
                          icon: const Icon(Icons.more_vert),
                          onSelected: (value) {
                          },
                          itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem<String>(
                                value: '',
                                child: TextButton(
                                  onPressed: () {
                                    _.sortByCategory();
                                  },
                                  child: Text(
                                 'Sort by Category',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )]
                              ;
                          },
                        )
                      ],
                    ),
                  ),
            floatingActionButton: _.longPressActivate.value
                ? const SizedBox()
                : FloatingActionButton(
                    shape: const CircleBorder(),
                    onPressed: () {
                      // controller.printR();
                      Get.to(
                          () => CreateNote(
                                isEditing: false,
                              ),
                          transition: Transition.downToUp,
                          duration: const Duration(milliseconds: 500));
                    },
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndDocked,
          );
        });
  }
}
