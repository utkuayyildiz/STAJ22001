*&---------------------------------------------------------------------*
*& Include          ZBK_GETDATA
*&---------------------------------------------------------------------*

TABLES: zbk_db.

DATA: gt_tablo TYPE TABLE OF zbk_db,
      gs_tablo TYPE zbk_db.



PARAMETERS: gv_num TYPE int4.



SELECTION-SCREEN BEGIN OF BLOCK blk1 WITH FRAME TITLE TEXT-101. "selection screen block
PARAMETERS:p_rad1 RADIOBUTTON GROUP rg1 USER-COMMAND flag DEFAULT 'X',
           p_rad2 RADIOBUTTON GROUP rg1,
           p_rad3 RADIOBUTTON GROUP rg1,
           p_rad4 RADIOBUTTON GROUP rg1.
SELECTION-SCREEN END OF BLOCK blk1.



PARAMETERS: gv_isim  TYPE char20 MODIF ID pa1,
            gv_soy   TYPE char20  MODIF ID pa2,
            gv_sehir TYPE char20    MODIF ID pa3,
            gv_numa type int4 MODIF ID pa4,
            gv_pozi type char10 MODIF ID pa5,
            gv_araba type xfeld modif id pa6.