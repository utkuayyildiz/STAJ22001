FORM get_data .

  SELECT * FROM sbook
    UP TO 50 ROWS
    INTO CORRESPONDING FIELDS OF TABLE gt_sbook.

  LOOP AT gt_sbook INTO gs_sbook.
    gs_sbook-durum = 'Aktif'.
  ENDLOOP.
  LOOP AT gt_sbook ASSIGNING <gfs_sbook>.
    <gfs_sbook>-durum = 'Aktif'.

  ENDLOOP.

  SELECT * FROM sflight
    UP TO 100 ROWS
    INTO CORRESPONDING FIELDS OF TABLE gt_sflight.
     LOOP AT gt_sflight INTO gs_sflight.
    gs_sflight-aktif = 'Aktif'.
  ENDLOOP.
  LOOP AT gt_sflight ASSIGNING <gfs_sflight>.
    <gfs_sflight>-aktif = 'Aktif'.

  ENDLOOP.
*    LOOP AT gt_sflight ASSIGNING <gfs_sflight>.
*    <gfs_sflight>-currency = 'USD'.
*
*
*  ENDLOOP.

  LOOP AT gt_sflight ASSIGNING <gfs_sflight>.
    <gfs_sflight>-delete = '@11@'.
  ENDLOOP.

  LOOP AT gt_sbook ASSIGNING <gfs_sbook>.
    <gfs_sbook>-delete2 = '@11@'.
  ENDLOOP.

  DELETE gt_sbook WHERE luggweight = 0.

  DELETE gt_sbook WHERE passname = ''.

  LOOP AT gt_fieldcatalog ASSIGNING <gfs_fcat>.
    IF <gfs_fcat>-fieldname EQ 'CARRID'.
      <gfs_fcat>-hotspot = abap_true.
    ENDIF.
  ENDLOOP.
  " Calculate average of LUGGWEIGHT
  DATA: lv_total_weight TYPE p DECIMALS 2 VALUE 0,
        lv_count        TYPE i VALUE 0,
        lv_avg_weight   TYPE p DECIMALS 2 VALUE 0.

  LOOP AT gt_sbook INTO DATA(ls_sbook).
    lv_total_weight = lv_total_weight + ls_sbook-luggweight.
    lv_count = lv_count + 1.
  ENDLOOP.

  IF lv_count > 0.
    lv_avg_weight = lv_total_weight / lv_count.
  ENDIF.

  LOOP AT gt_sbook ASSIGNING <gfs_sbook>.
    <gfs_sbook>-avg_luggweight = lv_avg_weight.
  ENDLOOP.

  " Update field catalog to include new column
  LOOP AT gt_fieldcatalog ASSIGNING <gfs_fcat>.
    IF <gfs_fcat>-fieldname = 'LUGGWEIGHT'.
      CLEAR: gs_fieldcatalog.
      gs_fieldcatalog-fieldname = 'AVG_LUGGWEIGHT'.
      gs_fieldcatalog-scrtext_l = 'Average Luggage Weight'.
      gs_fieldcatalog-col_pos = 1.
      APPEND gs_fieldcatalog TO gt_fieldcatalog.
      EXIT.
    ENDIF.

  ENDLOOP.

  LOOP AT gt_fieldcatalog ASSIGNING <gfs_fcat>.
    IF <gfs_fcat>-fieldname EQ 'BOOKID'.
      <gfs_fcat>-hotspot = abap_true.
    ENDIF.

  ENDLOOP.

  LOOP AT gt_sbook ASSIGNING <gfs_sbook>.

    <gfs_sbook>-kur_farki = <gfs_sbook>-forcuram - <gfs_sbook>-loccuram.

    IF <gfs_sbook>-kur_farki <= 0.
      <gfs_sbook>-kur_farki = 0.
    ELSE.
    ENDIF.

  ENDLOOP.
  FIELD-SYMBOLS : <gfs_sda> TYPE lvc_s_fcat.

  LOOP AT gt_fieldcatalog ASSIGNING <gfs_sda>.
    IF <gfs_sda>-fieldname = 'PASSNAME'.
      <gfs_sda>-edit = abap_true.
    ENDIF.

  ENDLOOP.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_layout .
  CLEAR: gs_layout.
  gs_layout-cwidth_opt = abap_true.
