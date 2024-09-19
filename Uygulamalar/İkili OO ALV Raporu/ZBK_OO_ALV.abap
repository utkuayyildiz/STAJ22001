*&---------------------------------------------------------------------*
***& Report ZBK_OO_ALV
***&---------------------------------------------------------------------*
***&
*&---------------------------------------------------------------------*
REPORT zbk_oo_alv.



*CALL SCREEN 155.
INCLUDE zbk_oo_alv_top.
INCLUDE zbk_oo_alv_cls.
INCLUDE zbk_oo_alv_pbo.
INCLUDE zbk_oo_alv_pai.
INCLUDE zbk_oo_alv_form.

INITIALIZATION.

  gs_variant_tmp-report = sy-repid.

  CALL FUNCTION 'LVC_VARIANT_DEFAULT_GET'
    EXPORTING
      i_save        = 'A'
    CHANGING
      cs_variant    = gs_variant_tmp
    EXCEPTIONS
      wrong_input   = 1
      not_found     = 2
      program_error = 3
      OTHERS        = 4.

  IF sy-subrc EQ 0.
    p_vari = gs_variant_tmp-variant.
  ENDIF.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_vari.
  CALL FUNCTION 'LVC_VARIANT_F4'
    EXPORTING
      is_variant = gs_variant_tmp
*     IT_DEFAULT_FIELDCAT       =
*     I_SAVE     = ' '
    IMPORTING
*     E_EXIT     =
      es_variant = gs_variant_tmp
* EXCEPTIONS
*     NOT_FOUND  = 1
*     PROGRAM_ERROR             = 2
*     OTHERS     = 3
    .
  IF sy-subrc EQ 0.
    p_vari = gs_variant_tmp-variant.
  ENDIF.






START-OF-SELECTION.





  PERFORM  get_data.
  PERFORM set_fc.
  PERFORM set_layout.







  CALL SCREEN 001.