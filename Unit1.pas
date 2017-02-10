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
    { private �錾 }
  public
    { public �錾 }
    procedure Show(str: String);
  end;

  /// // ���\�b�h�t�����R�[�h��`�̃R�[�h��/////
type
  TMyDate = record // TMyDate�Ƃ������R�[�h���ʎq�̒�`
  private // ��unit����̃A�N�Z�X�𐧌�����L�[���[�h private
    Year: Integer; // �����f�[�^�ێ��p�̃t�B�[���h �̒�`�B�O��unit����̃A�N�Z�X�𐧌�
    Month: Integer;
    Day: Integer;
    myDateTime: TDateTime;
    procedure SetDatetime; // ���������p��procedure�̐錾�O��unit����̃A�N�Z�X�𐧌�
  public // �O��unit����g�p������ꍇ�̃L�[���[�h public
    // type��`���ł̓��\�b�h�̎��ʎq��`�̂�.���\�b�h�̎�����implementation�u���b�N�ōs��
    procedure SetValue(Y, M, D: Integer); // ���R�[�h�̒l�Z�b�g�p��Procedure���ʎq��`
    function GetValue: TDateTime; // ���R�[�h�̒l�擾�p��function���ʎq��`
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

/// //�z��̃R�s�[�̃T���v��/////
procedure TForm1.Button1Click(Sender: TObject);
var
  DoutekiArray, DoutekiArrayCopy: array of Integer; // ���I�z��ϐ��錾
  SeitekiArray, SeitekiArrayCopy: Array [0 .. 1] of Integer; // �ÓI�z��ϐ��錾
  I: Integer;
begin
  SetLength(DoutekiArray, 2); // ���I�z��̌��ƂȂ���̂�SetLenge�Ŏ��̈�m��
  // ���I�z��̌��A�ÓI�z��̌��ɂ��ꂼ��C���f�b�N�X�Ɠ������l�����Ă���
  for I := Low(DoutekiArray) to High(DoutekiArray) do
    DoutekiArray[I] := I;
  for I := Low(SeitekiArray) to High(SeitekiArray) do
    SeitekiArray[I] := I;
  // ���I�z��ƐÓI�z����R�s�[��̕ϐ��ɑ��
  DoutekiArrayCopy := DoutekiArray;
  SeitekiArrayCopy := SeitekiArray;
  // �R�s�[��̔z��ϐ��̃C���f�b�N�X[0]�̒l��ύX
  SeitekiArrayCopy[0] := 100;
  DoutekiArrayCopy[0] := 100;
  // �R�s�[���A�R�s�[��̔z��ϐ��̃C���f�b�N�X[0]�������l���m�F
  Show('���I�z��[0]:' + DoutekiArray[0].ToString + ' / ���I�z��R�s�[[0]:' +
    DoutekiArrayCopy[0].ToString);
  Show('�ÓI�z��[0]:' + SeitekiArray[0].ToString + ' / �ÓI�z��R�s�[[0]:' +
    SeitekiArrayCopy[0].ToString);
end;

/// //�|�C���^�ϐ��̎g�p�ƃ|�C���^�ϐ����g�����l�̕ύX/////
procedure TForm1.Button2Click(Sender: TObject);
var
  IPointer: ^Integer; // Integer�^�̃|�C���^��ێ�����ϐ����ʎq��錾
  MyInt: Integer; // Integer�^�̕ϐ����ʎq��錾
begin
  MyInt := 100; // Integer�^�ϐ���100����

  // �ϐ����ʎq�̐擪��@�����邱�ƂŁA���̕ϐ��̃|�C���^���Ӗ�����
  IPointer := @MyInt; // Integer�^�̃|�C���^�ϐ��ɁAInteger�^�ϐ��̃|�C���^����

  // �|�C���^��ێ�����ϐ����ʎq�̌��� ^  �����邱�ƂŎ��ۂ̒l�̏ꏊ���Ӗ�����
  IPointer^ := 20; // �|�C���^�ϐ����Q�Ƃ��Ă�����f�[�^�̏ꏊ�� �l20����
  Show('�|�C���^�ɂ���đ�����ꂽMyInt: ' + MyInt.ToString); // ���b�Z�[�W�Ƃ��� 20 ���\�������
end;

/// //���\�b�h�t�����R�[�h�̎g�p��/////
procedure TMyDate.SetDatetime;
// ���R�[�h��`���ʎq.(�h�b�g)���\�b�h��`���ʎq�̌`���Ŏ����BTMyData���R�[�h��`��SetDateime���\�b�h����
begin
  // �t�B�[���h��Year, Month, Day �f�[�^�� myDateTime(TDateTime�^�j�ɃG���R�[�h���đ��
  myDateTime := EncodeDate(Year, Month, Day);
  // ���\�b�h�������ł̓��R�[�h�̒�`���ʎq�Ȃ��Ńt�B�[���h���g�p�\
end;

procedure TMyDate.SetValue(Y, M, D: Integer); // TMyDate���R�[�h��SetValue���\�b�h�̎���
begin
  Year := Y; // SetValue�̈����Ƃ��ēn���ꂽ�f�[�^�����R�[�h���̃t�B�[���h�ɑ��
  Month := M; // ���\�b�h�������ł̓��R�[�h�̒�`���ʎq�Ȃ��Ńt�B�[���h�����g�p�\
  Day := D;
  SetDatetime; // private�L�[���[�h�Ő錾����Ă����������\�b�h���Ăяo���B���\�b�h�������ł̓��R�[�h��`���ʎq�Ȃ��Ń��\�b�h���g�p�\
end;

function TMyDate.GetValue: TDateTime; // TMyDate���R�[�h��GetValue���\�b�h�̎���
begin
  Result := myDateTime;
  // myDateTime�t�B�[���h��߂�l�Ƃ��Ė߂��Ă��邾���B���\�b�h�������ł̓��R�[�h��`���ʎq�����ăt�B�[���h���g�p�\
end;

procedure TForm1.Button3Click(Sender: TObject);
// ���\�b�h�t�����R�[�h�̎g�p��B�����ł̓{�^���̃N���b�N���Ɏg�p���Ă���
var
  MyBirthday: TMyDate; // ��L�Œ�`�A�������Ă��郁�\�b�h�t��TMyData���R�[�h�^�̕ϐ����ʎqMyBirthday��錾
begin
  MyBirthday.SetValue(1995, 2, 14); // ���\�b�h�g�p���̓��R�[�h�ϐ����ʎq.���\�b�h�� �Ŏg�p�B
  Show('���\�b�h�Ńf�[�^���擾: ' + DateTimeToStr(MyBirthday.GetValue));
  // ���\�b�h�g�p���� ���R�[�h�ϐ����ʎq.���\�b�h���Ŏg�p�B
end;

/// //�E�C���h�E�����̃����Ƀe�L�X�g��\�����邾����Procedure/////
procedure TForm1.Show(str: String);
begin
  Memo1.Lines.Add(str);
end;

end.
