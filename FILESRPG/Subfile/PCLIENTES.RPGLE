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
     F*****************************************************
     C*** DEFINICION DE LLAVES
     C     LLA001        KLIST
     C                   KFLD                    ARC1NID
     C* LOGICA PRINCIPAL DE PROGRAMA
     C     *INLR         DOUEQ     '1'
     C                   EXSR      PROCESPRIN
     C                   ENDDO
     C*==========================================================*
     C*   RUTINA PRINCIPAL DEL PROGRAMA                          *
     C*==========================================================*
     C     PROCESPRIN    BEGSR
     C* RENUEVA PANTALLA SI SE PRECIONA TECLA F5
     C     *IN05         IFEQ      '1'
     C                   CLEAR                   CL1CTL
     C                   ENDIF
     C* IMPRIMIR PANTALLA Y LLENAR SUBFILE
     C                   EXSR      CARGARSUB
     C                   EXFMT     CL1CTL
     *** OTRAS OPCIONES A FUTURO
     C*
     C     *INKC         IFEQ      '1'
     C                   MOVE      '1'           *INLR
     C                   ELSE
     C                   EXSR      EVALOPCION
     C                   ENDIF
     C                   ENDSR
     C*============================================================*
     C* RUTINA PARA CARGA SUBFILE INCIAL O POR CONSULTA
     C*============================================================*
     C     CARGARSUB     BEGSR
     C                   Z-ADD     0             NRR01             5 0
     C                   EXSR      BORSFL
     C     WNID          IFGT      0
     C                   Z-ADD     WNID          ARC1NID
     C                   EXSR      CONSULTAR
     C     *IN01         IFEQ      '0'
     C                   EXSR      MOVCAM
     C                   EXFMT     CL1CTL
     C                   ELSE
     C* ENVIA MENSAJE DE ERROR - NO ENCONTRO CLIENTE
     C                   ENDIF
     C                   ELSE
     C* CARGA SUBFILE INCIAL
     C                   EXSR      CARGARDATOS
     C                   ENDIF
     C                   ENDSR
     C*============================================================*
     C*   RUTINA PARA INICIALIZAR SUBFILE
     C*============================================================*
     C     CARGARDATOS   BEGSR
     C                   Z-ADD     0             ARC1NID
     C                   MOVE      '0'           *IN10
     C     LLA001        SETLL     ARC01
     C     *IN10         DOWEQ     '0'
     C                   READ      ARC01                                  10
     C     *IN10         IFEQ      '0'
     C                   EXSR      MOVCAM
     C                   ENDIF
     C                   ENDDO
     C     NRR01         IFEQ      0
     C*** ERROR NO ENCONTRO REGISTROS EN EL ARCHIVO
     C                   ENDIF
     C                   ENDSR
     C*============================================================*
     C*   RUTINA PARA INICIALIZAR SUBFILE
     C*============================================================*
     C     BORSFL        BEGSR
     C                   MOVE      '0'           *IN90
     C                   MOVE      '0'           *IN91
     C                   MOVE      '1'           *IN92
     C                   WRITE     CL1CTL
     C                   MOVE      '1'           *IN90
     C                   MOVE      '1'           *IN91
     C                   MOVE      '0'           *IN92
     C                   ENDSR
     C*============================================================*
     C*   CONSULTAR ARCHIVO CLIENTES
     C*============================================================*
     C     CONSULTAR     BEGSR
     C     LLA001        CHAIN     ARC01                              01
     C                   ENDSR
     C*============================================================*
     C*   MOVER CAMPOS A PANTALLA SUBFILE POR CONSULTA
     C*============================================================*
     C     MOVCAM        BEGSR
     C                   MOVEL     *BLANKS       WNONCLI          40
     C                   Z-ADD     ARC1NID       WCNID
     C                   MOVEL     ARC1NOM       WNONCLI
     C                   CAT       ARC1APE:1     WNONCLI
     C                   MOVEL     WNONCLI       WCNOMAPE
     C                   ADD       1             NRR01
     C                   MOVEL     *BLANKS       WOPC
     C                   WRITE     CL1
     C                   ENDSR
     C*============================================================*
     C*   RUTINA PARA EVALUAR LAS DIFERENTES OPCION INGRESADAS
     C*============================================================*
     C     EVALOPCION    BEGSR
     C     NRR01         IFGT      0
     C                   MOVE      '0'           *IN09
     C     *IN09         DOWEQ     '0'
     C                   READC     CL1                                    09
     C     *IN09         IFEQ      '0'
     C                   SELECT
     C     WOPC          WHENEQ    '2'
     C* RUTINA PARA MODIFICAR EL REGISTRO
     C     WOPC          WHENEQ    '4'
     C* RUTINA PARA ELIMINAR EL REGISTRO
     C     WOPC          WHENEQ    '5'
     C                   Z-ADD     WCNID         ARC1NID
     C                   EXSR      CONSULTAR
     C                   EXSR      MOVCAM2
     C                   ENDSL
     C                   MOVE      *BLANKS       WOPC
     C                   UPDATE    CL1
     C                   ENDIF
     C                   ENDDO
     C                   ENDIF
     C                   ENDSR
     C*============================================================*
     C*   MOVER CAMPOS A PANTALLA SUBFILE POR OPCION 5
     C*============================================================*
     C     MOVCAM2       BEGSR
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
