import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/model/noteModel.dart';
import 'package:note/util/widgets/note_tile.dart';
import 'package:note/view/create_note.dart';

class Note extends StatelessWidget {
   Note({super.key, required this.note, required this.date, this.index});

  NoteModel note;
  String date;
  int? index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            // app bar for mulltiselect
            title: Text(
              'Reading',
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
              onPressed: (){
                Get.back();
              },
            ),
          ),
      body: InkWell(
        onTap: (){
          Get.to(CreateNote(note: note, index: index, isEditing: true,));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
           children: [
            Row(
              children: [
                Text(note.type, style: GoogleFonts.roboto(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: getTypeColor(note.type),
                ),),
                const SizedBox(width: 5),
                Text(date, style: GoogleFonts.roboto(
                  fontSize: 10,
                  // fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),),
              ],
            )
            // note
            ,const SizedBox(height: 10),
            Text(note.note, style: GoogleFonts.roboto(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),),
            ],
          ),
        ),
      ),
      // edit button
      floatingActionButton: FloatingActionButton(
         shape: const CircleBorder(),
        onPressed: () {
          Get.to(CreateNote(note: note, index: index, isEditing: true,));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.edit, color: Colors.white,),
      ),
    );
  }
}