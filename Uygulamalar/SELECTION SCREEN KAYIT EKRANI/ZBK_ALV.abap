FORM layout.
  CLEAR: gs_layout.

*  gs_layout-cwidth_opt = abap_true.
  gs_layout-zebra = abap_true.
  gs_layout-info_fname = 'LINE_COLOR'.
  gs_layout-ctab_fname = 'CELL_COLOR'.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
FORM display_alv.
  DATA: lo_container TYPE REF TO cl_gui_custom_container,
        lo_alv       TYPE REF TO cl_gui_alv_grid,
        lt_fieldcat  TYPE lvc_t_fcat,
        ls_fieldcat  TYPE lvc_s_fcat,
        lt_sort      TYPE lvc_t_sort,
        lt_filter    TYPE lvc_t_filt.





  DATA: gs_fcot TYPE lvc_s_fcat,
        gt_fcot TYPE lvc_t_fcat.



  DATA: lt_table     TYPE TABLE OF gty_table,
        ls_table     TYPE gty_table,
        lv_row_index TYPE sy-tabix.

*
*  DATA: gt_tablo TYPE TABLE OF gty_table.
*
**
*  FIELD-SYMBOLS: <gfs_table> TYPE lvc_s_fcat.
*
*  LOOP AT gt_fcot ASSIGNING <gfs_table>.
*    <gfs_table>-fieldname = 'AD'.
*    <gfs_table>-edit = abap_true.
*  ENDLOOP.


  FIELD-SYMBOLS : <gfs_stable> TYPE gty_table.

  SELECT * FROM zbk_calisan INTO CORRESPONDING FIELDS OF TABLE lt_table.

  LOOP AT lt_table ASSIGNING <gfs_stable>.
    CASE <gfs_stable>-cinsiyet.
      WHEN 'Kadýn'.
        <gfs_stable>-line_color = 'C600'.
      WHEN 'KADIN'.
        <gfs_stable>-line_color = 'C600'.
      WHEN 'Erkek'.
        <gfs_stable>-line_color = 'C111'.
      WHEN 'ERKEK'.
        <gfs_stable>-line_color = 'C111'.
    ENDCASE.
  ENDLOOP.

  LOOP AT lt_table ASSIGNING <gfs_stable>.
    CASE <gfs_stable>-soyad.
      WHEN 'RAHN'.
        <gfs_stable>-line_color = 'C411'.
    ENDCASE.
  ENDLOOP.





  LOOP AT lt_table ASSIGNING <gfs_stable>.

    CASE <gfs_stable>-ad.
      WHEN 'UTKU'.
        CLEAR: gs_cell_color.
        gs_cell_color-color-col = '3'.
        gs_cell_color-color-int = '1'.
        gs_cell_color-color-inv = '0'.
        APPEND gs_cell_color TO <gfs_stable>-cell_color.
    ENDCASE.
  ENDLOOP.


  CLEAR: ls_fieldcat.
  ls_fieldcat-fieldname = 'ad'.
  ls_fieldcat-scrtext_l = 'Ad'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR: ls_fieldcat.
  ls_fieldcat-fieldname = 'soyad'.
  ls_fieldcat-scrtext_l = 'Soyad'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR: ls_fieldcat.
  ls_fieldcat-fieldname = 'd_tarih'.
  ls_fieldcat-scrtext_l = 'Tarih'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR: ls_fieldcat.
  ls_fieldcat-fieldname = 'departman'.
  ls_fieldcat-scrtext_l = 'Departman'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR: ls_fieldcat.
  ls_fieldcat-fieldname = 'yas'.
  ls_fieldcat-scrtext_l = 'Yaþ'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR: ls_fieldcat.
  ls_fieldcat-fieldname = 'cinsiyet'.
  ls_fieldcat-scrtext_l = 'Cinsiyet'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR: ls_fieldcat.
  ls_fieldcat-fieldname = 'IZIN'.
  ls_fieldcat-scrtext_l = 'IZIN'.
  APPEND ls_fieldcat TO lt_fieldcat.



    PERFORM layout.


*   CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
*      EXPORTING
*        i_structure_name = 'ZBK_CALISAN'
*      CHANGING
*        ct_fieldcat      = gt_fcot.
*
    CREATE OBJECT lo_container
      EXPORTING
        container_name = 'CONTAINER'. " 'CONTAINER' subscreen'deki custom container'in adýdýr.

    CREATE OBJECT lo_alv
      EXPORTING
        i_parent = lo_container.





    DATA: go_event_receiver TYPE REF TO cl_event_receiver.

    CREATE OBJECT go_event_receiver.
    SET HANDLER go_event_receiver->data_changed FOR lo_alv.



    CALL METHOD lo_alv->set_table_for_first_display
      EXPORTING
        is_layout       = gs_layout
      CHANGING
        it_outtab       = lt_table
        it_fieldcatalog = lt_fieldcat.


*
*    CALL METHOD lo_alv->register_edit_event
*      EXPORTING
*        i_event_id = cl_gui_alv_grid=>mc_evt_modified.
*    " Event ID
**    EXCEPTIONS
**      error      = 1                " Errors
**      others     = 2
*    .





    CLEAR: gs_fcot.
    gs_fcot-fieldname = 'AD'.
    gs_fcot-scrtext_l = 'AD'.
    gs_fcot-edit = abap_true.
    APPEND gs_fcot TO gt_fcot.



    PERFORM layout.







ENDFORM.