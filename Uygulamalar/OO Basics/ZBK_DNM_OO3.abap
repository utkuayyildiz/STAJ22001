*&---------------------------------------------------------------------*
*& Report ZBK_DNM_OO3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbk_dnm_oo3.
CLASS lcl_main DEFINITION DEFERRED.


PARAMETERS: pa1 TYPE int4,
            pa2 TYPE int4.

DATA: go_main TYPE REF TO lcl_main.

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
      IMPORTING
        iv_num1 type int4
        iv_num2 type int4,
      sum_numbers.




    DATA: mv_num1 TYPE int4,
          mv_num2 TYPE int4,
          mv_sum  TYPE int4.
ENDCLASS.

CLASS lcl_main IMPLEMENTATION.

  METHOD constructor.
    mv_num1 = iv_num1.
    mv_num2 = iv_num2.
  ENDMETHOD.
  METHOD sum_numbers.
    mv_sum = mv_num1 + mv_num2.

  ENDMETHOD.



ENDCLASS.

START-OF-SELECTION.


  CREATE OBJECT go_main
    EXPORTING
      iv_num1 = pa1
      iv_num2 = pa2
    .



  go_main->sum_numbers( ).

  WRITE:'Toplam:  ', go_main->mv_sum.