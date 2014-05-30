// Example for parsing nested structures using Ragel's stack feature.
//
// 2014-05-09, Georg Sauthoff <mail@georg.so>


#include <iostream>
#include <vector>
#include <cstring>

using namespace std;

%%{

machine ma;

action call_body_extension { cout << ">>call\n"; fcall body_extension;  }
action return              { cout << "<<ret\n";  fret;                  }
action returnback          { --p; cout << "<<retback\n"; fret;          }
action pp_number           { cout << "Digit: " << fc << '\n';           }
action pp_string           { cout << "Char: "  << fc << '\n';           }

SP = ' ' ;
nstring = [A-Za-z]+ ;
number = [0-9]+;

# Snippet from the IMAP RFC
#
# body-extension  = nstring / number /
#                   "(" body-extension *(SP body-extension) ")"

body_extension := (    nstring $pp_string  %^returnback
                  |  ( number  $pp_number  %^returnback  )
                  | '(' @call_body_extension (SP @call_body_extension)* ')' @return
                  )
;

main :=  SP @call_body_extension SP ;

prepush {
  if (unsigned(top) == v.size()) {
    v.push_back(0);
    stack = v.data();
  }
}

}%%

%% write data;

int main( int argc, char **argv )
{
  if (argc != 2) {
    cerr << "not enough/too many arguments!\n";
    return 1;
  }
  int cs = 0;
  vector<int> v;
  int *stack = v.data();
  int top = 0;
  const char *p = argv[1];
  const char *pe = p + strlen(p) ;
  const char *eof = pe;
  (void)eof;
  %% write init;
  %% write exec;
  if (cs == %%{write error;}%%)
    cout << "Parser ERROR\n";
  if (cs < %%{write first_final;}%%)
    cout << "Parser not in final state\n";
  if (top)
    cout << "Stack is not empty: " << top << '\n';
  cout << "exit (in state=" << cs << ")\n";
  return 0;
}

/*

Example call:

    $ ./nested ' (12 (foo bar)) '
    >>call
    >>call
    Digit: 1
    Digit: 2
    <<retback
    >>call
    >>call
    Char: f
    Char: o
    Char: o
    <<retback
    >>call
    Char: b
    Char: a
    Char: r
    <<retback
    <<ret
    <<ret
    exit (in state=5)

*/
