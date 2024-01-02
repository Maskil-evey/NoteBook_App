

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'noteModel.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject{
  @HiveField(0)
  String note;
  @HiveField(1)
  String type;
  @HiveField(2)
  DateTime editedTime;
  @HiveField(3)
  Color? color;
  @HiveField(4)
  bool? isSelected;

  NoteModel({required this.note, this.color,required this.editedTime,required this.type, this.isSelected});

  get date => null;
}