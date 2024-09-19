*&---------------------------------------------------------------------*
*& Report ZBK_DNM_OO6
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbk_dnm_oo6.

CLASS lcl_cat DEFINITION DEFERRED.

DATA: go_cat TYPE REF TO lcl_cat.


INTERFACE lcl_animal.
  METHODS:
    get_number_of_arms
      RETURNING VALUE(rv_arms) TYPE i,
    get_number_of_legs
      RETURNING VALUE(rv_legs) TYPE i.

  DATA: mv_arms TYPE i,
        mv_legs TYPE i.

ENDINTERFACE.


CLASS lcl_cat DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor.
    INTERFACES lcl_animal.


ENDCLASS.



CLASS lcl_cat IMPLEMENTATION.
  METHOD constructor.
    lcl_animal~mv_arms = 0.
    lcl_animal~mv_legs = 4.
  ENDMETHOD.

  METHOD lcl_animal~get_number_of_arms.

    rv_arms = lcl_animal~mv_arms.

  ENDMETHOD.


  METHOD lcl_animal~get_number_of_legs.

rv_legs = lcl_animal~mv_legs.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

create object: go_cat.


write: 'kedinin bacak sayýsý:   ', go_cat->lcl_animal~get_number_of_legs( ).