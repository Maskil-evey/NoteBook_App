import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:note/model/noteModel.dart';
import 'package:note/util/service/hive_store.dart';
// import 'package:get/get_rx/src/rx_types/rx_iterables/rx_list.dart';

class NoteController extends GetxController {
  Rx<TextEditingController> noteText = TextEditingController().obs;
  RxBool longPressActivate = false.obs;
  // int allSelected = 0;
  var isSortedByCategory = false.obs;

  RxList<String> itemHint =
      ['Uncategorized', "Work", "Home", "School", "Personal"].obs;
  var selected = 0.obs;
  var selectedType = 'Uncategorized'.obs;
  var isDeleting = false;

  static Box<NoteModel>? noteBox;

  @override
  void onInit() async {
    HiveService.openBox<NoteModel>('notebox').then((value) async {
      // ignore: await_only_futures
      noteBox = await Hive.box<NoteModel>('notebox');
    });
    // update();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    HiveService.closeBox('notebox');
  }

  @override
  void refresh() {
    super.refresh();
    // update();
  }

// reset page after save or cancel
  resetPage() {
    noteText.value.clear();
    selected.value = 0;
    selectedType.value = 'Uncategorized';
    update();
  }

  onLonpressed(NoteModel note) {
    longPressActivate.value = !longPressActivate.value;
    // isDeleting = true;
    onChanged(longPressActivate.value, note);
    update();
  }

  closeOnlongPresses() {
    longPressActivate.value = false;
    isDeleting = false;
    // ignore: invalid_use_of_protected_member
    for (var element in notes.value) {
      element.isSelected = false;
    }
    update();
  }

  onChanged(bool? value, NoteModel note) {
    note.isSelected = value;
    update();
  }

  ontapped(int index) {
    // ignore: invalid_use_of_protected_member
    EasyLoading.showToast(itemHint.value[index]);
    selected.value = index;
    // ignore: invalid_use_of_protected_member
    selectedType.value = itemHint.value[index];
  }

  selectAll(bool? value) {
    isDeleting = value!;
    // ignore: invalid_use_of_protected_member
    for (var element in notes.value) {
      element.isSelected = value;
    }
    update();
  }

  int get selectedNotes =>
      notes.where((note) => note.isSelected == true).length;

  RxList<NoteModel> get notes =>
      noteBox?.values.toList().obs ?? <NoteModel>[].obs;

  String dateFormat(DateTime dateTime) {
    var dateFormat = DateFormat.MMMEd().format(dateTime);
    return dateFormat;
  }

  void addNote() {
    var note = NoteModel(
        note: noteText.value.text,
        type: selectedType.value,
        editedTime: DateTime.now(),
        isSelected: false);

    noteBox?.add(note);
    EasyLoading.showToast('Note Added');
    // reset
    resetPage();
    Get.back();
    // onInit();
  }

  // update note
  void updateNote(
      {required String note, required String type, required int index}) {
    var noteModel = NoteModel(
      note: note,
      type: type,
      editedTime: DateTime.now(),
    );
    noteBox?.putAt(index, noteModel);
    EasyLoading.showToast('Note Updated');
    update();
    // reset
    resetPage();
    Get.back();
    // onInit();
  }

  void delete(NoteModel note) {
    note.delete();
    update();
    EasyLoading.showToast('Note Deleted');
  }

  void deleteSelectedNotes() {
    // Create a copy of the notes list
    List<NoteModel> selectedNotes = List.from(notes);

    // Iterate over the selected notes in reverse order
    for (int i = selectedNotes.length - 1; i >= 0; i--) {
      if (selectedNotes[i].isSelected == true) {
        selectedNotes[i].delete();
        selectedNotes.removeAt(i);
      }
    }

    // Update the noteBox with the modified list of notes
    for (var i = 0; i < selectedNotes.length; i++) {
      noteBox?.putAt(i, selectedNotes[i]);
    }

    // Clear the selection and update the UI
    closeOnlongPresses();
  }

  void sortByCategory() {
    // Toggle the sorting state
    isSortedByCategory.toggle();

    // Sort the notes by category
    if (isSortedByCategory.value) {
      notes.sort((a, b) => a.type.compareTo(b.type));
      // update();
    } else {
      sortByDate();
    }
    print('object');
    update();
    Get.back();
  }

  void sortByDate() {
    // ignore: invalid_use_of_protected_member
    notes.value.sort((a, b) => a.editedTime.compareTo(b.editedTime));
    update();
    Get.back();
  }
}
