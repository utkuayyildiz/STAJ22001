*&---------------------------------------------------------------------*
*& Report ZBK_DNM_OO4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbk_dnm_oo4.

CLASS lcl_main DEFINITION DEFERRED.
DATA: go_main  TYPE REF TO lcl_main,
      go_main2 TYPE REF TO lcl_main,
      go_main3 TYPE REF TO lcl_main.

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.

    METHODS:
      constructor,
      do_process IMPORTING iv_pers_id  TYPE char10
                           iv_pers_ad  TYPE char20
                           iv_pers_age TYPE int4.


  class-METHODS: class_constructor.

    DATA: mv_pers_id  TYPE char10,
          mv_pers_ad  TYPE char20.


    class-data:  mv_pers_age TYPE int4.
ENDCLASS.

CLASS lcl_main IMPLEMENTATION.
  method constructor.

    ENDMETHOD.
  METHOD class_constructor.
    mv_pers_age = mv_pers_age + 1.
  ENDMETHOD.

  METHOD do_process.

    mv_pers_id             = iv_pers_id.
    mv_pers_ad             = iv_pers_ad.
    mv_pers_age    = iv_pers_age.


  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.


  CREATE OBJECT:go_main,
                go_main2,
                go_main3.


  go_main->do_process(
    EXPORTING
      iv_pers_id  =  '100001'
      iv_pers_ad  =   'UTKU'
      iv_pers_age =   '22'
  ).

  go_main2->do_process(
    EXPORTING
      iv_pers_id  =  '100002'
      iv_pers_ad  =   'SALİ'
      iv_pers_age =   '25'
  ).

  go_main3->do_process(
    EXPORTING
      iv_pers_id  =  '100003'
      iv_pers_ad  =   'POLAT'
      iv_pers_age =   '35'
  ).

  WRITE: go_main->mv_pers_id , go_main2->mv_pers_id , go_main3->mv_pers_id , go_main->mv_pers_ad , go_main2->mv_pers_ad , go_main3->mv_pers_ad , go_main->mv_pers_age ,go_main2->mv_pers_age,go_main3->mv_pers_age.