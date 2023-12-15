uses Crt;

const
  NORM = 12; // цвет невыделеного пункта 
  SEL = 10; // цвет выделенного пункта 
  Num = 2;

var
  menu: array[1..Num] of string[24];// названия пунктов меню 
  punkt: integer;
  ch: char;
  xmenu, ymenu, TextAttr: byte;
  a, b, c, x, d, ff: real;
  n: integer;

function f(xx: real): real;
begin
  f := 1 * xx * xx * xx + (-1) * xx * xx + (-2) * xx + 15;
end;

function trapezoidMethod(a, b: real; n: integer): real;
var
  c, s, x: real;
  i: integer;
begin
  c := (b-a)/n;
  x:= a;
  d:= f(a) + f(b);
  for i:= 1 to n-1 do
  begin
    x:= x + c;
    d := d + 2 * f(x);
  end;
  trapezoidMethod:= d * c / 2;
end;

procedure calculateIntegral;
var
  integral, error: real;
begin
  writeln('Введите границы интегрирования: ');
  readln(a, b);
  writeln('Введите количество промежутков: ');
  readln(n);

  integral := trapezoidMethod(a, b, n);
  error := (b-a) * (b-a) * (b-a) * (b-a) / 12 * (b-a) / (n * n) * 5; // Вычисление погрешности

  writeln('Интеграл равен: ', integral:0:3);
  writeln('Погрешность: ', error:0:3);
end;

procedure punkt1;
begin
  ClrScr;
  calculateIntegral;
  writeln;
  writeln('Процедура завершена вот такие пироги. Нажмите <Enter> для продолжения.');
  repeat
    ch := readkey;
  until ch = #13;
end;

procedure MenuToScr;// вывод меню на экран 
var
  i: integer;
begin
  ClrScr;
  for i := 1 to Num do
  begin
    GoToXY(xmenu, ymenu + i - 1);
    write(menu[i]);
  end;
  TextColor(SEL);
  GoToXY(xmenu, ymenu + punkt - 1);
  write(menu[punkt]);// выделим строку в меню 
  TextColor(NORM);
end;

begin
  menu[1] := ' Начать интегрирование ';
  menu[2] := ' Выход ';
  punkt := 1; xmenu := 5; ymenu := 5;
  TextColor(NORM);
  MenuToScr;
  repeat
    ch := ReadKey;
    if ch = #0 then begin
      ch := ReadKey;
      case ch of
        #40:// стрелка вниз 
          if punkt < Num then begin
            GoToXY(xmenu, ymenu + punkt - 1); write(menu[punkt]);
            punkt := punkt + 1;
            TextColor(SEL);
            GoToXY(xmenu, ymenu + punkt - 1); write(menu[punkt]);
            TextColor(NORM);
          end;
        #38:// стрелка вверх 
          if punkt > 1 then begin
            GoToXY(xmenu, ymenu + punkt - 1); write(menu[punkt]);
            punkt := punkt - 1;
            TextColor(SEL);
            GoToXY(xmenu, ymenu + punkt - 1); write(menu[punkt]);
            TextColor(NORM);
          end;
      end;
    end
    else
    if ch = #13 then begin
      case punkt of
        1: punkt1;
        2: ch := #27;// выход из программы
      end;
      MenuToScr;
    end;
  until ch = #27;
end.