*gs_layout-edit = abap_true.
*gs_layout-no_toolbar = abap_true.
  gs_layout-zebra = abap_true.
  gs_layout-info_fname = 'LINE_COLOR'.
  gs_layout-ctab_fname = 'CELL_COLOR'.
ENDFORM.
FORM display_alv .


  CREATE OBJECT go_cont
    EXPORTING
      container_name = 'CONTAINER'.

  CREATE OBJECT go_splitter
    EXPORTING
      parent  = go_cont
      rows    = 2
      columns = 2.

  CALL METHOD go_splitter->get_container
    EXPORTING
      row       = 2
      column    = 1
    RECEIVING
      container = go_gui1.


  CREATE OBJECT go_alv
    EXPORTING
      i_parent = go_gui1.


  CALL METHOD go_splitter->get_container
    EXPORTING
      row       = 2
      column    = 2
    RECEIVING
      container = go_gui2.

  CALL METHOD go_splitter->get_container
    EXPORTING
      row       = 1              " Row
      column    = 1            " Column
    RECEIVING
      container = go_top.

  call method go_splitter->get_container
    EXPORTING
      row       =  1                " Row
      column    =   2               " Column
    RECEIVING
      container =  go_top2.                " Container
    .
  CALL METHOD go_splitter->set_row_height
    EXPORTING
      id                =  1                " Row ID
      height            =   15               " Height
*    IMPORTING
*      result            =                  " Result Code
*    EXCEPTIONS
*      cntl_error        = 1                " See CL_GUI_CONTROL
*      cntl_system_error = 2                " See CL_GUI_CONTROL
*      others            = 3
    .
  IF sy-subrc <> 0.
*   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*     WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  CREATE OBJECT go_alv2
    EXPORTING
      i_parent = go_gui2.
  .



  CREATE OBJECT go_event_receiver.

  SET HANDLER go_event_receiver->top_of_page FOR go_alv.
  SET HANDLER go_event_receiver->hotspot_click FOR go_alv.
  SET HANDLER go_event_receiver->data_changed FOR go_alv.
  SET HANDLER go_event_receiver->double_click FOR go_alv.
  SET HANDLER go_event_receiver->top_of_page FOR go_alv.
  CREATE OBJECT go_docu
    EXPORTING
      style = 'ALV_GRID'.
  .
  CALL METHOD go_alv->list_processing_events
    EXPORTING
      i_event_name = 'TOP_OF_PAGE'
      i_dyndoc_id  = go_docu.
  .

  .
 SET HANDLER go_event_receiver->top_of_page FOR go_alv.
  SET HANDLER go_event_receiver->handle_toolbar FOR go_alv.
  SET HANDLER go_event_receiver->handle_user_command FOR go_alv2.
  SET HANDLER go_event_receiver->handle_button_click FOR go_alv.

  CALL METHOD go_alv->set_table_for_first_display
    EXPORTING
      is_layout       = gs_layout
    CHANGING
      it_outtab       = gt_sbook
      it_fieldcatalog = gt_fieldcatalog.

  CALL METHOD go_alv->register_edit_event
    EXPORTING
      i_event_id = cl_gui_alv_grid=>mc_evt_modified.


  set handler go_event_receiver->top_of_page for go_alv2.
  CREATE OBJECT go_docu2
  EXPORTING
    style = 'ALV_GRID'.

  CALL METHOD go_alv2->list_processing_events
    EXPORTING
      i_event_name      =  'TOP_OF_PAGE'                " Event Name List Processing
      i_dyndoc_id       =    go_docu2.


  SET HANDLER go_event_receiver->handle_toolbar FOR go_alv2.
  SET HANDLER go_event_receiver->handle_user_command FOR go_alv2.

  set handler go_event_receiver->top_of_page for go_alv2.


  PERFORM set_excluding.
  PERFORM set_sort.
  PERFORM set_filter.

  gs_variant-report = sy-repid.
  gs_variant-variant = p_vari.

