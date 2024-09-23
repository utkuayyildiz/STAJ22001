*----------------------------------------------------------------------*
***INCLUDE ZBK_URUN_OOP_ZBK_TABLOF01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form ZBK_TABLO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*report ZBK_URUN_OOP_ZBK_TABLOF01.

FORM zbk_tablo .
  TYPES: BEGIN OF gty_table,
           id      TYPE zbk_urun_id,
           type    TYPE zbk_urun_tip,
           durum   TYPE zbk_urun_durum,
           ad      TYPE zbk_urun_ad,
           o_tarih TYPE zbk_urun_eklenme_tarih,
           sat     TYPE char1,
           sure    TYPE int4,
         END OF gty_table.


  FIELD-SYMBOLS: <gfs_urun> TYPE lvc_s_fcat.

  CLEAR: gv_excluding.
  gv_excluding = cl_gui_alv_grid=>mc_fc_detail.
  gv_excluding = cl_gui_alv_grid=>mc_fc_sort_asc.
  APPEND gv_excluding TO gt_excluding.





  CLEAR: gs_sort.
  gs_sort-spos = 1.
  gs_sort-fieldname = 'ID'.
  gs_sort-up = abap_true.
  APPEND gs_sort TO gt_sort.

*  CLEAR: gs_filter.
*  gs_filter-tabname = 'GT_SFLIGHT'.
*  gs_filter-fieldname = 'CURRENCY'.
*  gs_filter-sign = 'I'.
*  gs_filter-option = 'EQ'.
*  gs_filter-low = 'USD'.
*  APPEND gs_filter TO gt_filter.


  DATA: go_alv       TYPE REF TO cl_gui_alv_grid,
        go_container TYPE REF TO cl_gui_custom_container.

  CREATE OBJECT go_container
    EXPORTING
      container_name = 'CC_ALV'.               " Custom Container'ýnýzýn ekran adý

  CREATE OBJECT go_alv
    EXPORTING
      i_parent = go_container.


  SELECT * FROM zbk_urun INTO CORRESPONDING FIELDS OF TABLE gt_table.


  CLEAR: gs_layout.
  gs_layout-zebra = abap_true.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'ID'.
  gs_fieldcatalog-scrtext_l = 'ID'.
  gs_fieldcatalog-key = abap_true.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'AD'.
  gs_fieldcatalog-scrtext_l = 'Ad'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'TYPE'.
  gs_fieldcatalog-scrtext_l = 'TYPE'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.
  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'DURUM'.
  gs_fieldcatalog-scrtext_l = 'DURUM'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'O_TARIH'.
  gs_fieldcatalog-scrtext_l = 'O_TARIH'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'SURE'.
  gs_fieldcatalog-scrtext_l = 'SURE'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'SAT'.
  gs_fieldcatalog-scrtext_l = 'SAT'.
  gs_fieldcatalog-checkbox = abap_true.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.


  LOOP AT gt_fieldcatalog ASSIGNING <gfs_urun>.
    IF <gfs_urun>-fieldname = 'SAT'.
      <gfs_urun>-hotspot = abap_true.

    ENDIF.

  ENDLOOP.


  CREATE OBJECT go_event_receiver.

  SET HANDLER go_event_receiver->handle_button_click FOR go_alv.
  SET HANDLER go_event_receiver->handle_toolbar FOR go_alv.
  SET HANDLER go_event_receiver->handle_user_command FOR go_alv.
  SET HANDLER go_event_receiver->hotspot_click FOR go_alv.


  CALL METHOD go_alv->set_table_for_first_display
    EXPORTING
      is_layout       = gs_layout
    CHANGING
      it_outtab       = gt_table              " Output Table
      it_fieldcatalog = gt_fieldcatalog             " Field Catalog
      it_sort         = gt_sort.              " Sort Criteria
  IF sy-subrc <> 0.
  ENDIF.

  CALL SCREEN 100.
ENDFORM.
FORM display_satilan.
  DATA: go_alv_satilan  TYPE REF TO cl_gui_alv_grid,
        go_cont_satilan TYPE REF TO cl_gui_custom_container.

  CREATE OBJECT go_alv_satilan
    EXPORTING
      i_parent = go_cont_satilan.


  CREATE OBJECT go_cont_satilan
    EXPORTING
      container_name = 'CUSTCONT'.
  IF sy-subrc <> 0.
*     MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*       WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  CALL METHOD go_alv_satilan->set_table_for_first_display
*  EXPORTING
*    ir_salv_adapter               =                  " Interface ALV Adapter
    CHANGING
      it_outtab       = gt_satilan                " Output Table
      it_fieldcatalog = gt_sat_fcat.
  IF sy-subrc <> 0.
* MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*   WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
ENDFORM.


FORM zbk_uye.

  DATA: go_alv_uye  TYPE REF TO cl_gui_alv_grid,
        go_uye_cont TYPE REF TO cl_gui_custom_container.



  DATA: gs_ufcat TYPE lvc_s_fcat.
  DATA: gt_ufcat TYPE lvc_t_fcat.




  DATA: gt_uye TYPE TABLE OF gty_uye.


  SELECT * FROM zbk_dnm_pers
  INTO CORRESPONDING FIELDS OF TABLE gt_uye.


  CLEAR: gs_ufcat.
  gs_ufcat-fieldname = 'PERS_NAME'.
  gs_ufcat-scrtext_l = 'PERS_NAME'.
  APPEND gs_ufcat TO gt_ufcat.
  CLEAR: gs_ufcat.
  gs_ufcat-fieldname = 'PERS_AGE'.
  gs_ufcat-scrtext_l = 'PERS_AGE'.
  APPEND gs_ufcat TO gt_ufcat.
  CLEAR: gs_ufcat.
  gs_ufcat-fieldname = 'PERS_DEP'.
  gs_ufcat-scrtext_l = 'PERS_DEP'.
  APPEND gs_ufcat TO gt_ufcat.
  CLEAR: gs_ufcat.
  gs_ufcat-fieldname = 'DURUM'.
  gs_ufcat-scrtext_l = 'DURUM'.
  APPEND gs_ufcat TO gt_ufcat.
  CLEAR: gs_ufcat.
  gs_ufcat-fieldname = 'UZAKLASTIR'.
  gs_ufcat-scrtext_l = 'UZAKLASTIR'.
  gs_ufcat-style = cl_gui_alv_grid=>mc_style_button.
  gs_ufcat-icon = '@11@'.
  APPEND gs_ufcat TO gt_ufcat.



  CREATE OBJECT go_uye_cont
    EXPORTING
      container_name = 'PERSCONT'.                " Name of the Screen CustCtrl Name to Link Container To

  CREATE OBJECT go_alv_uye
    EXPORTING
      i_parent = go_uye_cont.               " Parent Container


  CREATE OBJECT go_event_receiver.

  SET HANDLER go_event_receiver->handle_button_click FOR go_alv_uye.
  CALL METHOD go_alv_uye->set_table_for_first_display
*    EXPORTING
    CHANGING
      it_outtab       = gt_uye
      it_fieldcatalog = gt_ufcat.

ENDFORM.