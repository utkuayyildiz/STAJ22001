*&---------------------------------------------------------------------*
*& Include          ZBK_SBOOK_ALV
*&---------------------------------------------------------------------*


FORM display_sbook.

  SELECT * FROM zbk_sbook INTO CORRESPONDING FIELDS OF TABLE gt_sbook.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'BOOKID'.
  gs_fcat-scrtext_l = 'BOOKID'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'LUGGWEIGHT'.
  gs_fcat-scrtext_l = 'LUGGWEIGHT'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'FORCURAM'.
  gs_fcat-scrtext_l = 'FORCURAM'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'FORCURKEY'.
  gs_fcat-scrtext_l = 'FORCURKEY'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'LOCCURAM'.
  gs_fcat-scrtext_l = 'LOCCURAM'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'LOCCURKEY'.
  gs_fcat-scrtext_l = 'LOCCURKEY'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'PASSNAME'.
  gs_fcat-scrtext_l = 'PASSNAME'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_layout_sbook.
  gs_layout_sbook-cwidth_opt = abap_true.
  gs_layout_sbook-zebra = abap_true.
  gs_layout_sbook-no_toolbar = abap_true.

  CREATE OBJECT go_cont
    EXPORTING
      container_name = 'GO_CONT'.

create object go_cont2
  EXPORTING
    container_name              =      'CONTAINER2'.            " Name of the Screen CustCtrl Name to Link Container To

  .

  DATA: go_alv  TYPE REF TO cl_gui_alv_grid.

  CREATE OBJECT go_alv_sbook
    EXPORTING
      i_parent = go_cont2.



  CALL METHOD go_alv_sbook->set_table_for_first_display
    EXPORTING
      is_layout       = gs_layout_sbook
    CHANGING
      it_outtab       = gt_sbook
      it_fieldcatalog = gt_fcat.



ENDFORM.