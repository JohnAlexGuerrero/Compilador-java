package compilador;
import java.util.ArrayList;
//import java_cup.runtime.*;
%%

%class Lexer
%line 
%column
//%cup

%{
    public ArrayList<Token> ts = new ArrayList<Token>();
    public String errlex="";
    /**private Symbol symbol (int type){
        return new Symbol(type, yyline, yycolum);
    }**/
%}

//alfabetos
Letra = [:jletter:]
Digito = [0-9]

//ER
Entero = {Digito}+
Real = "-"?{Entero} "." {Entero}
palabra = {Letra}+ {numero}?

numero = {Entero}|{Real}
texto = {palabra} (" "{palabra}|" "{numero})*
atributo = {palabra} "=" "'" ({palabra}|{numero}) "'"

//etiquetas
radio = "<" "input" " " "type""=" "'radio'" (" " {atributo})* " "? ">"
btn = "<" "a" " " "href""=" "'"{palabra}"'" (" " {atributo})* " "? ">" {palabra} "<" "/" "a" ">"
text = "<" "input" " " "type""=" "'text'" (" " {atributo})* " "? ">"
checkbox = "<" "input" " " "type""=" "'checkbox'" (" " {atributo})* " "? ">"
number = "<" "input" " " "type""=" "'number'" (" " {atributo})* " "? ">"
date = "<" "input" " " "type""=" "'date'" (" " {atributo})* " "? ">"
label = "<" "Label" (" " {atributo})* ">" {texto} "<" "/" "Label" ">"
option = "<""option"">" {texto} "</" "option" ">"
select = "<" "select" (" " {atributo})* ">" ({Espacio}{option})+ {Espacio} "<""/""select"">"
comentario = "<" "!" "-" "-" " "? {texto} " "? "-" "-" ">"

Espacio = [ \t\r\n]

%%

{label} {ts.add(new Token("TEXT",yytext()));}//return symbol(sym.label);}
{btn} {ts.add(new Token("BUTTON",yytext()));}
{text} {ts.add(new Token("TEXT TYPED",yytext()));}
{number} {ts.add(new Token("NUMBER",yytext()));}
{date} {ts.add(new Token("DATE",yytext()));}
{radio} {ts.add(new Token("BUTTON OF OPTION",yytext()));}
{checkbox} {ts.add(new Token("BUTTON CHECK",yytext()));}
{select} {ts.add(new Token("LIST",yytext()));}
{comentario} {ts.add(new Token("COMMENTARY",yytext()));}
{Espacio} {}
. {errlex += ("\nError: Símbolo no válido: " + yytext() + " En la linea: " + (yyline+1) + " columna: " + (yycolumn+1)  );}
