unit View.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.ScrollBox, FMX.Memo,
  FMX.Layouts, FMX.ListBox,
  Common.Barcode, FMX.Memo.Types;

type
  TFormMain = class(TForm)
    EditRawData: TEdit;
    ButtonGenerateBarcode: TButton;
    PathBarcode: TPath;
    LayoutTop: TLayout;
    LayoutClient: TLayout;
    MemoSVGPathData: TMemo;
    ComboBoxBarcodeType: TComboBox;
    LayoutRight: TLayout;
    SplitterRight: TSplitter;
    TextSVG: TText;
    EditAddonData: TEdit;
    procedure ButtonGenerateBarcodeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditRawDataKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
  private
    { Private declarations }
    FLastSelectedType: TBarcodeType;
    function SelectedBarcodeType: TBarcodeType;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.fmx}

procedure TFormMain.ButtonGenerateBarcodeClick(Sender: TObject);
var
  SVGString: string;
begin
  FLastSelectedType := SelectedBarcodeType;
  SVGString := TBarcode.SVG(FLastSelectedType, EditRawData.Text, EditAddonData.Text);

  PathBarcode.Data.Data       := SVGString;
  MemoSVGPathData.Lines.Text  := SVGString;
end;

procedure TFormMain.EditRawDataKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = 13 then
    ButtonGenerateBarcodeClick(ButtonGenerateBarcode);

end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FLastSelectedType := TBarcodeType.EAN8;
end;

function TFormMain.SelectedBarcodeType: TBarcodeType;
begin
  result := TBarcodeType(ComboBoxBarcodeType.ItemIndex);
end;

initialization
  ReportMemoryLeaksOnShutdown := true;

finalization
  CheckSynchronize;

end.
