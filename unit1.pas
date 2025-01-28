unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ExtCtrls, LazSerial, frmajuda, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnconfig: TButton;
    btnfechar: TButton;
    btnabrir: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    RB_num01: TRadioButton;
    RB_num02: TRadioButton;
    RB_num03: TRadioButton;
    RB_num04: TRadioButton;
    RB_num05: TRadioButton;
    comport3: TLazSerial;
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    Timer1: TTimer;
    procedure btnabrirClick(Sender: TObject);
    procedure btnconfigClick(Sender: TObject);
    procedure btnfecharClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure comport3RxData(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public
    procedure calcula_viscosidade();

  end;

var
  Form1: TForm1;

  RX_Serial: string; //string do rx dos dados seriais
  num_orificio: integer;
  tempo_escoamento: integer;

  ctrl_coleta: boolean;

  ctrl_inicio: boolean;  //para controlar o enable do botao iniciar nova medicao

  CurPos: integer;
  FTempStr: string;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.calcula_viscosidade();
var
    viscosidade_cinematica: double;
    tempo_escoamento_seg: double;
    erro_medicao: boolean;
begin

    GroupBox6.Enabled:=true;
    viscosidade_cinematica:=0;
    erro_medicao:= false;


    tempo_escoamento_seg := roundto(tempo_escoamento/10,-2);
    if (num_orificio=1) then
    begin
      viscosidade_cinematica:= 0.49*(tempo_escoamento_seg-35);
    end;
    if (num_orificio=2) then
    begin
      viscosidade_cinematica:= 1.44*(tempo_escoamento_seg-18);
    end;
    if (num_orificio=3) then
    begin
      viscosidade_cinematica:= 2.31*(tempo_escoamento_seg-6.58);
    end;
    if (num_orificio=4) then
    begin
      viscosidade_cinematica:= 3.85*(tempo_escoamento_seg-4.49);
    end;
    if (num_orificio=5) then
    begin
      viscosidade_cinematica:= 12.1*(tempo_escoamento_seg-2);
    end;


    if (tempo_escoamento_seg<55) AND (num_orificio=1) then
    begin
        showmessage('Tempo de escoamento abaixo de faixa (55 até 100) para o orificio nº 1');
        showmessage('Fluido de viscosidade muito baixa para ser medido com os orificios disponiveis');
        showmessage('Seria necessário um orificio de escoamento com seção menor que o do orifico nº 1 disponível');
        erro_medicao:= true;
    end;
    if (tempo_escoamento_seg>100) AND (num_orificio=1) then
    begin
        showmessage('Tempo de escoamento acima de faixa (55 até 100) para o orificio nº 1');
        showmessage('Fluido de viscosidade muito alta, necessário trocar o orificio de escoamento por um de seção maior');
        erro_medicao:= true;
    end;


    if (tempo_escoamento_seg<40) AND (num_orificio=2) then
    begin
        showmessage('Tempo de escoamento abaixo de faixa (40 até 100) para o orificio nº 2');
        showmessage('Fluido de viscosidade muito baixa, necessário trocar o orifício de escoamento por um de seção menor');
        erro_medicao:= true;
    end;
    if (tempo_escoamento_seg>100) AND (num_orificio=2) then
    begin
        showmessage('Tempo de escoamento acima de faixa (40 até 100) para o orificio nº 2');
        showmessage('Fluido de viscosidade muito alta, necessário trocar o orificio de escoamento por um de seção maior');
        erro_medicao:= true;
    end;


    if (tempo_escoamento_seg<20) AND (num_orificio=3) then
    begin
        showmessage('Tempo de escoamento abaixo de faixa (20 até 100) para o orificio nº 3');
        showmessage('Fluido de viscosidade muito baixa, necessário trocar o orifício de escoamento por um de seção menor');
        erro_medicao:= true;
    end;
    if (tempo_escoamento_seg>100) AND (num_orificio=3) then
    begin
        showmessage('Tempo de escoamento acima de faixa (20 até 100) para o orificio nº 3');
        showmessage('Fluido de viscosidade muito alta, necessário trocar o orificio de escoamento por um de seção maior');
        erro_medicao:= true;
    end;


    if (tempo_escoamento_seg<20) AND (num_orificio=4) then
    begin
        showmessage('Tempo de escoamento abaixo de faixa (20 até 100) para o orificio nº 4');
        showmessage('Fluido de viscosidade muito baixa, necessário trocar o orifício de escoamento por um de seção menor');
        erro_medicao:= true;
    end;
    if (tempo_escoamento_seg>100) AND (num_orificio=4) then
    begin
        showmessage('Tempo de escoamento acima de faixa (20 até 100) para o orificio nº 4');
        showmessage('Fluido de viscosidade muito alta, necessário trocar o orificio de escoamento por um de seção maior');
        erro_medicao:= true;
    end;



    if (tempo_escoamento_seg<20) AND (num_orificio=5) then
    begin
        showmessage('Tempo de escoamento abaixo de faixa (20 até 100) para o orificio nº 5');
        showmessage('Fluido de viscosidade muito baixa, necessário trocar o orifício de escoamento por um de seção menor');
        erro_medicao:= true;
    end;
    if (tempo_escoamento_seg>100) AND (num_orificio=5) then
    begin
        showmessage('Tempo de escoamento acima de faixa (20 até 100) para o orificio nº 5');
        showmessage('Fluido de viscosidade muito alta para ser medido com os orificios disponiveis');
        showmessage('Seria necessário um orificio de escoamento com seção maior que o do orifico nº 5 disponível');
        erro_medicao:= true;
    end;





    if (erro_medicao=true) then
    begin
      Label4.Caption:= ' Fora da Faixa ';
    end
        else
    begin
        Label4.Caption:= ' '+floattostr(roundto(viscosidade_cinematica,-2))+' cSt ';
    end;






    tempo_escoamento:=0;
    ctrl_coleta:= false;






end;


procedure TForm1.btnconfigClick(Sender: TObject);
begin

   comport3.ShowSetupDialog;

  if comport3.device<>'' then //só habilita "abrir porta" se for selecionado uma porta
    begin
      btnabrir.Enabled := True;
    end;
end;

procedure TForm1.btnfecharClick(Sender: TObject);
begin

  comport3.Close; //fecha a conexao serial
if not comport3.Active then
  begin
    btnfechar.Enabled := False;
    btnabrir.Enabled := False;
    btnconfig.Enabled:=True;

    Button1.Enabled:=false;//desativando o botao de iniciar nova medicao
  end
else
  begin
    showmessage('Falha ao finalizar conexão serial');
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  GroupBox4.Enabled:=true;
  button1.enabled:= false;


  ctrl_inicio:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin

    if (RB_num01.Checked=true) then
      begin
        num_orificio:=1;
      end;
    if (RB_num02.Checked=true) then
      begin
        num_orificio:=2;
      end;
    if (RB_num03.Checked=true) then
      begin
        num_orificio:=3;
      end;
    if (RB_num04.Checked=true) then
      begin
        num_orificio:=4;
      end;
    if (RB_num05.Checked=true) then
      begin
        num_orificio:=5;
      end;


    GroupBox4.Enabled:=false;
    GroupBox5.Enabled:=true;
    Button3.Enabled:=true;


end;

procedure TForm1.Button3Click(Sender: TObject);
begin


  //esses if's garantem que o monitoramento só será iniciado se nao tiver fluxo presente
    if (Label2.Caption='Fluxo Presente') then
      begin
        showmessage('Não se deve inicar o monitoramento na presença de fluxo');
      end;
    if (Label2.Caption='Fluxo Ausente') then
      begin
        ctrl_coleta:= true;
        Button3.Enabled:=false;
      end;



end;

procedure TForm1.Button4Click(Sender: TObject);
begin

   Button1.Enabled:=false;
   GroupBox4.Enabled:=false;
   GroupBox5.Enabled:=false;
   GroupBox6.Enabled:=false;
   ctrl_inicio:=false;
   ctrl_coleta:=false;
   tempo_escoamento:=0;
   label1.Caption:='0 segundos';
   label4.Caption:='';
   Timer1.Enabled:=false;
   Memo1.Clear;
end;



procedure TForm1.comport3RxData(Sender: TObject);


begin

RX_Serial := comport3.ReadData;


if (RX_Serial='O') then
  begin
    label2.Caption:='Fluxo Ausente';

    if (ctrl_inicio=false) then//so habilita o botao de iniciar nova medicao que for o inicio da iteracao.
      begin                    //feito isso para evitar de habilitar o botao no meio da configuracao da medicao
        Button1.Enabled:=true;
        ctrl_inicio:=true;
      end;


  end;
if (RX_Serial='C') then
  begin
    label2.Caption:='Fluxo Presente';

    if (ctrl_inicio=false) then//so habilita o botao de iniciar nova medicao que for o inicio da iteracao.
      begin                    //feito isso para evitar de habilitar o botao no meio da configuracao da medicao
        Button1.Enabled:=true;
        ctrl_inicio:=true;
      end;

  end;




if (ctrl_coleta=true) then
    begin
        if (RX_Serial='O') then
          begin
            label2.Caption:='Fluxo Ausente';
            Timer1.Enabled:=false;

            if (tempo_escoamento <> 0) then
              begin
                calcula_viscosidade();
              end;
          end;
        if (RX_Serial='C') then
          begin
            label2.Caption:='Fluxo Presente';
            Timer1.Enabled:=true;
          end;
    end;



CurPos := Pos(char(10), RX_Serial);
if CurPos = 0 then
begin
  FTempStr := FTempStr + RX_Serial;
end
else
begin
  FTempStr := FTempStr + Copy(RX_Serial, 1, CurPos - 1);
  Memo1.Lines.BeginUpdate;
  Memo1.Lines.Add(FtempStr);
  Memo1.Lines.EndUpdate;
  Memo1.SelStart := Length(Memo1.Lines.Text) - 1; //posiciona o curso no final do memo
  Memo1.SelLength := 0;
  FTempStr := Copy(RX_Serial, CurPos + 1, Length(RX_Serial) - CurPos);
end;



end;

procedure TForm1.FormActivate(Sender: TObject);
begin

//configurando em runtime o separador decimal
//para evitar erros caso as configuracoes regionais
{*** é depreciado, foi trocado pelo DefaultFormatSettings.DecimalSeparator
}
//DecimalSeparator := '.';   //para padrao ingles
DefaultFormatSettings.DecimalSeparator:='.';


  num_orificio:=1;
  tempo_escoamento:=0;
  ctrl_coleta:= false;

  ctrl_inicio:=false;


  FTempStr:= '';
  CurPos:=0;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  frmAjudaform.showmodal;//só deixa trabalhar nesse formulário
                     //obriga o usuario a fechar a tela Sobre
                     //para voltar ao aplicativo

end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  view_tempo: double;
begin
  tempo_escoamento:=tempo_escoamento+1;

  view_tempo:= tempo_escoamento/10;
  label1.Caption:= floattostr(roundto(view_tempo,-2))+' segundos';
end;

procedure TForm1.btnabrirClick(Sender: TObject);
begin
  try

  // Abrindo a conexão serial
  comport3.Open;

  if comport3.Active then
    begin
      btnconfig.Enabled := False;
      btnabrir.Enabled:=False;
      btnfechar.Enabled := True;
      ctrl_inicio:=false;
    end
    else
      begin
        showmessage('FALHA ao abrir conexão serial com ('+comport3.Device+')');
      end;
        Except on E : Exception do
          begin
            showmessage('ERRO ao abrir conexão: Detalhes> '+E.Message);
          end;
      end;
end;



end.
























