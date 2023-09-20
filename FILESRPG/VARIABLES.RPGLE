     D**VARIABLES ***
     DALFA             S             50A
     DNUMERO           S              8S 2
     DENTERO           S             10I 0
     DFLOAT            S              8F
     DPAQUET           S              9P 2
     D**
     D** FECHA **
     DFECHA            S               D   DATFMT(*ISO)
     DHORA             S               T
     DTIMESTAMP        S               Z
     D
     D**** ESTRUCTURAS ****
     DESTRUCTURA       DS
     DID                             15S 0
     DCODE                            5A
     DNUM                             3S 0
     D
     D****ESTRUCTURA CON LLAVE ****
     DLLAVE            DS
     DID                       1     15S 0
     DCODE                    16     20A
     DNUM                     21     23S 0
     DKEY                      1     23A
     D
     D*** CONSTANTES ****
     DCONSTANTE1       C                   CONST('ABCDF')
     DCONSTANTE2       C                   'ABCDF'
     D
     D*** VECTORES ****
     DVECTOR           S              3    DIM(10)
     DVECTORN          S              3S 0 DIM(10)
     D
     D** ESTRUCTURA DIM ****
     DDSDIM            DS
     DDESCRIPCION1             1     30A
     DDESCRIPCION2            31     60A
     DDESCRIPCION3            61     90A
     DDESP                     1     90A
     D                                     DIM(3)
     D
     D** ESTRUCTURA OCCURS **
     DDSDIM            DS                  OCCURS(30)
     DDESCRIPCION1             1     30A
     DDESCRIPCION2            31     60S 0
     DDESCRIPCION3            61     90A
     D
     D
     D
     D
     D
     D
     D
     D
     D
     D
     D
     D
     D
     D
     D
     D
     D
     D
