import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/controller/note_controler.dart';

class NoteTile extends StatelessWidget {
  NoteTile(
      {super.key,
      this.onTap,
      required this.date,
      required this.note,
      required this.type,
      this.onLongPress,
      this.onChanged,
      required this.isDeleting});

  final Function()? onTap;
  final String note;
  final String date;
  final String type;
  final Function()? onLongPress;
  final Function(bool?)? onChanged;
  final bool isDeleting;

  NoteController _controller = Get.find<NoteController>(tag: 'NoteController');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoteController>(
        init: NoteController(),
        initState: (_) {},
        builder: (_) {
          return InkWell(
              onTap: onTap,
              onLongPress: onLongPress,
              hoverColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ]),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        color: getTypeColor(type),
                        height: 65,
                        width: 8,
                        child: Center(
                          child: Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100)),
                            // color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                        flex: 11,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    note,
                                    softWrap: false,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        type,
                                        style: GoogleFonts.roboto(
                                            color: getTypeColor(type),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        date,
                                        style: GoogleFonts.roboto(
                                            fontSize: 10,
                                            color: Colors.grey,
                                            fontStyle: FontStyle.italic),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              // checkbox
                              _.longPressActivate.value
                                  ? Checkbox(
                                      value: isDeleting,
                                      tristate: true,
                                      onChanged: onChanged,
                                      checkColor: Colors.white,
                                      // fillColor: MaterialStateProperty.all(Colors.green),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      activeColor: Colors.green,
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ))
                  ],
                ),
              ));
        });
  }
}

Color getTypeColor(String type) {
  if (type == 'Uncategorized') {
    return Colors.green;
  } else if (type == 'Work') {
    return Colors.blue;
  } else if (type == 'Home') {
    return Colors.red;
  } else if (type == 'School') {
    return Colors.purple;
  } else {
    return Colors.orange;
  }
}
