#include "../include/symbol-table.h"

int SymbolTable::insert(entry newEntry) {
  table.insert(pair<int, entry>(id, newEntry));
  return id++;
}

entry SymbolTable::get(int id) { return table.at(id); }
