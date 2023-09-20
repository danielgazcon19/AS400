     FARC01     IF   E           K DISK
     F* ARCHIVO DE CLIENTES
     FARC03     IF   E           K DISK
     F* ARCHIVO DE CIUDADES
     FARC04     IF   E           K DISK
     F* ARCHIVO DE PRODUCTOS
     F*********************
     D*
     D                 DS
     D  ARC1NID                1     21  0
     D  ARC1TIP               22     23  0
     D  ARC1NOM               24     53
     D  ARC1APE               54     83
     D  ARC1EDA               84     85  0
     D  ARC1SEX               86     86
     D  ARC1TEL               87     96  0
     D  ARC1IND               97     99
     D  ARC1DIR              100    139
     D  ARC1CIU              140    179
     D  WRC01R                 1    179
     D*
     D*** vectores ***
     D CODCIU          S              5S 0 dim(100)
     D NOMCIU          S             50    dim(100)
     D CODPRO          S              5S 0 dim(999)
     D DESPRO          S             50    dim(999)
     D
     D                 DS
     D  ARC4DE1                1     50
     D  ARC4DE2               51    100
     D  ARC4DE3              101    150
     D  ARC4DE4              151    200
     D  ARC4DE5              201    250
     D  ARC4DE6              251    300
     D  DESCRI                 1    300
     D                                     DIM(6)
     D                 DS
     D  ARC4VA1                1      3  0
     D  ARC4VA2                4      6  0
     D  ARC4VA3                7      9  0
     D  ARC4VA4               10     12  0
     D  ARC4VA5               13     15  0
     D  ARC4VA6               16     18  0
     D  VALCRI                 1     18  0
     D                                     DIM(6)
     D*
     D CLIENTES        DS                  OCCURS(50)
     D  WRC1NID                1     21  0
     D  WRC1TIP               22     23  0
     D  WRC1NOM               24     53
     D  WRC1APE               54     83
     D  WRC1EDA               84     85  0
     D  WRC1SEX               86     86
     D  WRC1TEL               87     96  0
     D  WRC1IND               97     99
     D  WRC1DIR              100    139
     D  WRC1CIU              140    179
     D  QRC01R                 1    179
     D
     C*
     C     *ENTRY        PLIST
     C                   PARM                    WANID            21
     C     LLAVE1        KLIST
     C                   KFLD                    ARC1NID
     C     LLAVE2        KLIST
     C                   KFLD                    ARC3CIU
     C     LLAVE3        KLIST
     C                   KFLD                    ARC4PRO
     C**** LOGICA PRINCIPAL ****
     C*=============================================================*
     C* DECLARACION  DE UNA LECTURA CON READ
     C*=============================================================*
     C                   MOVE      '0'           *IN01
     C                   READ      ARC01                                  01
     C     *IN01         IFEQ      '0'
     C
     C                   ENDIF
     C
     C
     C*=============================================================*
     C* LECTURA ARCHIVO CIUDAD - CARGA VECTORES
     C*=============================================================*
     C                   MOVE      '0'           *IN01
     C                   Z-ADD     0             INC               3 0
     C                   Z-ADD     0             ARC3CIU
     C     LLAVE2        SETLL     ARC03
     C     *IN01         DOWEQ     '0'
     C                   READ      ARC03                                  01
     C     *IN01         IFEQ      '0'
     C                   ADD       1             INC
     C                   Z-ADD     ARC3CIU       CODCIU(INC)
     C                   MOVEL     ARC3NOC       NOMCIU(INC)
     C                   ENDIF
     C                   ENDDO
     C                   DO        INC           XT                3 0
     C                   Z-ADD     CODCIU(XT)    CODCIUDAD         5 0
     C                   MOVE      NOMCIU(XT)    NOMCIUDAD        50
     C                   ENDDO
     C*=============================================================*
     C* LECTURA ARCHIVO PRODUCTOS - CARGA VECTORES Y ESTRUCTURAS
     C*=============================================================*
     C                   MOVE      '0'           *IN01
     C                   Z-ADD     0             ARC4PRO
     C     LLAVE3        SETLL     ARC04
     C     *IN01         DOWEQ     '0'
     C                   READ      ARC04                                  01
     C     *IN01         IFEQ      '0'
     C                   Z-ADD     ARC4PRO       CPRO              5 0
     C                   Z-ADD     ARC4PRO       CODPRO(CPRO)
     C                   MOVEL     ARC4DES       DESPRO(CPRO)
     C                   ENDIF
     C                   ENDDO
     C*=============================================================*
     C* LECTURA ARCHIVO CLIENTES - CARGA OCCURS
     C*=============================================================*
     C                   MOVE      '0'           *IN01
     C                   Z-ADD     0             INC
     C                   Z-ADD     0             ARC1NID
     C     LLAVE1        SETLL     ARC01
     C     *IN01         DOWEQ     '0'
     C                   READ      ARC01                                  01
     C     *IN01         IFEQ      '0'
     C                   ADD       1             INC
     C     INC           OCCUR     CLIENTES
     C                   MOVE      WRC01R        QRC01R
     C
     C
     C                   ENDIF
     C                   ENDDO
     C                   MOVE      '1'           *INLR
     C
     C
     C
