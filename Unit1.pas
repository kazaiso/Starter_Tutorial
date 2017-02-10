unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ScrollBox, FMX.Memo;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { private 宣言 }
  public
    { public 宣言 }
    procedure Show(str: String);
  end;

  /// // メソッド付きレコード定義のコード例/////
type
  TMyDate = record // TMyDateというレコード識別子の定義
  private // 他unitからのアクセスを制限するキーワード private
    Year: Integer; // 内部データ保持用のフィールド の定義。外部unitからのアクセスを制限
    Month: Integer;
    Day: Integer;
    myDateTime: TDateTime;
    procedure SetDatetime; // 内部処理用のprocedureの宣言外部unitからのアクセスを制限
  public // 外部unitから使用させる場合のキーワード public
    // type定義内ではメソッドの識別子定義のみ.メソッドの実装はimplementationブロックで行う
    procedure SetValue(Y, M, D: Integer); // レコードの値セット用のProcedure識別子定義
    function GetValue: TDateTime; // レコードの値取得用のfunction識別子定義
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

/// //配列のコピーのサンプル/////
procedure TForm1.Button1Click(Sender: TObject);
var
  DoutekiArray, DoutekiArrayCopy: array of Integer; // 動的配列変数宣言
  SeitekiArray, SeitekiArrayCopy: Array [0 .. 1] of Integer; // 静的配列変数宣言
  I: Integer;
begin
  SetLength(DoutekiArray, 2); // 動的配列の元となるものにSetLengeで実領域確保
  // 動的配列の元、静的配列の元にそれぞれインデックスと同じ数値を入れておく
  for I := Low(DoutekiArray) to High(DoutekiArray) do
    DoutekiArray[I] := I;
  for I := Low(SeitekiArray) to High(SeitekiArray) do
    SeitekiArray[I] := I;
  // 動的配列と静的配列をコピー先の変数に代入
  DoutekiArrayCopy := DoutekiArray;
  SeitekiArrayCopy := SeitekiArray;
  // コピー先の配列変数のインデックス[0]の値を変更
  SeitekiArrayCopy[0] := 100;
  DoutekiArrayCopy[0] := 100;
  // コピー元、コピー先の配列変数のインデックス[0]が示す値を確認
  Show('動的配列元[0]:' + DoutekiArray[0].ToString + ' / 動的配列コピー[0]:' +
    DoutekiArrayCopy[0].ToString);
  Show('静的配列元[0]:' + SeitekiArray[0].ToString + ' / 静的配列コピー[0]:' +
    SeitekiArrayCopy[0].ToString);
end;

/// //ポインタ変数の使用とポインタ変数を使った値の変更/////
procedure TForm1.Button2Click(Sender: TObject);
var
  IPointer: ^Integer; // Integer型のポインタを保持する変数識別子を宣言
  MyInt: Integer; // Integer型の変数識別子を宣言
begin
  MyInt := 100; // Integer型変数に100を代入

  // 変数識別子の先頭に@をつけることで、その変数のポインタを意味する
  IPointer := @MyInt; // Integer型のポインタ変数に、Integer型変数のポインタを代入

  // ポインタを保持する変数識別子の後ろに ^  をつけることで実際の値の場所を意味する
  IPointer^ := 20; // ポインタ変数が参照している実データの場所に 値20を代入
  Show('ポインタによって代入されたMyInt: ' + MyInt.ToString); // メッセージとして 20 が表示される
end;

/// //メソッド付きレコードの使用例/////
procedure TMyDate.SetDatetime;
// レコード定義識別子.(ドット)メソッド定義識別子の形式で実装。TMyDataレコード定義のSetDateimeメソッド実装
begin
  // フィールドのYear, Month, Day データを myDateTime(TDateTime型）にエンコードして代入
  myDateTime := EncodeDate(Year, Month, Day);
  // メソッド実装内ではレコードの定義識別子なしでフィールドを使用可能
end;

procedure TMyDate.SetValue(Y, M, D: Integer); // TMyDateレコードのSetValueメソッドの実装
begin
  Year := Y; // SetValueの引数として渡されたデータをレコード内のフィールドに代入
  Month := M; // メソッド実装内ではレコードの定義識別子なしでフィールド名を使用可能
  Day := D;
  SetDatetime; // privateキーワードで宣言されていた内部メソッドを呼び出し。メソッド実装内ではレコード定義識別子なしでメソッドを使用可能
end;

function TMyDate.GetValue: TDateTime; // TMyDateレコードのGetValueメソッドの実装
begin
  Result := myDateTime;
  // myDateTimeフィールドを戻り値として戻しているだけ。メソッド実装内ではレコード定義識別子成してフィールドを使用可能
end;

procedure TForm1.Button3Click(Sender: TObject);
// メソッド付きレコードの使用例。ここではボタンのクリック時に使用している
var
  MyBirthday: TMyDate; // 上記で定義、実装しているメソッド付きTMyDataレコード型の変数識別子MyBirthdayを宣言
begin
  MyBirthday.SetValue(1995, 2, 14); // メソッド使用時はレコード変数識別子.メソッド名 で使用。
  Show('メソッドでデータを取得: ' + DateTimeToStr(MyBirthday.GetValue));
  // メソッド使用時は レコード変数識別子.メソッド名で使用。
end;

/// //ウインドウ下部のメモにテキストを表示するだけのProcedure/////
procedure TForm1.Show(str: String);
begin
  Memo1.Lines.Add(str);
end;

end.
