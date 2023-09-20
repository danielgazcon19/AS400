     FARC01     IF   E           K DISK
     F* ARCHIVO DE CLIENTES
     FARC02     IF   E           K DISK
     F* ARCHIVO DE CLIENTES 2
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
     C                   MOVE      '0'           *IN02
     C     *IN02         DOWEQ     '0'
     C                   READ      ARC02                                  02
     C     *IN02         IFEQ      '0'
     C                   MOVE      ARC2NID       WNID             21
     C*QUITAR CEROS A LA IZQUIERDA CON TRIML
     C                   Eval      RESULT =%TrimL((WNID):'0')
     C     RESULT        DSPLY
     C                   ENDIF
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
     C                   MOVEL     *BLANKS       RESULT           50
     C* QUITAR ESPACIOS EN BLANCO
     C                   Eval      RESULT =%Trim(DESCRI(6))
     C     RESULT        DSPLY
     C* QUITAR CEROS Y ESPACIOS EN BLANCO
     C                   Eval      RESULT =%Trim(DESCRI(6):'0 ')
     C     RESULT        DSPLY
     C* QUITAR CEROS Y CARACTER *
     C                   Eval      RESULT =%Trim(DESCRI(6):'0 *')
     C     RESULT        DSPLY
     C* QUITAR CEROS, EASPACIOS, CARACTER * Y $
     C                   Eval      RESULT =%Trim(DESCRI(6):'0 *$')
     C     RESULT        DSPLY
     C************************************
     C* QUITAR  ESPACIOS A LA IZQUIERDA
     C*                  Eval      RESULT =%TrimL(DESCRI(1):' ')
     C                   Eval      RESULT =%Trim(DESCRI(1))
     C     RESULT        DSPLY
     C
     C
     C
     C
     C                   ENDIF
     C                   ENDDO
     C                   MOVE      '1'           *INLR
     C
     C
     C
