     FARC01     UF A E           K DISK
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
     C*
     C     *ENTRY        PLIST
     C                   PARM                    WANID            21
     C     LLAVE1        KLIST
     C                   KFLD                    ARC1NID
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
     C* DECLARACION  DE UNA LECTURA CON READ
     C*=============================================================*
     C                   MOVE      '0'           *IN01
     C                   MOVE      WANID         ARC1NID
     C     LLAVE1        SETLL     ARC01
     C                   READ      ARC01                                  01
     C     *IN01         IFEQ      '0'
     C
     C                   ENDIF
     C
     C
     C*=============================================================*
     C* DECLARACION  DE UNA LECTURA CON READ DENTRO DE CICLO PRIMER REGISTRO
     C*=============================================================*
     C                   MOVE      '0'           *IN01
     C                   Z-ADD     0             ARC1NID
     C     LLAVE1        SETLL     ARC01
     C     *IN01         DOWEQ     '0'
     C                   READ      ARC01                                  01
     C     *IN01         IFEQ      '0'
     C
     C                   ENDIF
     C                   ENDDO
     C
     C
     C*=============================================================*
     C* DECLARACION  DE UNA LECTURA CON READP DENTRO DE CICLO ULTIMO REGISTRO
     C*=============================================================*
     C                   MOVE      '0'           *IN01
     C                   Z-ADD     *ALL'9'       ARC1NID
     C     LLAVE1        SETGT     ARC01
     C     *IN01         DOWEQ     '0'
     C                   READP     ARC01                                  01
     C     *IN01         IFEQ      '0'
     C
     C                   ENDIF
     C                   ENDDO
     C                   MOVE      '1'           *INLR
     C
     C
     C
