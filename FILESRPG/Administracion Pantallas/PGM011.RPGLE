     H DATEDIT(*YMD)
     F*=================================================================*
     F* ADMINISTRACION CREACION INFORMACION BASICA DE CLIENTES - ARC01  *
     F*=================================================================*
     *****DEFINICION DE ARCHIVOS
     FPGM011D   CF   E             WORKSTN
     F* PANTALLA DE CREACION CLIENTES
     FARC01     UF A E           K DISK
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
     C                   EXFMT     PGM011R
     C     *INKC         IFEQ      '1'
     C                   MOVE      '1'           *INLR
     C                   ELSE
     C     *INKJ         IFEQ      '0'
     C                   EXSR      VERIFI
     C                   ELSE
     C                   EXSR      CAPTU
     C                   ENDIF
     C                   ENDIF
     C                   ENDSR
     C*============================================================*
     C*                  VALIDO  DATOS
     C*============================================================*
     C     VERIFI        BEGSR
     C                   Z-ADD     0             KERROR            1 0
     C     WRC1NID       IFGT      0
     C                   Z-ADD     WRC1NID       ARC1NID
     C     LLA001        CHAIN     ARC01                              01
     C     *IN01         IFEQ      '1'
     C                   Z-ADD     1             KERROR
     C                   ELSE
     C                   MOVE      '1'           *IN11
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
     C                   ENDIF
     C                   ENDIF
     C                   ENDSR
     C*============================================================*
     C*                  VALIDO  DATOS
     C*============================================================*
     C     CAPTU         BEGSR
     C                   Z-ADD     0             KERROR            1 0
     C     WRC1NID       IFGT      0
     C                   Z-ADD     WRC1NID       ARC1NID
     C     LLA001        CHAIN     ARC01                              01
     C     *IN01         IFEQ      '1'
     C                   Z-ADD     1             KERROR
     C                   ELSE
     C     WRC1TIP       IFEQ      0
     C     WRC1EDA       ANDEQ     0
     C                   Z-ADD     1             KERROR
     C                   ELSE
     C     WRC1NOM       IFEQ      *BLANKS
     C     WRC1APE       ANDEQ     *BLANKS
     C     WRC1DIR       ANDEQ     *BLANKS
     C                   Z-ADD     1             KERROR
     C                   ENDIF
     C                   ENDIF
     C                   ENDIF
     C                   ELSE
     C                   Z-ADD     1             KERROR
     C                   ENDIF
     C     KERROR        IFEQ      0
     C                   EXSR      UPDUSU
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
     C*=============================================================*
     C*  RUTINA DE MODIFICACION DEL REGISTRO DEL USUARIO
     C*=============================================================*
     C     UPDUSU        BEGSR
     C                   Z-ADD     WRC1NID       ARC1NID
     C                   Z-ADD     WRC1TIP       ARC1TIP
     C                   MOVEL     WRC1NOM       ARC1NOM
     C                   MOVEL     WRC1APE       ARC1APE
     C                   Z-ADD     WRC1EDA       ARC1EDA
     C                   MOVEL     WRC1GEN       ARC1SEX
     C                   Z-ADD     WRC1TEL       ARC1TEL
     C                   MOVEL     WRC1IND       ARC1IND
     C                   MOVEL     WRC1DIR       ARC1DIR
     C                   MOVEL     WRC1CIU       ARC1CIU
     C                   UPDATE    ARC01R
     C                   CLEAR                   ARC01R
     C                   MOVE      '0'           *IN11
     C                   EXSR      INVAR
     C                   ENDSR
