*&---------------------------------------------------------------------*
*& Report ZBK_DNM_OO8
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbk_dnm_oo8.
CLASS lcl_dog DEFINITION DEFERRED.
CLASS lcl_cat DEFINITION DEFERRED.
CLASS lcl_main DEFINITION DEFERRED.

DATA: go_dog  TYPE REF TO lcl_dog,
      go_cat  TYPE REF TO lcl_cat,
      go_main TYPE REF TO lcl_main.

CLASS lcl_animal DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS:
      get_type ABSTRACT,
      speak ABSTRACT.

ENDCLASS.

CLASS lcl_dog DEFINITION INHERITING FROM lcl_animal.
  PUBLIC SECTION.
    METHODS:
      get_type REDEFINITION,
      speak REDEFINITION.



ENDCLASS.

CLASS lcl_dog IMPLEMENTATION.

  METHOD get_type.
    WRITE: 'dog'.

  ENDMETHOD.


  METHOD speak.

    WRITE: 'bark'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_cat DEFINITION INHERITING FROM lcl_animal.
  PUBLIC SECTION.
    METHODS:
      get_type REDEFINITION,
      speak REDEFINITION.


ENDCLASS.


CLASS lcl_cat IMPLEMENTATION.

  METHOD get_type.

    WRITE: 'cat'.

  ENDMETHOD.

  METHOD speak.


    WRITE: 'meow'.

  ENDMETHOD.


ENDCLASS.

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    METHODS:
      play IMPORTING lo_animal TYPE REF TO lcl_animal.




ENDCLASS.



CLASS lcl_main IMPLEMENTATION.

  METHOD play.
    WRITE: 'the'.
    lo_animal->get_type( ).
    WRITE: 'says'.
    lo_animal->speak( ).

  ENDMETHOD.


ENDCLASS.


START-OF-SELECTION.

  CREATE OBJECT: go_dog     ,
                 go_cat     ,
                 go_main    .


  go_main->play( lo_animal = go_dog ).
  go_main->play( lo_animal = go_cat ).