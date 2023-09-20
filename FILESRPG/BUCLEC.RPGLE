     C*=====================================================================*
     C*     LOGICA PRINCIPAL                                                *
     C*=====================================================================*
     C                   Z-ADD     5             VAR1              2 0
     C     VAR1          DOUEQ     10
     C                   ADD       1             VAR1
     C****          ESTA SERIA EL BLOQUE DE CODIGO A EJECUTAR **********
     C                   ENDDO
     C***********************************************
     C                   Z-ADD     5             VAR1              2 0
     C                   Z-ADD     1             VAR2              2 0
     C                   MOVE      'OK'          TEXT1             2
     C     VAR1          DOWLT     10
     C     TEXT1         ANDEQ     'OK'
     C                   ADD       1             VAR1
     C****          ESTA SERIA EL BLOQUE DE CODIGO A EJECUTAR **********
     C                   ENDDO
     C******************************************************
     C                   Z-ADD     5             VAR2              2 0
     C                   Z-ADD     0             VAR3              2 0
     C                   DO        VAR1          VAR2
     C                   ADD       1             VAR3
     C****          ESTA SERIA EL BLOQUE DE CODIGO A EJECUTAR **********
     C                   ENDDO
     C
     C
     C
     C                   MOVE      '1'           *INLR
     C
     C
     C
     C
     C
     C
