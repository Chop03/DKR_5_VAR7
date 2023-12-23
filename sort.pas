// Функция сортировки вставками
procedure InsertionSort(var arr: array of integer);
var
  i, j, key, n: integer;
begin
  n := Length(arr);
  for i := 1 to n - 1 do
  begin
    key := arr[i];
    j := i - 1;
    
    while (j >= 0) and (arr[j] > key) do
    begin
      arr[j + 1] := arr[j];
      j := j - 1;
    end;
    
    arr[j + 1] := key;
  end;
end;


// Функция пирамидальной сортировки
procedure Swap(var a, b: integer);
var
  temp: integer;
begin
  temp := a;
  a := b;
  b := temp;
end;

procedure Heapify(var arr: array of integer; index, size: integer);
var
  largest, left, right: integer;
begin
  largest := index;
  left := 2 * index + 1;
  right := 2 * index + 2;
  
  if (left < size) and (arr[left] > arr[largest]) then
    largest := left;
  
  if (right < size) and (arr[right] > arr[largest]) then
    largest := right;
  
  if largest <> index then
  begin
    Swap(arr[index], arr[largest]);
    Heapify(arr, largest, size);
  end;
end;

procedure HeapSort(var arr: array of integer);
var
  n, i, temp: integer;
begin
  n := Length(arr);
  
  for i := n div 2 - 1 downto 0 do
    Heapify(arr, i, n);
  
  for i := n - 1 downto 1 do
  begin
    Swap(arr[0], arr[i]);
    Heapify(arr, 0, i);
  end;
end;


var
  input, output: Text;
  arr: array of integer;
  i, n: integer;
  c: byte;

begin
  AssignFile(input, 'input.txt');
  Reset(input);
  
  // Чтение данных из файла
  i := 0;
  while not eof(input) do
  begin
    SetLength(arr, i + 1);
    ReadLn(input, arr[i]);
    inc(i);
  end;
  CloseFile(input);
  
  writeln('Выбирите функцию: ');
  writeln('1 - сортировка вставками');
  writeln('2 - пирамидальная сортировка');
  readln(c);
  case c of
    1:
    InsertionSort(arr);
    2:
    HeapSort(arr);
  end; 
  writeln;
  writeln('Ответ записан в output.txt');
  AssignFile(output, 'output.txt');
  Rewrite(output);
  
  // Вывод отсортированных значений в файл
  for i := 0 to length(arr) - 1 do
    WriteLn(output, arr[i]);
  
  CloseFile(output);
end.
