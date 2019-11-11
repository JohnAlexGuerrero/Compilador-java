package compilador;
import java.util.ArrayList;
%%

%class Lexer
%line 
%column

%{
    public ArrayList<Token> ts = new ArrayList<Token>();
    public String errlex="";
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
tipo = "type""="("'text'"|"'number'"|"'date'"|"'radio'"|"'checkbox'")

//etiquetas
input = "<" "input" " " {tipo} (" " {atributo})* ">"
label = "<" "Label" (" " {atributo})* ">" {texto} "<" "/" "Label" ">"
option = "<""option"">" {texto} "</" "option" ">"
select = "<" "select" (" " {atributo})* ">" {option}+ //"</" "select" ">"
comentario = "<!--"{texto}"-->"

etiqueta = {input}|{select}|{label}|{option}|{comentario}

Espacio = [ \t\r\n]

%%

{etiqueta} {ts.add(new Token("Tag",yytext()));}
"text" {ts.add(new Token("input type Text",yytext()));}
"number" {ts.add(new Token("input type Number",yytext()));}
"date" {ts.add(new Token("input type Date",yytext()));}
"radio" {ts.add(new Token("button of option",yytext()));}
"checkbox" {ts.add(new Token("button check",yytext()));}
{select} {ts.add(new Token("Tag type List",yytext()));}
{comentario} {ts.add(new Token("Commetary",yytext()));}
{Espacio} {}
. {errlex += ("\nError: Símbolo no válido: " + yytext() + " En la linea: " + (yyline+1) + " columna: " + (yycolumn+1)  );}
