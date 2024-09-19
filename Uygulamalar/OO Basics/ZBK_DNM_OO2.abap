*&---------------------------------------------------------------------*
*& Report ZBK_DNM_OO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbk_dnm_oo2.


PARAMETERS: pa1 TYPE int4,
            pa2 TYPE int4.


DATA: gv_sum      TYPE int4,
      gv_changing TYPE int4.


CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    METHODS:
      sum_numbers,
      sum_numbers_2
        IMPORTING
          iv_num1 TYPE int4
          iv_num2 TYPE int4
        EXPORTING
          ev_sum1 TYPE int4,
      sub_numbers_2
        IMPORTING
          iv_num1 TYPE int4
        CHANGING
          cv_num1 TYPE int4,
      sum_numbers_3
        IMPORTING
                  iv_num1       TYPE int4
                  iv_num2       TYPE int4
        RETURNING VALUE(rv_sum) TYPE int4.
    DATA: mv_sum TYPE int4.
ENDCLASS.

CLASS lcl_main IMPLEMENTATION.

  METHOD sum_numbers.
    mv_sum = pa1 + pa2.
    DATA: mv_sum TYPE int4.
  ENDMETHOD.


  METHOD sum_numbers_2.
    ev_sum1 = iv_num1 + iv_num2.

  ENDMETHOD.

  METHOD sub_numbers_2.
    cv_num1 = iv_num1 - cv_num1 .

  ENDMETHOD.


  METHOD sum_numbers_3.
    rv_sum = iv_num1 + iv_num2.
  ENDMETHOD.

ENDCLASS.


DATA: go_main TYPE REF TO lcl_main.

START-OF-SELECTION.
*
*class lcl_main DEFINITION DEFERRED.
  CREATE OBJECT go_main.

  go_main->sum_numbers( ).

  WRITE: 'toplam: ',go_main->mv_sum.


  gv_changing = pa2.
  go_main->sum_numbers_2(
    EXPORTING
      iv_num1 = pa1
      iv_num2 = pa2
    IMPORTING
      ev_sum1 = gv_sum
  ).



  WRITE: 'Toplam:   ' , gv_sum.



  go_main->sub_numbers_2(
    EXPORTING
      iv_num1 = pa1
    CHANGING
      cv_num1 = gv_changing
  ).


  WRITE: 'fark : ' ,   gv_changing.


  go_main->sum_numbers_3(
    EXPORTING
      iv_num1 = pa1
      iv_num2 = pa2
    RECEIVING
      rv_sum  = gv_sum
  ).




  WRITE: 'Toplam 3 :    ' ,gv_sum.


  gv_sum = go_main->sum_numbers_3(
             iv_num1 = pa1
             iv_num2 = pa2
           ).



  WRITE: 'Toplam 3 :    ' ,gv_sum.