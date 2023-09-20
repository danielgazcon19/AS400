     H DATEDIT(*YMD)
     F*=================================================================*
     F* ADMINISTRACION CREACION INFORMACION BASICA DE CLIENTES - ARC01  *
     F*=================================================================*
     *****DEFINICION DE ARCHIVOS
     FPGM012D   CF   E             WORKSTN
     F* PANTALLA DE CREACION CLIENTES
     FARC01     IF   E           K DISK
     F* ARCHIVO DE CLIENTES
     D*
     D***HOJA D DEFINICION DE ESTRUCTURAS
     D*
     I*
     C*** DEFINICION DE LLAVES
     C     LLA001        KLIST
     C                   KFLD                    ARC1NID
     C****LOGICA PRINCIPAL
     C                   MOVE      '0'           *IN11
     C                   EXSR      INVAR
     C     *INLR         DOUEQ     '1'
     C                   EXSR      PROCES
     C                   ENDDO
     C*==========================================================*
     C*   RUTINA PRINCIPAL DEL PROGRAMA
     C*======================================================*
     C     PROCES        BEGSR
     C**IMPRIME PANTALLAS
     C                   EXFMT     PGM012R
     C     *INKC         IFEQ      '1'
     C                   MOVE      '1'           *INLR
     C                   ELSE
     C     KERROR        IFNE      2
     C                   EXSR      VERIFI
     C                   ELSE
     C                   MOVE      '1'           *INLR
     C                   ENDIF
     C                   ENDIF
     C                   ENDSR
     C*============================================================*
     C*                  VALIDO  DATOS
     C*============================================================*
     C     VERIFI        BEGSR
     C                   Z-ADD     0             KERROR            1 0
     C     WNEXT         IFEQ      0
     C     WRC1NID       IFGT      0
     C                   Z-ADD     WRC1NID       ARC1NID
     C     LLA001        CHAIN     ARC01                              01
     C     *IN01         IFEQ      '1'
     C                   Z-ADD     1             KERROR
     C                   ELSE
     C                   Z-ADD     1             WNEXT             1 0
     C                   MOVE      '1'           *IN11
     C                   EXSR      MOVCAM
     C                   ENDIF
     C                   ELSE
     C                   MOVE      '1'           *IN11
     C                   Z-ADD     1             WNEXT
     C                   EXSR      LEEARC
     C                   ENDIF
     C                   ELSE
     C                   EXSR      LEEARC
     C                   ENDIF
     C                   ENDSR
     C*============================================================*
     C*   LECTURA SECUENCIAL DEL ARCHIVO
     C*============================================================*
     C     MOVCAM        BEGSR
     C                   Z-ADD     ARC1NID       WRC1NID
     C                   Z-ADD     ARC1TIP       WRC1TIP
     C                   MOVEL     ARC1NOM       WRC1NOM
     C                   MOVEL     ARC1APE       WRC1APE
     C                   Z-ADD     ARC1EDA       WRC1EDA
     C                   MOVEL     ARC1SEX       WRC1GEN
     C                   Z-ADD     ARC1TEL       WRC1TEL
     C                   MOVEL     ARC1IND       WRC1IND
     C                   MOVEL     ARC1DIR       WRC1DIR
     C                   MOVEL     ARC1CIU       WRC1CIU
     C                   ENDSR
     C*============================================================*
     C*   LECTURA SECUENCIAL DEL ARCHIVO
     C*============================================================*
     C     LEEARC        BEGSR
     C                   MOVE      '0'           *IN10
     C                   READ      ARC01                                  10
     C     *IN10         IFEQ      '1'
     C                   Z-ADD     2             KERROR
     C                   MOVE      '0'           *IN11
     C                   ELSE
     C                   EXSR      MOVCAM
     C                   ENDIF
     C                   ENDSR
     C*============================================================*
     C*   INICIALIZO VARIABLES DE ARCHIVO/PANTALLA
     C*============================================================*
     C     INVAR         BEGSR
     C                   Z-ADD     0             WRC1NID
     C                   Z-ADD     0             WRC1TIP
     C                   MOVEL     *BLANKS       WRC1NOM
     C                   MOVEL     *BLANKS       WRC1APE
     C                   Z-ADD     0             WRC1EDA
     C                   MOVEL     *BLANKS       WRC1GEN
     C                   Z-ADD     0             WRC1TEL
     C                   MOVEL     *BLANKS       WRC1IND
     C                   MOVEL     *BLANKS       WRC1DIR
     C                   MOVEL     *BLANKS       WRC1CIU
     C                   ENDSR
