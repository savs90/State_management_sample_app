abstract class Repo<T> {
  const Repo();

  T? getById(int id);
  List<T> getAll();
  bool add(T model);
  bool remove(int id);
}
