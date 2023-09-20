     H DATEDIT(*YMD)
     F*=================================================================*
     F* PROGRAMA COMPACTO SUBFILE DE CLIENTES  - ARC01                  *
     F*=================================================================*
     *****DEFINICION DE ARCHIVOS
     FCLIENTES  CF   E             WORKSTN
     F                                     SFILE(CL1:NRR01)
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
     C**RENUEVA PANTALLA Y SE OPRIME F5
     C     *IN05         IFEQ      '1'
     C                   CLEAR                   CL1CTL
     C                   ENDIF
     C**IMPRIME PANTALLAS Y LLENA SUBFILE
     C                   EXSR      CARGARSUB
     C                   CLEAR                   WNID
     C                   EXFMT     CL1CTL
     C* OTRAS OPCIONES ///////
     C*
     C*
     C     *INKC         IFEQ      '1'
     C                   MOVE      '1'           *INLR
     C                   ELSE
     C     KERROR        IFNE      2
     C                   EXSR      EVALOPCION
     C                   ELSE
     C                   MOVE      '1'           *INLR
     C                   ENDIF
     C                   ENDIF
     C                   ENDSR
     C*============================================================*
     C* RUTINA PARA CARGA SUBFILE INCIAL O POR CONSULTA
     C*============================================================*
     C     CARGARSUB     BEGSR
     C                   Z-ADD     0             NRR01             5 0
     C                   EXSR      BORSFL
     C* EVALUA SI ES POR CONSULTA
     C     WNID          IFGT      0
     C                   Z-ADD     WNID          ARC1NID
     C                   EXSR      CONSULTAR
     C     *IN10         IFEQ      '0'
     C                   EXSR      MOVCAM
     C                   EXFMT     CL1CTL
     C                   ELSE
     C*  AQUI SE ENVIA EL ERROR QUE EL NID NO EXISTE
     C                   ENDIF
     C                   ELSE
     C* SE CARGA EL SUBFILE INICIAL
     C                   EXSR      CARGARDATOS
     C     NRR01         IFGT      0
     C                   MOVE      '1'           *IN90
     C                   ELSE
     C                   MOVE      '0'           *IN90
     C                   ENDIF
     C                   ENDIF
     C                   MOVE      '0'           *IN93
     C                   ENDSR
     C*============================================================*
     C*        RUTINA PARA CARGA SUBFILE
     C*============================================================*
     C     CARGARDATOS   BEGSR
     C                   Z-ADD     0             ARC1NID
     C                   MOVE      '0'           *IN01
     C     LLA001        SETLL     ARC01
     C     *IN01         DOWEQ     '0'
     C                   READ      ARC01                                  01
     C     *IN01         IFEQ      '0'
     C                   EXSR      MOVCAM
     C                   ENDIF
     C                   ENDDO
     C     NRR01         IFEQ      0
     C*** ENVIA ERROR NO HAY REGISTROS A MOSTRAR
     C                   ENDIF
     C                   ENDSR
     C*============================================================*
     C*   MOVER CAMPOS A PANTALLA SUBFILE
     C*============================================================*
     C     MOVCAM        BEGSR
     C                   MOVEL     *BLANKS       WNOMCLI          40
     C                   Z-ADD     ARC1NID       WCNID
     C                   MOVEL     ARC1NOM       WNOMCLI
     C                   CAT       ARC1APE:1     WNOMCLI
     C                   MOVEL     WNOMCLI       WCNOMAPE
     C                   ADD       1             NRR01
     C                   MOVEL     *BLANKS       WOPC
     C                   WRITE     CL1
     C                   ENDSR
     C*============================================================*
     C*   CONSULTAR ARCHIVO CLIENTES
     C*============================================================*
     C     CONSULTAR     BEGSR
     C     LLA001        CHAIN     ARC01                                10
     C                   ENDSR
     C*============================================================*
     C*   MOVER CAMPOS A PANTALLA DE CONSULTA
     C*============================================================*
     C     MOVCAM1       BEGSR
     C                   Z-ADD     ARC1NID       WCNID
     C                   Z-ADD     ARC1TIP       WCTINID
     C                   MOVEL     ARC1NOM       WCNOM
     C                   MOVEL     ARC1APE       WCAPE
     C                   Z-ADD     ARC1EDA       WCEDA
     C                   MOVEL     ARC1SEX       WCGEN
     C                   Z-ADD     ARC1TEL       WCTEL
     C                   MOVEL     ARC1IND       WCIND
     C                   MOVEL     ARC1DIR       WCDIR
     C                   MOVEL     ARC1CIU       WCCIU
     C                   EXFMT     CONSUL
     C                   ENDSR
     C*============================================================*
     C*   EVALUAR LAS DIFERENTES OPCIONES
     C*============================================================*
     C     EVALOPCION    BEGSR
     C     NRR01         IFGT      0
     C                   MOVE      '0'           *IN03
     C     *IN03         DOWEQ     '0'
     C                   READC     CL1                                    03
     C     *IN03         IFEQ      '0'
     C                   SELECT
     C     WOPC          WHENEQ    '2'
     C** RUTINA PARA MODIFICAR
     C     WOPC          WHENEQ    '4'
     C** RUTINA PARA ELIMINAR
     C     WOPC          WHENEQ    '5'
     C                   Z-ADD     WCNID         ARC1NID
     C                   EXSR      CONSULTAR
     C                   EXSR      MOVCAM1
     C                   ENDSL
     C                   MOVE      *BLANKS       WOPC
     C                   UPDATE    CL1
     C                   ENDIF
     C                   ENDDO
     C                   ENDIF
     C                   ENDSR
     C*============================================================*
     C*   EVALUAR LAS DIFERENTES OPCIONES
     C*============================================================*
     C     BORSFL        BEGSR
     C                   MOVE      '0'           *IN90
     C                   MOVE      '0'           *IN91
     C                   MOVE      '1'           *IN92
     C                   WRITE     CL1CTL
     C                   MOVE      '0'           *IN92
     C                   MOVE      '1'           *IN90
     C                   MOVE      '1'           *IN91
     C                   ENDSR
     C*============================================================*
     C*   EVALUAR LAS DIFERENTES OPCIONES
     C*============================================================*
     C     INVAR         BEGSR
     C                   Z-ADD     0             KERROR            1 0
     C                   ENDSR
