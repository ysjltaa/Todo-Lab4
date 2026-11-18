import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todo.dart'; // Sesuaikan path import model Todo kamu

class FirestoreService {
  final CollectionReference _todosCollection =
  FirebaseFirestore.instance.collection('todos');

  // CREATE
  Future<void> addTodo(String taskName) async {
    final newTodo = Todo(
      id: '',
      task: taskName,
      isDone: false,
    );

    // Kirim data ke Firestore (pastikan model Todo punya fungsi toMap() atau toFirestore())
    // Jika menggunakan FieldValue.serverTimestamp() untuk createdAt:
    await _todosCollection.add({
      'task': newTodo.task,
      'isDone': newTodo.isDone,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // READ
  Stream<List<Todo>> getTodos() {
    return _todosCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Todo.fromFirestore(doc))
        .toList());
  }

  // UPDATE
  Future<void> updateTodoStatus(String id, bool currentStatus) async {
    await _todosCollection.doc(id).update({
      'isDone': !currentStatus, // Membalik status saat ini (true <-> false)
    });
  }

  // DELETE
  Future<void> deleteTodo(String id) async {
    await _todosCollection.doc(id).delete();
  }
}