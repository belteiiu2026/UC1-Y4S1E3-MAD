import 'package:mad/data/db_manager.dart';
import 'package:mad/model/category.dart';

class CategoryService {

  String _tableName = "category";

  static final CategoryService instance = CategoryService._init();

  CategoryService._init();

  Future<void> insertCategory(Category category) async{
    final db = await DBManager.instance.database;
    await db.insert(_tableName, category.toMap());
  }

  Future<List<Category>> getCategory() async{
    final db = await DBManager.instance.database;
    final List<Map<String,dynamic>> results = await db.query(_tableName);
    List<Category> categories = results.map((i) => Category.fromMap(i)).toList();
    print("Categories : $categories");
    return categories;
  }
}