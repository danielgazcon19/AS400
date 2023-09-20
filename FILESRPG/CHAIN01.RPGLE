     FARC01     UF A E           K DISK
     F*********************
     C     *ENTRY        PLIST
     C                   PARM                    WANID            21
     C     LLAVE1        KLIST
     C                   KFLD                    ARC1NID
     C**** LOGICA PRINCIPAL ****
     C                   MOVE      WANID         ARC1NID
     C     LLAVE1        CHAIN     ARC01                              01
     C     *IN01         IFEQ      '0'
     C                   Z-ADD     3107410312    ARC1TEL
     C                   UPDATE    ARC01R
     C                   CLEAR                   ARC01R
     C                   ELSE
     C                   MOVE      '1'           *INLR
     C                   ENDIF
     C                   MOVE      '1'           *INLR
     C
     C
     C
