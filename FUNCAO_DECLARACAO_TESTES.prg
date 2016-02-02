
#INCLUDE "\\SOMMUS006\D\XHARBOUR\INCLUDE\INKEY.CH"
#INCLUDE "\\SOMMUS002\D\SOMMUS\DESENVOLVIMENTO\PROJETOS\UTIL\WINUSER.CH"
#INCLUDE "VAREJO.CH"
#INCLUDE "\\SOMMUS002\D\SOMMUS\DESENVOLVIMENTO\PROJETOS\UTIL\SOMMUS_TRANSLATE.CH"

FUNCTION LISTAR_TESTES()

   LOCAL aListaFuncoes:={}

   IF !ABREARQ('FUN_TEST')
      RETURN NIL
   ENDIF

   //RECRIA_REL_TESTES()

   *----------------------------------------------------------------------------
   // TESTES GLOBAIS
      // GERAL_CADASTRO_VALIDA_CPF_TESTE()

      // TESTES DE ENTRADA DE NOTA

      // TESTES DE NOTA FISCAL ELETRONICA

   *----------------------------------------------------------------------------
   // TESTES AUTOPECA

   *----------------------------------------------------------------------------
   // TESTES FARMACIA

   *----------------------------------------------------------------------------
   // TESTES POSTO

   *----------------------------------------------------------------------------
   // TESTES VAREJO
   IF cProgSCI=='SCIVR'
      AAdd(aListaFuncoes,'GERAL_CADASTRO')
      AAdd(aListaFuncoes,'GERAL_CADASTRO_VALIDA_CPF_TESTE()')
   ENDIF

   *----------------------------------------------------------------------------
   // TESTES CTE

   *----------------------------------------------------------------------------
   ATUALIZA_DBF(aListaFuncoes)
   TELA_LISTA_TESTES()

   FECHAARQ()

RETURN NIL

FUNCTION ATUALIZA_DBF(aListaFuncoes)

   LOCAL i

   SELECT FUN_TEST

   OrdSetFocus('FCT_NOME')

   FOR i:=1 TO Len(aListaFuncoes)
      IF !DBSeek(aListaFuncoes[i])
         REGNOVO()
         TROCA('NOME_FUNC', aListaFuncoes[i])
      ENDIF
   NEXT
   DBCommitAll()
   DBGoTop()

RETURN NIL

*-------------------------------------------------------------------------------
FUNCTION TELA_LISTA_TESTES()

   LOCAL aDados:={}
   LOCAL cSB_Texto:="ENTER-Marcar/desmarcar registro   F2-Marcar todos   F3-Desmarcar todos   F4-Executar testes"
   LOCAL aFuncoes:={}

   SELECT FUN_TEST

   AAdd(aDados,{' • '             ,'IIF(MARCADO," • ","   ")'})
   AAdd(aDados,{'Funções de Teste','IIF(VALIDA_FUNCAO(),"   > "," > ")+SUBSTR(NOME_FUNC,1,50)'})

   AADD(aFuncoes,{K_ENTER ,"MARCA_FUNC()"           ,IMG_Lapis     ,"Marca/desmarca registro (ENTER)",.T.})
   AADD(aFuncoes,{K_F2    ,"MARCA_FUNC_TODOS(.T.)"  ,IMG_Sremessa  ,"Marcar todos os registros (F2)",.T.})
   AADD(aFuncoes,{K_F3    ,"MARCA_FUNC_TODOS(.F.)"  ,IMG_Sremessa  ,"Desmarcar todos os registros (F3)",.T.})
   AADD(aFuncoes,{K_F4    ,"EXECUTAR_TESTES()"      ,IMG_Sremessa  ,"Executar testes (F4)",.T.})

   DBGRID("Testes Automáticos - Sommus",aDados,aFuncoes,03,05,21,68,cSB_Texto,.F.,.T.)

RETURN NIL
*-------------------------------------------------------------------------------
FUNCTION MARCA_FUNC_TODOS(lValor)

   LOCAL nRegitro

   nRegitro:=RecNo()
   DBGoTop()

   DO WHILE !Eof()
      TRAVA('R')
      TROCA('MARCADO', lValor)

      DBSkip()
   ENDDO

   DBGoTo(nRegitro)

RETURN NIL

*-------------------------------------------------------------------------------
FUNCTION MARCA_FUNC()

   LOCAL cNomeCabecalho, nRegitro

   TRAVA('R')
   TROCA('MARCADO', !MARCADO)

   IF !VALIDA_FUNCAO()
      cNomeCabecalho:=NOME_FUNC

      nRegitro:=RecNo()
      lMarcado:=MARCADO
      DBGoTop()

      DO WHILE !Eof()

         IF At(cNomeCabecalho,NOME_FUNC)>0
            TRAVA('R')
            TROCA('MARCADO', lMarcado)
         ENDIF
         DBSkip()

      ENDDO

      DBGoTo(nRegitro)
   ENDIF

RETURN NIL

*-------------------------------------------------------------------------------
FUNCTION VALIDA_FUNCAO()

   IF At('(',NOME_FUNC)>0
      RETURN .T.
   ENDIF

RETURN .F.

*-------------------------------------------------------------------------------
FUNCTION EXECUTAR_TESTES()

   MSG_DEBUG('ABRE FUNÇÃO "EXECUTAR_TESTES"')

RETURN NIL