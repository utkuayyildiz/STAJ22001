*&---------------------------------------------------------------------*
*& Report ZBK_DNM_OO5
**&---------------------------------------------------------------------*
**&
*&---------------------------------------------------------------------*
REPORT zbk_dnm_oo5.
CLASS lcl_cat DEFINITION DEFERRED.
CLASS lcl_animal DEFINITION DEFERRED.
CLASS lcl_bird DEFINITION DEFERRED.

DATA: go_cat    TYPE REF TO lcl_cat,
      go_animal TYPE REF TO lcl_animal,
      go_bird   TYPE REF TO lcl_bird.
CLASS lcl_animal DEFINITION.
  PUBLIC SECTION.
    METHODS:
      get_number_of_legs RETURNING VALUE(rv_legs) TYPE i,
      get_number_of_arms RETURNING VALUE(rv_arms) TYPE i.
    DATA: mv_legs TYPE i.


    DATA: mv_arms TYPE i.



ENDCLASS.

CLASS lcl_animal IMPLEMENTATION.

  METHOD get_number_of_legs.

    rv_legs = mv_legs.

  ENDMETHOD.

  METHOD get_number_of_arms.
    rv_arms = mv_arms.


  ENDMETHOD.

ENDCLASS.


CLASS lcl_cat DEFINITION INHERITING FROM lcl_animal.
  PUBLIC SECTION.
    METHODS:
      constructor.



ENDCLASS.



CLASS lcl_cat IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).

    mv_legs = 4.
    mv_arms = 0.
  ENDMETHOD.


ENDCLASS.


CLASS lcl_bird DEFINITION INHERITING FROM lcl_animal.

  PUBLIC SECTION.
    METHODS:
      constructor.


ENDCLASS.

CLASS lcl_bird IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).

    mv_legs = 2.
    mv_arms = 2.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  CREATE OBJECT go_animal.
  CREATE OBJECT go_cat.
  CREATE OBJECT go_bird.



  WRITE: 'Kedinin ayaðý : ' ,go_cat->get_number_of_legs( ), 'Kedinin kolu:   ', go_cat->get_number_of_arms( ).
  WRITE: 'Kuþun ayaðý : ' ,go_bird->get_number_of_legs( ), 'Kuþun kolu:   ', go_bird->get_number_of_arms( ).




  DATA(lo_bird) = NEW lcl_bird( ).
  WRITE: 'Kuþun ayaðý : ' ,lo_bird->get_number_of_legs( ), 'Kuþun kolu:   ', lo_bird->get_number_of_arms( ).



  WRITE: go_animal->get_number_of_arms( ).
  WRITE: go_animal->mv_arms.
  WRITE: go_animal->get_number_of_legs( ).
  WRITE: go_animal->mv_legs.

  WRITE: go_cat->get_number_of_arms( ).
  WRITE: go_cat->mv_arms.
  WRITE: go_cat->get_number_of_legs( ).
  WRITE: go_cat->mv_legs.