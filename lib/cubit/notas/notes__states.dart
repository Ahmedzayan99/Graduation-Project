abstract class NotesStates {}

class NotesInitialState extends NotesStates {}

class CreateNotesLoadingState extends NotesStates {}
class ChangeBottomSheetState extends NotesStates {}
class CreateNotesSuccess extends NotesStates {}
class CreateNotesError extends NotesStates {
}
class GetNotesLoadingState extends NotesStates {}
class GetNotesSuccess extends NotesStates {}
class GetNotesError extends NotesStates {
}

class UpdateDatabaseState extends NotesStates {}

class DeleteDatabaseState extends NotesStates {}

class InsertDatabaseState extends NotesStates {}




