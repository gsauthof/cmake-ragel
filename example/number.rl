// Simple example for lexing a decimal number from the Ragel manual.
//
// See also: http://www.complang.org/ragel/ragel-guide-6.8.pdf
//
// 2014-05-09, Georg Sauthoff <mail@georg.so>

#include <stdio.h>
#include <string.h>

%%{

machine ma;

action dgt      { printf("DGT: %c\n", fc);     }
action dec      { printf("DEC: .\n");          }
action exp      { printf("EXP: %c\n", fc);     }
action exp_sign { printf("SGN: %c\n", fc);     }
action number   { printf("number finished\n"); }

number = (
    [0-9]+ $dgt ( '.' @dec [0-9]+ $dgt )?
    ( [eE] ( [+\-] $exp_sign )? [0-9]+ $exp )?
) %number ;

main := ( number ' '  )*  ;

}%%

%% write data;

int main( int argc, char **argv )
{
  int cs = 0;
  if (argc > 1) {
    const char *p = argv[1];
    const char *pe = p + strlen(p) ;
    %% write init;
    %% write exec;
    if (cs == %%{write error;}%%)
      printf("Lexer ERROR\n");
    if (cs < %%{write first_final;}%%)
      printf("Lexer not in final state\n");
  }
  printf("exit\n");
  return 0;
}

/*

Example call:

    $ ./number 1.2345E+10' ' 
    DGT: 1
    DEC: .
    DGT: 2
    DGT: 3
    DGT: 4
    DGT: 5
    SGN: +
    EXP: 1
    EXP: 0
    number finished
    exit

*/
