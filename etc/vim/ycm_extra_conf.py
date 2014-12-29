import os
import ycm_core

flagsc = [
'-Wall',
'-Wextra',
'-fexceptions',
'-DUSE_CLANG_COMPLETER',
'-std=gnu11',
'-x',
'c',
]

flagscpp = [
'-Wall',
'-Wextra',
'-fexceptions',
'-DUSE_CLANG_COMPLETER',
'-std=gnu++1z',
'-x',
'c++',
]

def FlagsForFile( filename, **kwargs ):
  _,ext=os.path.splitext(filename);
  if(ext==".cpp"):
    return {
      'flags': flagscpp,
      'do_cache': True
    }
  elif(ext==".c"):
    return {
      'flags': flagsc,
      'do_cache': True
    }