*  CALL METHOD go_alv2->set_table_for_first_display
*    EXPORTING
*      is_variant           = gs_variant
*      i_save               = 'A'  " Save Layout
*      i_default            = 'X'              " Default Display Variant
*      is_layout            = gs_layout
*      it_toolbar_excluding = gt_excluding
**     ir_salv_adapter      =                  " Interface ALV Adapter
*    CHANGING
*      it_outtab            = gt_sflight
*      it_fieldcatalog      = gt_fieldcatalog2
*      it_sort              = gt_sort.
*      it_filter            = gt_filter.
       CALL METHOD go_alv2->set_table_for_first_display
*         EXPORTING
*           i_buffer_active               =                  " Buffering Active
*           i_bypassing_buffer            =                  " Switch Off Buffer
*           i_consistency_check           =                  " Starting Consistency Check for Interface Error Recognition
*           i_structure_name              =                  " Internal Output Table Structure Name
*           is_variant                    =                  " Layout
*           i_save                        =                  " Save Layout
*           i_default                     = 'X'              " Default Display Variant
*           is_layout                     =                  " Layout
*           is_print                      =                  " Print Control
*           it_special_groups             =                  " Field Groups
*           it_toolbar_excluding          =                  " Excluded Toolbar Standard Functions
*           it_hyperlink                  =                  " Hyperlinks
*           it_alv_graphics               =                  " Table of Structure DTC_S_TC
*           it_except_qinfo               =                  " Table for Exception Quickinfo
*           ir_salv_adapter               =                  " Interface ALV Adapter
         CHANGING
           it_outtab                     =   gt_sflight       " Output Table
           it_fieldcatalog               =   gt_fieldcatalog2       " Field Catalog
           it_sort                       =   gt_sort      " Sort Criteria
           it_filter                     =   gt_filter.       " Filter Criteria
*         EXCEPTIONS
*           invalid_parameter_combination = 1                " Wrong Parameter
*           program_error                 = 2                " Program Errors
*           too_many_lines                = 3                " Too many Rows in Ready for Input Grid
*           others                        = 4
         .
       IF sy-subrc <> 0.
*        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
       ENDIF.



  SET HANDLER go_event_receiver->handle_onf4 FOR go_alv2.
  SET HANDLER go_event_receiver->handle_button_click FOR go_alv2.
ENDFORM.

