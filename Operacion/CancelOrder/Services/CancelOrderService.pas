unit CancelOrderService;

interface

uses
  DataModule, System.Math, OperacionDM, ImprimirDM,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TCancelOrderService = Class
  private
    ImprimirDataModule: TImprimirDataModule;
    nro, tipo, comp, let, cod, fech, ven, cui, cno, a, cli, asocNro, nctipo,
      cbteAsoc, masOmenos, sql, cae, vto, pagare: string;
    pre, pgr, esCompra: Boolean;
    noGra, pagCueIva, pagCueOtr, perIIBB, perImpMun, impInt, otrTrib, cost, com,
      impu, cheq, ch3q, cont, tot, sbt, des, tarj, otr, sal, pag, int, n10, n21,
      i10, i21, deud, ulc, cmv, comv, n3, i3, per, ret: Double;
    aIva, pvta: Integer;
  public
    constructor Create(Vnro, Vtipo: string);
    destructor Destroy; override;

    property Pnro: string read nro write nro;
    property Ptipo: string read tipo write tipo;
    // property Plet: string read let write let;
    // property Pcod: string read cod write cod;
    // property Pfech: string read fech write fech;
    // property Pven: string read ven write ven;
    // property Pcui: string read cui write cui;
    // property Pcno: string read cno write cno;
    // property Pa: string read a write a;
    // property Pcli: string read cli write cli;
    // property PasocNro: string read asocNro write asocNro;
    // property PcbteAsoc: string read cbteAsoc write cbteAsoc;
    // property Pnctipo: string read nctipo write nctipo;
    // property Ppre: Boolean read pre write pre;
    // property Ppgr: Boolean read pgr write pgr;
    // property Pcost: Double read cost write cost;
    // property Pcom: Double read com write com;
    // property Pimpu: Double read impu write impu;
    // property Pcheq: Double read cheq write cheq;
    // property Pcont: Double read cont write cont;
    // property Ptot: Double read tot write tot;
    // property Psbt: Double read sbt write sbt;
    // property Pdes: Double read des write des;
    // property Ptarj: Double read tarj write tarj;
    // property Potr: Double read otr write otr;
    // property Psal: Double read sal write sal;
    // property Ppag: Double read pag write pag;
    // property Pint: Double read int write int;
    // property Pn10: Double read n10 write n10;
    // property Pn21: Double read n21 write n21;
    // property Pi10: Double read i10 write i10;
    // property Pi21: Double read i21 write i21;
    // property Pn3: Double read n3 write n3;
    // property Pi3: Double read i3 write i3;
    // property Pper: Double read per write per;
    // property Pret: Double read ret write ret;
    // property Pdeud: Double read deud write deud;
    // property Pulc: Double read ulc write ulc;
    // property Pcomv: Double read comv write comv;
    // property PaIva: Double read aIva write aIva;

    procedure Execute;
  end;

implementation

{ TCancelOrderService }

constructor TCancelOrderService.Create;
begin
  inherited Create;
  nro := '';
  tipo := '';
  comp := '';
  let := '';
  cod := '';
  fech := '';
  ven := '';
  cui := '';
  cno := '';
  a := '';
  cli := '';
  asocNro := '';
  nctipo := '';
  cbteAsoc := '';
  masOmenos := '';
  sql := '';
  cae := '';
  vto := '';
  pagare := '';
  pre := False;
  pgr := False;
  esCompra := False;
  noGra := 0;
  pagCueIva := 0;
  pagCueOtr := 0;
  perIIBB := 0;
  perImpMun := 0;
  impInt := 0;
  otrTrib := 0;
  cost := 0;
  com := 0;
  impu := 0;
  cheq := 0;
  ch3q := 0;
  cont := 0;
  tot := 0;
  sbt := 0;
  des := 0;
  tarj := 0;
  otr := 0;
  sal := 0;
  pag := 0;
  int := 0;
  n10 := 0;
  n21 := 0;
  i10 := 0;
  i21 := 0;
  deud := 0;
  ulc := 0;
  cmv := 0;
  comv := 0;
  n3 := 0;
  i3 := 0;
  per := 0;
  ret := 0;
  aIva := 0;
  pvta := 0;

  Pnro := Vnro;
  Ptipo := Vtipo;
end;

destructor TCancelOrderService.Destroy;
begin

  inherited;
end;

procedure TCancelOrderService.Execute;
begin
  with dm do
