
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/models/notes/notes.dart';
import '../../data/network/local/cache_helper.dart';
import 'notes__states.dart';

class NotesCubit extends Cubit<NotesStates> {
  NotesCubit() : super(NotesInitialState());

  get index => null;

  static NotesCubit get(context) => BlocProvider.of(context);

  bool isBottomSheet = false;
  IconData iconShow = Icons.add_task;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheet = isShow;
    iconShow = icon;
    emit(ChangeBottomSheetState());
  }
// Todo:Start database

  Future<void> createNotes(
      {
        required String data,
        required String time,
        required String title,
      }
      ) async {
    emit(CreateNotesLoadingState());
    Notes model = Notes(
      id: '${Random().nextInt(1000)}',
      data: data,
      status: 'now',
      time: time,
      title: title,
    );
    FirebaseFirestore.instance
        .collection('Notes')
        .doc('${CacheHelper.getDataIntoShPre(key:'token')}')
        .collection('Note')
        .doc('${model.id}')
        .set(model.toMap())
        .then((value) {
      print(model.id);
      emit(CreateNotesSuccess());
    }).catchError((error) {
      print('CreateUserErrorState$error');
      emit(CreateNotesError());
    });
  }

  List<Notes>? task;
  List<Notes>? taskdane;
  void getNotes (){
    emit(GetNotesLoadingState());
    FirebaseFirestore.instance
        .collection('Notes')
        .doc('${CacheHelper.getDataIntoShPre(key:'token')}')
        .collection('Note')
        .snapshots().listen((event) {
      task=[];
      taskdane=[];
      event.docs.forEach((element) {
        if(element.data()['status']=='now') {
          task!.add(Notes.fromJson(element.data()));
        }
        else{
          taskdane!.add(Notes.fromJson(element.data()));
        }
      });
      emit(GetNotesSuccess());
    });
  }
  void deleteNotes (
      {
        required String id,
      }
      ){

    emit(GetNotesLoadingState());
    FirebaseFirestore.instance
        .collection('Notes')
        .doc('${CacheHelper.getDataIntoShPre(key:'token')}')
        .collection('Note')
        .doc('${id}')
        .delete()
        .then((value) {
      emit(CreateNotesSuccess());
    }).catchError((error) {
      print('CreateUserErrorState$error');
      emit(CreateNotesError());
    });
  }
  void updateNotes (
      {
        required String data,
        required String time,
        required String id,
        required String title,
      }
      ){
    emit(GetNotesLoadingState());
    Notes model = Notes(
      id: id,
      data: data,
      status: 'done',
      time: time,
      title: title,
    );
    FirebaseFirestore.instance
        .collection('Notes')
        .doc('${CacheHelper.getDataIntoShPre(key:'token')}')
        .collection('Note')
        .doc('${id}')
        .update(model.toMap())
        .then((value) {
      emit(CreateNotesSuccess());
    }).catchError((error) {
      print('CreateUserErrorState$error');
      emit(CreateNotesError());
    });
  }



}