CLASS lcl_user DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_id    TYPE int4
          iv_ad    TYPE char20
          iv_durum TYPE char20
          iv_type  TYPE char20,
      get_product
        IMPORTING
          iv_id             TYPE int4
        RETURNING
          VALUE(rv_product) TYPE zbk_urun,
      get_products_by_type
        IMPORTING
          iv_type            TYPE char20
        RETURNING
          VALUE(rv_products) TYPE zbk_urun.

  PRIVATE SECTION.

    DATA: mo_urun  TYPE REF TO lcl_urun,
          mv_id    TYPE int4,
          mv_ad    TYPE char20,
          mv_durum TYPE char20,
          mv_type  TYPE char20.

ENDCLASS.

CLASS lcl_user IMPLEMENTATION.
  METHOD constructor.
    CREATE OBJECT mo_urun
      EXPORTING
        iv_id    = p_id
        iv_ad    = p_ad
        iv_durum = p_durum
        iv_type  = p_type.
  ENDMETHOD.

  METHOD get_product.
    rv_product = mo_urun->urun_getir( iv_id = iv_id ).
  ENDMETHOD.

  METHOD get_products_by_type.
    rv_products = mo_urun->urun_tipi_getir( iv_type = iv_type ).
  ENDMETHOD.
ENDCLASS.



DATA: lo_user     TYPE REF TO lcl_user,
      cv_id       TYPE int4 VALUE 123,
      lv_type     TYPE char20 VALUE 'ExampleType',
      lv_product  TYPE zbk_urun,
      lt_products TYPE TABLE OF zbk_urun.

START-OF-SELECTION.

  CREATE OBJECT lo_user
    EXPORTING
      iv_id    = islem_id
      iv_ad    = p_ad
      iv_durum = p_durum
      iv_type  = p_type.


  IF p_rad1 EQ 'X'.
    PERFORM zbk_tablo.
  ELSEIF p_rad5 EQ 'X'.
    IF p_type <> ''.
      lo_user->get_products_by_type( iv_type = p_type ).
    ELSEIF p_id <> 0.
      lo_user->get_product( iv_id = p_id ).
    ENDIF.

  ENDIF.