FORM set_fc .

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'BOOKID'.
  gs_fieldcatalog-scrtext_l = 'Booking ID'.
  gs_fieldcatalog-col_pos = -1.
  gs_fieldcatalog-key = abap_true.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'PASSNAME'.
  gs_fieldcatalog-scrtext_l = 'Passenger Name'.
  gs_fieldcatalog-col_pos = 0.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.
    CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'DURUM'.
  gs_fieldcatalog-scrtext_l = 'DURUM'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

    CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'LUGGWEIGHT'.
  gs_fieldcatalog-scrtext_l = 'Bagaj Aðýrlýðý'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'FORCURAM'.
  gs_fieldcatalog-scrtext_s = 'FCUR'.
  gs_fieldcatalog-scrtext_m = 'Foreign Currency Amount'.
  gs_fieldcatalog-scrtext_l = 'Yabancý Para Birimi Deðeri'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'FORCURKEY'.
  gs_fieldcatalog-scrtext_s = 'FCURK'.
  gs_fieldcatalog-scrtext_m = 'Foreign Currency'.
  gs_fieldcatalog-scrtext_l = 'Yabancý Para Birimi Deðeri'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'LOCCURAM'.
  gs_fieldcatalog-scrtext_l = 'LOCCURAM'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'LOCCURKEY'.
  gs_fieldcatalog-scrtext_l = 'LOCCURKEY'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'KUR_FARKI'.
  gs_fieldcatalog-scrtext_s = 'Currency Difference'.
  gs_fieldcatalog-scrtext_l = 'Kur Farký'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

  CLEAR: gs_fieldcatalog2.
  gs_fieldcatalog2-fieldname = 'CARRID'.
  gs_fieldcatalog2-scrtext_l = 'CARRID'.
  gs_fieldcatalog2-col_pos = 0.
  APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.

  CLEAR: gs_fieldcatalog2.
  gs_fieldcatalog2-fieldname = 'CURRENCY'.
  gs_fieldcatalog2-scrtext_l = 'CURRENCY'.
  APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.
  CLEAR: gs_fieldcatalog2.
  gs_fieldcatalog2-fieldname = 'SEATSOCC'.
  gs_fieldcatalog2-scrtext_l = 'SEATSOCC'.
  APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.

  CLEAR: gs_fieldcatalog2.
  gs_fieldcatalog2-fieldname = 'FLDATE'.
  gs_fieldcatalog2-scrtext_l = 'FLDATE'.
  APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.

  CLEAR: gs_fieldcatalog2.
  gs_fieldcatalog2-fieldname = 'PRICE'.
  gs_fieldcatalog2-scrtext_l = 'PRICE'.

  CLEAR: gs_fieldcatalog2.
  gs_fieldcatalog2-fieldname = 'PLANETYPE'.
  gs_fieldcatalog2-scrtext_l = 'PLANETYPE'.
  APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.
  clear: gs_fieldcatalog2.
  gs_fieldcatalog2-fieldname = 'AKTIF'.
  gs_fieldcatalog2-scrtext_l = 'AKTIF'.
  APPEND gs_fieldcatalog2 to gt_fieldcatalog2.

  CLEAR: gs_fieldcatalog2.
  gs_fieldcatalog2-fieldname = 'DELETE'.
  gs_fieldcatalog2-scrtext_l = 'SÝL'.
  gs_fieldcatalog2-style = cl_gui_alv_grid=>mc_style_button.
  gs_fieldcatalog2-icon = abap_true.
  APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.

  CLEAR: gs_fieldcatalog.
  gs_fieldcatalog-fieldname = 'DELETE2'.
  gs_fieldcatalog-scrtext_l = 'SÝL'.
  gs_fieldcatalog-style = cl_gui_alv_grid=>mc_style_button.
  gs_fieldcatalog-icon = abap_true.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.


  IF sy-subrc EQ 0.

    LOOP AT gt_fieldcatalog2 ASSIGNING <gfs_fcat2>.
      IF <gfs_fcat2>-fieldname = 'CARRID'.
        <gfs_fcat2>-hotspot = abap_true.
      ENDIF.

    ENDLOOP.
  ENDIF.

ENDFORM.



*&---------------------------------------------------------------------*
*& Form REGISTER_F4
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM register_f4 .

  DATA: lt_f4 TYPE lvc_t_f4,
        ls_f4 TYPE lvc_s_f4.

  CLEAR: lt_f4.

  ls_f4-fieldname = 'CARRID'.
  ls_f4-register = abap_true.
  APPEND ls_f4 TO lt_f4.

*
*  CALL METHOD go_alv->register_f4_for_fields
*    EXPORTING
*      it_f4 = lt_f4.

  CALL METHOD go_alv2->register_f4_for_fields
    EXPORTING
      it_f4 = lt_f4.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_EXCLUDING
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_excluding .
  CLEAR: gv_excluding.
  gv_excluding = cl_gui_alv_grid=>mc_fc_detail.
  gv_excluding = cl_gui_alv_grid=>mc_fc_sort_asc.
  APPEND gv_excluding TO gt_excluding.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_SORT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_sort .
*  CLEAR: gs_sort.
*  gs_sort-spos = 1.
*  gs_sort-fieldname = 'CONNID'.
*  gs_sort-up = abap_true.
*  APPEND gs_sort TO gt_sort.
*
*  CLEAR: gs_sort.
*  gs_sort-spos = 1.
*  gs_sort-fieldname = 'PLANETYPE'.
*  gs_sort-up = abap_true.
*  APPEND gs_sort TO gt_sort.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_FILTER
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_filter .
  CLEAR: gs_filter.
  gs_filter-tabname = 'GT_SFLIGHT'.
  gs_filter-fieldname = 'CURRENCY'.
  gs_filter-sign = 'I'.
  gs_filter-option = 'EQ'.
  gs_filter-low = 'USD'.
  APPEND gs_filter TO gt_filter.
*
*  gs_filter-tabname = 'GT_SFLIGHT'.
*  gs_filter-fieldname = 'SEATSOCC'.
*  gs_filter-sign = 'I'.
*  gs_filter-option = 'NE'.
*  gs_filter-low = '0'.
*
*  APPEND gs_filter TO gt_filter.
ENDFORM.