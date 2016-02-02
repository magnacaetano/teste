
FUNCTION AreEqual(xParametro1, xParametro2)

 LOCAL i //teste Magna
 MEMVAR lRetorno
 PRIVATE lRetorno:=.T.

 IF ValType(xParametro1) <> ValType(xParametro2)
    RETURN .F.
 ENDIF

 IF ValType(xParametro1) == 'A'
    IF Len(xParametro1) <> Len(xParametro2)
       RETURN .F.
     ELSE
       FOR i:=1 TO Len(xParametro1)
           IF !AreEqual(xParametro1[i], xParametro2[i])
              lRetorno := .F.
              RETURN .F.
           ENDIF
           IF !lRetorno
              RETURN .F.
           ENDIF
       NEXT
       lRetorno := .T.
    ENDIF
  ELSE
    lRetorno := xParametro1==xParametro2
 ENDIF

RETURN lRetorno