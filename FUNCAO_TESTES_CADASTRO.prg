
#define ASSERT(nValor1, nValor2) AreEqual(nValor1, nValor2)

FUNCTION GERAL_CADASTRO_VALIDA_CPF_TESTE()

 LOCAL i, aCpfssValidos:={'11808614690','07560212603','123456789'}

 FOR i:=1 TO Len(aCpfssValidos)
    IF ASSERT(.T., VERCPF(aCpfssValidos[i],.F.,.F.))
         GRAVA_REL_TESTES(i,ProcName(),aCpfssValidos[i],'Válido','Válido'  ,IIF(i==1,.T.,.F.))
     ELSE
         GRAVA_REL_TESTES(i,ProcName(),aCpfssValidos[i],'Válido','Inválido',IIF(i==1,.T.,.F.))
    ENDIF
 NEXT

RETURN NIL