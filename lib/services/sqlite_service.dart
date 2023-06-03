import 'package:sqflite/sqflite.dart' as sql;

class SqliteService {
  // Future for an Async funcion returns
  Future<void> createTables(sql.Database database) async {
    await database.execute(
      """CREATE TABLE QuizQuestions(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            answers TEXT NOT NULL,
            correctAnswerIndex INTEGER NOT NULL,
            createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)
            """,
    );
  }

  Future<sql.Database> db() async {
    return sql.openDatabase(
      'quiz.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new question
  Future<int> createQuestion(QuizQuestion quizQuestion) async {
    final db = await SqliteService().db();
    // Converts object to Map representation for the DB insertion
    final id = await db.insert('QuizQuestions', quizQuestion.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    // If there is conflict with PK, replace it with the new record
    return id;
  }

  // Get all questions
  Future<List<QuizQuestion>> getQuestions() async {
    final db = await SqliteService().db();
    final List<Map<String, Object?>> queryResult =
        await db.query('QuizQuestions', orderBy: 'id');
    return queryResult.map((e) => QuizQuestion.fromMap(e)).toList();
    // Converts each map [Which was inserted] into a QuizQuestion object
  }

  // Delete question by id
  Future<void> deleteQuestion(int id) async {
    final db = await SqliteService().db();
    try {
      await db.delete("QuizQuestions", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }
}

class QuizQuestion {
  int? id;
  String title;
  List<String> answers;
  int correctAnswerIndex;

  QuizQuestion({
    this.id,
    required this.title,
    required this.answers,
    required this.correctAnswerIndex,
  });

  // When data insertion
  Map<String, dynamic> toMap() {
    // dynamic represnts changable variables, like: id, title, etc.
    return {
      'id': id,
      'title': title,
      'answers': answers.join('|'),
      'correctAnswerIndex': correctAnswerIndex,
    };
  }

  // When data retrieving
  static QuizQuestion fromMap(Map<String, dynamic> map) {
    return QuizQuestion(
      id: map['id'],
      title: map['title'],
      answers: (map['answers'] as String).split('|'),
      correctAnswerIndex: map['correctAnswerIndex'],
    );
  }
}
