
FUNCTION RECRIA_REL_TESTES()

   LOCAL cTexto:='', nArquivo, cArquivo:='C:\REL_TESTES.CSV', cSeparador:=';'

   cTexto:='COD_TESTE'         +cSeparador
   cTexto+='NOME_FUNÇÃO'       +cSeparador
   cTexto+='VALOR'             +cSeparador
   cTexto+='RESULTADO_ESPERADO'+cSeparador
   cTexto+='RESULTADO_OBTIDO'  +cSeparador
   cTexto+='RESULTADO'         +cSeparador+cCRLF

   nArquivo:=FCREATE(cArquivo)
   IF FILE(cArquivo)
      FSEEK(nArquivo,0,2)
      FWRITE(nArquivo,cTexto)
      FCLOSE(nArquivo)
   ENDIF

RETURN NIL

FUNCTION GRAVA_REL_TESTES(nCodTeste, cFuncao, cValor, cResultEsperado, cResultObtido, lNovaFuncao)

 LOCAL cTexto:=''
 LOCAL nArquivo, cArquivo:='C:\REL_TESTES.CSV', cSeparador:=';'
 LOCAL cCodTeste:=Str(nCodTeste)
 LOCAL cConclusao:=IIF(cResultEsperado==cResultObtido,'Passou','Falhou')

 lNovaFuncao:=IIF(lNovaFuncao==NIL,.F.,lNovaFuncao)

 IF lNovaFuncao
    cTexto+=cCRLF
 ENDIF

 cTexto+=cCodTeste      +cSeparador
 cTexto+=cFuncao        +cSeparador
 cTexto+=cValor         +cSeparador
 cTexto+=cResultEsperado+cSeparador
 cTexto+=cResultObtido  +cSeparador
 cTexto+=cConclusao     +cSeparador+cCRLF

 IF FILE(cArquivo)
    *MessageBox(,cTexto)
    nArquivo:=FOPEN(cArquivo,2)
    FSEEK(nArquivo,0,2)
    FWRITE(nArquivo,cTexto)
    FCLOSE(nArquivo)
 ENDIF

RETURN NIL