//    with OperacionDataModule do
    begin
      BaseDatosFB.StartTransaction;
      dm.FormatearFecha;
      esCompra := (tipo = 'Compra');
      if esCompra then
        masOmenos := '-'
      else
        masOmenos := '+';
      cod := inttostr(dm.UltimoRegistro('Operacion', 'CODIGO'));
      // Verificar que la factura Exista y que no este anulada
      qT.Open( // qT.sql.Text :=
        'Select * From "' + tipo + '" Where CODIGO = ' + nro); // qT.open;
      if qT.RecordCount = 0 then
      begin
        // MessageDlg(' no existe.', mtError, [mbOK], 0);
        qT.Close;
        // Exit;
      end // end;
      // if qT.FieldByName('ANULADA').AsString = 'S' then
      // begin
      // MessageDlg(' ya esta anulada.', mtError, [mbOK], 0);
      // qT.Close;
      // Exit;
      // end;
      // FormatSettings.ShortDateFormat := 'mm';
      /// /  If (DateToStr(now) > DateToStr(qT.Fields[2].AsDateTime+1)) then
      // If ((now-30) > (qT.Fields[2].AsDateTime)) then
      // begin
      // MessageDlg(' no se puede anular por ser de un periodo anterior', mtError,
      // [mbOK], 0);
      // qT.Close;
      // Exit;
      // end;
      // if MessageDlg('Est� seguro que desea anular la '+tipo+' '+ nro + '?',
      // mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      else
      begin
        fech := FormatDateTime('mm/dd/yyyy hh:mm:ss', now);
        ven := qT.FieldByName('VENDEDOR').AsString;
        if ven = '' then
          ven := '0';
        let := qT.FieldByName('LETRA').AsString;
        comp := qT.FieldByName('COMPROBANTE').AsString;
        sal := qT.FieldByName('SALDO').AsFloat;
        cont := qT.FieldByName('CONTADO').AsFloat;
        pag := qT.FieldByName('PAGADO').AsFloat;
        tot := RoundTo(qT.FieldByName('TOTAL').AsFloat, -2);
        cheq := qT.FieldByName('CHEQUE').AsFloat;
        ch3q := qT.FieldByName('OTROS').AsFloat;
        tarj := qT.FieldByName('TARJETA').AsFloat;
        impu := RoundTo(qT.FieldByName('IMPUESTO').AsFloat, -2);
        i10 := RoundTo(qT.FieldByName('IVA1').AsFloat, -2);
        i21 := RoundTo(qT.FieldByName('IVA2').AsFloat, -2);
        i3 := RoundTo(qT.FieldByName('IVA3').AsFloat, -2);
        aIva := qT.FieldByName('ALICIVA').AsInteger;
        vto := qT.FieldByName('TERMINOS').AsString;
        pvta := qT.FieldByName('EMPRESA').AsInteger;
        per := qT.FieldByName('IIBB').AsFloat;
        ret := qT.FieldByName('MINIMP').AsFloat;
        des := qT.FieldByName('DESCUENTO').AsFloat;
        sbt := RoundTo(qT.FieldByName('SUBTOTAL').AsFloat, -2);
        // tot := qT.FieldByName('TOTAL').AsFloat;
        if (let = 'A') or (let = 'B') then
        begin
          i10 := RoundTo(dm.TraerValor2('AlicIva', 'IMPORTE', inttostr(aIva),
            'ID', '4'), -2);
          // if i10=0 then i10 := qT.FieldByName('IVA1').AsFloat;
          n10 := RoundTo(dm.TraerValor2('AlicIva', 'BASEIMP', inttostr(aIva),
            'ID', '4'), -2);
          // if n10=0 then n10 := qT.FieldByName('SUBTOTAL').AsFloat;
          i21 := RoundTo(dm.TraerValor2('AlicIva', 'IMPORTE', inttostr(aIva),
            'ID', '5'), -2);
          // if i21=0 then i21 := qT.FieldByName('IVA2').AsFloat;
          n21 := RoundTo(dm.TraerValor2('AlicIva', 'BASEIMP', inttostr(aIva),
            'ID', '5'), -2);
          // if n21=0 then n21 := qT.FieldByName('SUBTOTAL').AsFloat;
        end;
        if esCompra then
          cli := qT.FieldByName('PROVEEDOR').AsString
        else
        begin
          cli := qT.FieldByName('CLIENTE').AsString;
          cmv := qT.FieldByName('COSTO').AsFloat;
          deud := qT.FieldByName('DEUDA').AsFloat;
          comv := qT.FieldByName('COMISION').AsFloat;
          if qT.FieldByName('PAGARE').AsString = 's' then
            pgr := True;
        end;
        qT.Close;
        if esCompra then
        begin
          // +++TRAER PROVEEDOR
          pgr := False;
          qT.Open( // qT.sql.Text :=
            'select * from "Proveedor" where CODIGO=' + cli); // qT.open;
          cno := qT.FieldByName('CTANOMBRE').AsString;
          cui := qT.FieldByName('CUIT').AsString;
          if cui = '' then
            cui := qT.FieldByName('DOCUMENTO').AsString;
          if cui = '' then
            cui := '20222222223';
        end
        else
        begin
          // +++TRAER CLIENTE
          qT.Open( // qT.sql.Text :=
            'select * from "Cliente" where CODIGO=' + cli); // qT.open;
          cno := qT.FieldByName('CTANOMBRE').AsString;
          cui := qT.FieldByName('CUIT').AsString;
          if cui = '' then
            cui := qT.FieldByName('DOCUMENTO').AsString;
          if cui = '' then
            cui := '20222222223';
          qT.Close;
        end;
        //
        cbteAsoc := inttostr(dm.UltimoRegistro('CbtesAsoc', 'CODIGO'));
        // ---
        // ---Nota de credito electronica
        with dm do
        begin
          if (not esCompra) and (reporte = 'FElectronica') or
            (reporte = 'TElectronica') then
          begin
            LeerINI;
            comp := ObtenerNroComp('NC' + let);
            OperacionDataModule.WSFE(fech, 'NC' + let, '1', '96', cui, comp, FloatToStr(sbt),
              FloatToStr(impu), FloatToStr(tot), let, asocNro, FloatToStr(n10),
              FloatToStr(n21), FloatToStr(i10), FloatToStr(i21));
            if cae = '' then
              Exit; // if mensaje <> 'Ok' then Exit;
            if comp <> '' then
              ActualizarNroComp('NC' + let, comp);
          end;
        end;
        // Marcar la Factura como anulada y poner los saldos en cero
        BaseDatosFB.ExecSQL(
          // qQ.sql.Text :=
          'Update "' + tipo + '" set ANULADA = ''S'' where CODIGO = ' + nro);
        // qQ.ExecSQL;
        // AlicuotaIVA
        aIva := OperacionDataModule.InsertarAlicIva;
        // INSERTA EN LA TABLA OPERACION
        if tipo = 'Compra' then
          nctipo := 'CNC'
        else
          nctipo := 'NC';
        nctipo := nctipo + let;
        sql := 'Insert Into "Operacion" (COMPROBANTE, TERMINOS, CODIGO' +
          ', TIPO, LETRA' +
          ', CLIENTE, VENDEDOR, SUBTOTAL' +
          ', DESCUENTO, FECHA, IMPUESTO'+
          ', IVA1, IVA2, IVA3'+
          ', TOTAL, CONTADO, CHEQUE' +
          ', TARJETA, OTROS, SALDO' + ', PAGADO, PAGARE, COSTO' +
          ', DEUDA, COMISION, DESCRIPCION' +
          ', CBTESASOC, ALICIVA, EMPRESA' +
          ', IIBB, MINIMP' + ') Values ('
          + QuotedStr(comp) + ', ' + QuotedStr(vto) + ', ' + (cod) +
          ', ' + QuotedStr(nctipo) + ', ' + QuotedStr(let) +
          ', ' + cli + ', ' + ven + ', ' + FloatToStr(sbt) +
          ', ' + FloatToStr(des) + ', ' + QuotedStr(fech) + ', ' + FloatToStr(impu) +
          ', ' + floattostr(i10) + ', ' + floattostr(i21) + ', '+ floattostr(i3)+
          ', ' + FloatToStr(tot) + ', ' + FloatToStr(cont) +
          ', ' + FloatToStr(cheq) + ', ' + FloatToStr(tarj) + ', ' +
          FloatToStr(otr) + ', ' + FloatToStr(sal) + ', ' + FloatToStr(pag) +
          ', ' + QuotedStr(pagare) + ', ' + FloatToStr(cmv) + ', ' +
          FloatToStr(deud) + ',' + FloatToStr(comv) + ', ' + QuotedStr(cae) +
          ', ' + (cbteAsoc) + ', ' + inttostr(aIva) + ', ' + IntToStr(pvta ) +
          ', ' + FloatToStr(per) + ', ' + FloatToStr(ret) + ')';
        BaseDatosFB.ExecSQL( // qQ.sql.Text :=
          sql); // qQ.ExecSQL;
        // Insertar en la tabla de OPERACIONITEM
        qT.Open( // qT.sql.Text :=
          'Select * From "' + tipo + 'Item" Where OPERACION = ' + nro); // qT.open;
        qT.First;
        while not qT.Eof do
        begin
          BaseDatosFB.ExecSQL( // qQ.sql.Text :=
            'Insert Into "OperacionItem" (OPERACION, ARTICULO, CANTIDAD' +
            ', COSTO, PRECIO, IMPUESTO'+
            ', SERVICIO, DESCRIPCION) Values' + ' ( ' + cod +
            ', ' + qT.FieldByName('ARTICULO').AsString + ', ' + qT.FieldByName('CANTIDAD').AsString +
            ',' + qT.FieldByName('COSTO').AsString + ', ' + qT.FieldByName('PRECIO').AsString + ', ' + qT.FieldByName('IMPUESTO').AsString +
            ', ' + nro + ', ' + QuotedStr(qT.FieldByName('DESCRIPCION').AsString) + ');');
          // qQ.ExecSQL;
          // Actualizar la tabla de Articulos
          OperacionDataModule.ActualizarCantidadArticulo(qT.FieldByName('ARTICULO').AsString,
            masOmenos + ' ' + qT.FieldByName('CANTIDAD').AsString);
          qT.Next;
        end;
        //
        BaseDatosFB.ExecSQL( // qQ.sql.Text :=
          'Insert Into "CbtesAsoc" (' +
          ' CODIGO, TIPO, PTOVTA, NRO, CUIT, CBTEFCH' + ' ) Values' + ' (' +
          cbteAsoc + ', ' + dm.TraerTipoCbte(let) + ', ' + PuntoVenta + ', ' +
          QuotedStr(asocNro) + ', ' + QuotedStr(cui) + ', ' + QuotedStr(fech) +
          ')'); // qQ.ExecSQL;
        // Borrar los Items de la factura de la tabla "VentaItem"
        // qQ.sql.Text := 'DELETE FROM "VentaItem" WHERE "VentaItem".OPERACION=' + nro;
        // qQ.ExecSQL;
        // Borrar los Items de la factura de la tabla "CtaCteItem"
        BaseDatosFB.ExecSQL( // qQ.sql.Text :=
          'DELETE FROM "CtaCteItem" WHERE "CtaCteItem".OPERACION=' + nro);
        // qQ.ExecSQL;
        // ACTUALIZAR SALDOS
        sql := 'Update "CtaCte" Set SALDO = SALDO - ' + FloatToStr(sal) +
          ' Where ';
        if esCompra then
          sql := sql + 'CLIENTE'
        else
          sql := sql + 'PROVEEDOR';
        sql := sql + ' = ' + cli;
        BaseDatosFB.ExecSQL(
          /// /qQ.sql.Text :=
          sql); // qQ.ExecSQL;
        // CONTABILIDAD+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        // LIBRO IVA
        if (let = 'A') or (let = 'B') then
          if esCompra then
            OperacionDataModule.LibroIVACompra(fech, nro, cli, cui, FloatToStr(n10),
              FloatToStr(n21), FloatToStr(n3), FloatToStr(i10), FloatToStr(i21),
              FloatToStr(i3), FloatToStr(per), FloatToStr(ret), FloatToStr(tot))
          else
            OperacionDataModule.LibroIVAvta(fech, nro, cli, cui, FloatToStr(-n10), FloatToStr(-n21),
              FloatToStr(-i10), FloatToStr(-i21), FloatToStr(-tot));
        // en blanco
        // Retenciones y Percepciones
        dm.AgregarRetPer('N' + UpperCase(tipo), StrToInt(nro), noGra, pagCueIva,
          pagCueOtr, perIIBB, perImpMun, impInt, otrTrib);
        // Insertar en la tabla LibroDiario
        a := inttostr(dm.UltimoRegistro('LibroDiario', 'ASIENTO'));
        // GENERAR INDICE
        // ------------------------------------------------------------------------------
        if esCompra then
          OperacionDataModule.LibroDiario('COMPRA', nro, let, cod, fech, pgr, tot, pag, cheq, ch3q,
            cont, tarj, impu, deud, cmv, 0)
        else
        begin
          // VENTAS
          OperacionDataModule.Asiento(dm.ConfigQuery.FieldByName('CtaVenta').AsString, a, fech,
          (nro + ' - ' + let + ' - ' + cod), floattostr(tot), '0');
          // renglon  - VENTAS
          // si es factura A
          if let = 'A' then
            OperacionDataModule.Asiento(dm.ConfigQuery.FieldByName('CtaIVADebitoFiscal').AsString, a, fech,
              (nro + ' - ' + let + ' - ' + cod), floattostr(impu), '0');
          // renglon  - IVA DEBITO FISCAL
          // PAGO DE CUENTA CORRIENTE
          if ((pag) > (tot - deud)) then
            OperacionDataModule.Asiento(cno, a, fech, (nro + ' - ' + let + ' - ' + cod + ' - ' + cui),
              floattostr(pag - (tot - deud)), '0'); // renglon  - DEUDORES POR VENTA
          // a
          // PAGO CON
          // CAJA (EFECTIVO)
          if (cont) > 0.04 then
            OperacionDataModule.Asiento(dm.ConfigQuery.FieldByName('CtaCaja').AsString, a, fech,
              (nro + ' - ' + let + ' - ' + cod), '0', floattostr(pag));
          // DSXVTA (CUENTA CORRIENTE)
          if (sal > 0.04) AND (pgr <> True) then
            OperacionDataModule.Asiento(cno, a, fech, (nro + ' - ' + let + ' - ' + cod), '0',
              floattostr(sal));
          // DOC A COBRAR (CON DOCUMENTOS (PAGARE))
          if (pag < tot) AND (pgr = True) then
            OperacionDataModule.Asiento(dm.ConfigQuery.FieldByName('CtaDocumentoACobrar').AsString, a,
              fech, (nro + ' - ' + let + ' - ' + cod), floattostr(sal), '0');
          // VALOR AL COBRO (PAGO CON CHEQUE)
          if (cheq) > 0.04 then
            OperacionDataModule.Asiento(dm.ConfigQuery.FieldByName('CtaValorAlCobro').AsString, a, fech,
              (nro + ' - ' + let + ' - ' + cod), '0', floattostr(cheq));
          // -----------------------------------1------------------------------------------
          // MERCADERIAS DE REVENTA
          OperacionDataModule.Asiento(dm.ConfigQuery.FieldByName('CtaMercaderia').AsString, a, fech,
            (nro + ' - ' + let + ' - ' + cod), floattostr(cmv), '0');
          // a
          // CMV
          OperacionDataModule.Asiento(dm.ConfigQuery.FieldByName('CtaCMV').AsString, a, fech,
            (nro + ' - ' + let + ' - ' + cod), '0', floattostr(cmv));
          // -----------------------------------2------------------------------------------
          if com > 0 then
          begin
            // COMISION VENDEDOR A PAGAR
            OperacionDataModule.Asiento(dm.ConfigQuery.FieldByName('CtaComisionVendedorAPagar').AsString,
              a, fech, (nro + ' - ' + let + ' - ' + cod), floattostr(com), '0');
            // a
            // COMISION VENDEDOR
            OperacionDataModule.Asiento(dm.ConfigQuery.FieldByName('CtaComisionVendedor').AsString, a,
              fech, (nro + ' - ' + let + ' - ' + cod), '0', floattostr(com));
           end;
        end;
        // -----------------------------------3------------------------------------------
        // CONTABILIDAD---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        BaseDatosFB.CommitRetaining;
        // IMPRIMIR
        if ( (not esCompra) and (dm.ConfigQuery.FieldByName('Imprimir').AsString <> 'NO') ) then
        begin
          ImprimirDataModule := TImprimirDataModule.Create(nil);
          if reporte = 'FElectronica' then
            reporte := 'NCElectronica'
          else if reporte = 'TElectronica' then
            reporte := 'NCTElectronica'
          else if reporte = 'CTicket' then
            reporte := 'NCTicket'
          else if reporte = 'COriginal' then
            reporte := 'CNCredito';
          with ImprimirDataModule do
            Impr(oper(cod, 'NC' + let, let), 'NC' + let);
          ImprimirDataModule.Free;
        end;
//          // IMPRIMIR
//          if (dm.ConfigQuery.FieldByName('Imprimir').AsString) <> 'NO' then
//          begin
//            ImprimirDataModule := TImprimirDataModule.Create(nil);
//            with ImprimirDataModule do
//              //Impr(vta((nro), let), let);
//              Impr(oper(cod, 'NC' + let, let), 'NC' + let); // reporte);
//            ImprimirDataModule.Free;
//          end;
      end;
    end;
end;

end.
