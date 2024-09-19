*&---------------------------------------------------------------------*
*& Report ZBK_DNM_OO7
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbk_dnm_oo7.


CLASS lcl_cat DEFINITION DEFERRED.

DATA: go_cat TYPE REF TO lcl_cat.

CLASS lcl_animal DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS:
      get_number_of_arms
        ABSTRACT RETURNING VALUE(rv_arms) TYPE i,
      get_number_of_legs
        RETURNING VALUE(rv_legs) TYPE i.

    DATA: mv_arms TYPE i,
          mv_legs TYPE i.
ENDCLASS.

CLASS lcl_animal IMPLEMENTATION.

  METHOD get_number_of_legs.

    rv_legs = mv_legs.

  ENDMETHOD.


ENDCLASS.


CLASS lcl_cat DEFINITION INHERITING FROM lcl_animal.
  PUBLIC SECTION.
    METHODS:
      constructor,
      get_number_of_arms REDEFINITION.

ENDCLASS.



CLASS lcl_cat IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    mv_arms = 4.
    mv_legs = 5.
  ENDMETHOD.

  METHOD get_number_of_arms.

    rv_arms = mv_arms.
  ENDMETHOD.


ENDCLASS.

START-OF-SELECTION.

  CREATE OBJECT go_cat.



  WRITE: 'kedinin kolu',go_cat->get_number_of_arms( ),'tane'.