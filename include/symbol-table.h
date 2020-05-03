#include <map>

using namespace std;

typedef struct entry {
  string value;
  int type;
  string scope;

  entry(string _value, int _type, string _scope) {
    value = _value;
    type = _type;
    scope = _scope;
  }
} entry;

class SymbolTable {
 private:
  map<int, entry> table;
  int id;

 public:
  int insert(entry);

  entry get(int);
};
