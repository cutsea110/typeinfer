%token <string> IDENT
%token LPAREN RPAREN LAMBDA ARROW EOF
%start main
%type <Def.lexpr> main
%%

main: expr EOF { $1 }

expr:
    expr factor { Def.EApp ($1, $2) }
  | factor      { $1 }

factor:
    IDENT                   { Def.EVar $1 }
  | LPAREN expr RPAREN      { $2 }
  | LAMBDA IDENT ARROW expr { Def.EAbs ($2, $4) }
