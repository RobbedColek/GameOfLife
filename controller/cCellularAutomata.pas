unit cCellularAutomata;

interface

uses
  System.SysUtils;

type
  TCellularAutomata = class
    private
      Grid : array of array of Integer;
      OldGrid : array of array of Integer;
      Rules : array[0..7] of Integer;

      FWidth : Integer;
      FIterations : Integer;

      procedure PrepareOldGrid;
      procedure ClearOldGrid;
    public
      function GetValue(I, J : Integer) : Integer;
      procedure SetValue(I, J, Value : Integer);

      procedure PrepareGridGameOfLife(Iterations, Width : Integer);
      procedure StepGameOfLife(Iterations, Width : Integer);

      property Width : Integer read FWidth;
      property Iterations : Integer read FIterations;
  end;

implementation

uses
  uUtils;

procedure TCellularAutomata.StepGameOfLife(Iterations, Width : Integer);
var
  I: Integer;
  J: Integer;
  Counter, PrevRow, NextRow, Prev, Next : Integer;
begin
  for I := 0 to High(Grid) do begin
    for J := 0 to High(Grid[I]) do begin
      Counter := 0;

      PrevRow := I - 1;
      NextRow := I + 1;

      if I = 0 then begin
        PrevRow := High(Grid);
      end else
      if I = High(Grid) then begin
        NextRow := Low(Grid);
      end;

      Prev := J - 1;
      Next := J + 1;

      if J = 0 then begin
        Prev := High(Grid[0]);
      end else
      if J = High(Grid) then begin
        Next := Low(Grid[0]);
      end;

      if Grid[PrevRow][Prev] = 1 then  Counter := Counter + 1;
      if Grid[PrevRow][J] = 1 then  Counter := Counter + 1;
      if Grid[PrevRow][Next] = 1 then  Counter := Counter + 1;
      if Grid[I][Prev] = 1 then  Counter := Counter + 1;
      if Grid[I][Next] = 1 then  Counter := Counter + 1;
      if Grid[NextRow][Prev] = 1 then  Counter := Counter + 1;
      if Grid[NextRow][J] = 1 then  Counter := Counter + 1;
      if Grid[NextRow][Next] = 1 then  Counter := Counter + 1;

      if Grid[I][J] = 1 then begin
        case Counter of
        2, 3: begin
          OldGrid[I][J] := 1
        end;
        else begin
          OldGrid[I][J] := 0;
        end;
      end;
      end else begin
        if Counter = 3 then begin
          OldGrid[I][J] := 1
        end;
      end;
    end;
  end;

  for I := 0 to High(OldGrid) do begin
    for J := 0 to High(OldGrid[I]) do Grid[I][J] := OldGrid[I][J];
  end;

  ClearOldGrid;
end;

procedure TCellularAutomata.PrepareOldGrid;
var I, J : Integer;
begin
  SetLength(OldGrid, High(Grid) + 1);
  for I := 0 to High(Grid) do begin
    SetLength(OldGrid[I], High(Grid[I]) + 1);
    for J := 0 to High(Grid[I]) do OldGrid[I][J] := 0;
  end;
end;

procedure TCellularAutomata.ClearOldGrid;
var I, J : Integer;
begin
  for I := 0 to High(OldGrid) do begin
    for J := 0 to High(OldGrid[I]) do OldGrid[I][J] := 0;
  end;
end;

procedure TCellularAutomata.PrepareGridGameOfLife(Iterations, Width : Integer);
var I : Integer;
begin
  FIterations := Iterations;
  FWidth := Width;

  SetLength(Grid, Iterations);
  for I := 0 to High(Grid) do begin
    SetLength(Grid[I], Width);
  end;

  PrepareOldGrid;
end;

function TCellularAutomata.GetValue(I, J: Integer): Integer;
begin
  Result := Grid[I][J];
end;

procedure TCellularAutomata.SetValue(I: Integer; J: Integer; Value: Integer);
begin
  Grid[I][J] := Value;
end;

end.
