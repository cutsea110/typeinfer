%token <string> IDENT
%token LET IN
%token LPAREN RPAREN LAMBDA ARROW EQUAL EOF
%start main
%type <Def.term> main
%%

main: expr EOF { $1 }

expr:
    expr factor { Def.EApp ($1, $2) }
  | factor      { $1 }

factor:
    IDENT                        { Def.EVar $1 }
  | LPAREN expr RPAREN           { $2 }
  | LAMBDA IDENT ARROW expr      { Def.EAbs ($2, $4) }
  | LET IDENT EQUAL expr IN expr { Def.ELet ($2, $4, $6) }

