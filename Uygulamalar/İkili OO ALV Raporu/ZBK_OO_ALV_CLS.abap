*&---------------------------------------------------------------------*
*& Include          ZBK_OO_ALV_CLS
*&---------------------------------------------------------------------*

CLASS cl_event_receiver DEFINITION.
  PUBLIC SECTION.


    METHODS top_of_page
        FOR EVENT top_of_page OF cl_gui_alv_grid
      IMPORTING
        e_dyndoc_id
        table_index.

    METHODS hotspot_click
        FOR EVENT hotspot_click OF cl_gui_alv_grid
      IMPORTING
        e_row_id
        e_column_id.

    METHODS double_click
        FOR EVENT double_click OF cl_gui_alv_grid
      IMPORTING
        e_row
        e_column
        es_row_no.

    METHODS data_changed
        FOR EVENT data_changed OF cl_gui_alv_grid
      IMPORTING
        er_data_changed
        e_onf4
        e_onf4_before
        e_onf4_after
        e_ucomm.

    METHODS handle_button_click
        FOR EVENT button_click OF cl_gui_alv_grid
      IMPORTING
        es_col_id
        es_row_no.

    METHODS handle_toolbar
        FOR EVENT toolbar OF cl_gui_alv_grid
      IMPORTING
        e_object
        e_interactive.

    METHODS handle_user_command
        FOR EVENT user_command OF cl_gui_alv_grid
      IMPORTING
        e_ucomm.

    METHODS handle_onf4
        FOR EVENT onf4 OF cl_gui_alv_grid
      IMPORTING
        e_fieldname
        e_fieldvalue
        es_row_no
        er_event_data
        et_bad_cells
        e_display.

ENDCLASS.



CLASS cl_event_receiver IMPLEMENTATION.

  METHOD top_of_page.
    DATA: lv_text TYPE sdydo_text_element.
    DATA: lv_total_weight TYPE p DECIMALS 2,
          lv_count        TYPE int4,
          lv_avg_weight   TYPE num2.
    lv_text = 'BÝLET TABLOSU'.
    lv_total_weight = 0.
    lv_count = 0.
    LOOP AT gt_sbook INTO DATA(ls_sbook).
      lv_total_weight = lv_total_weight + ls_sbook-luggweight.
      lv_count = lv_count + 1.
    ENDLOOP.
    CREATE OBJECT go_docu
      EXPORTING
        style = 'ALV_GRID'.
    .

    IF lv_count > 0.
      lv_avg_weight = lv_total_weight / lv_count.
    ENDIF.
    CALL METHOD go_docu->add_text
      EXPORTING
        text      = lv_text                " If 'X': TEXT_TABLE Display in Lines, Otherwise Continuous
        sap_style = cl_dd_document=>heading.

    CALL METHOD go_docu->new_line.
    CLEAR: lv_text.
    CONCATENATE 'Hoþgeldiniz : ' sy-uname INTO lv_text SEPARATED BY space.
    CALL METHOD go_docu->add_text
      EXPORTING
        text         = lv_text
        sap_style    = cl_dd_document=>list_positive
        sap_fontsize = cl_dd_document=>medium.
    .
    DATA: lv_sayi TYPE char10.
    DATA: lv_sayi2 TYPE char10.
    lv_sayi = 38.
    lv_sayi2 = 12.
    CALL METHOD go_docu->new_line.
    CONCATENATE 'Aktif yolcu sayýsý : ' lv_sayi INTO lv_text SEPARATED BY space.
    CALL METHOD go_docu->add_text
      EXPORTING
        text         = lv_text
        sap_style    = cl_dd_document=>list_positive
        sap_fontsize = cl_dd_document=>medium.

    CALL METHOD go_docu->new_line.
    CLEAR: lv_text.
    CONCATENATE 'Ortalama valiz aðýrlýðý: ' lv_avg_weight 'kg' INTO lv_text SEPARATED BY space.
    CALL METHOD go_docu->add_text
      EXPORTING
        text      = lv_text               " Si in Lines, Otherwise Continuous
        sap_style = cl_dd_document=>list_positive.
    CALL METHOD go_docu->display_document
      EXPORTING
*       reuse_control      =                  " HTML Control Reused
*       reuse_registration =                  " Event Registration Reused
*       container          =                  " Name of Container (New Container Object Generated)
        parent = go_top               " Contain Object Already Exists
*      EXCEPTIONS
*       html_display_error = 1                " Error Displaying the Document in the HTML Control
*       others = 2
      .
    IF sy-subrc <> 0.
*     MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*       WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.



    DATA: lv_text2 TYPE sdydo_text_element.

    lv_text2 = 'UÇUÞ TABLOSU'.
    CREATE OBJECT go_docu2
      EXPORTING
        style = 'ALV_GRID'               " Adjusting to the Style of a Particular GUI Environment
*       background_color =                  " Color ID
*       bds_stylesheet   =                  " Use BDS Style Sheet
*       no_margins       =                  " 'X': Document Created Without Free Margins
      .
    CALL METHOD go_docu2->add_text
      EXPORTING
        text      = lv_text2                " If 'X': TEXT_TABLE Display in Lines, Otherwise Continuous
        sap_style = cl_dd_document=>heading.

    CALL METHOD go_docu2->new_line.
    CLEAR: lv_text2.
    CONCATENATE 'Hoþgeldiniz : ' sy-uname INTO lv_text2 SEPARATED BY space.
    CALL METHOD go_docu2->add_text
      EXPORTING
        text         = lv_text2
        sap_style    = cl_dd_document=>list_positive
        sap_fontsize = cl_dd_document=>medium.
    .
    DATA: lv_sayi3 TYPE char10.
    lv_sayi3 = 41.
    CALL METHOD go_docu2->new_line.
    CLEAR: lv_text2.
    CONCATENATE 'Aktif yolcu sayýsý : ' lv_sayi3 INTO lv_text2 SEPARATED BY space.
    CALL METHOD go_docu2->add_text
      EXPORTING
        text         = lv_text2
        sap_style    = cl_dd_document=>list_positive
        sap_fontsize = cl_dd_document=>medium.

    CALL METHOD go_docu2->display_document
      EXPORTING
        parent = go_top2.
  ENDMETHOD.

  METHOD hotspot_click.
*    DATA: lv_mess  TYPE char200.
*
*    READ TABLE gt_sbook INTO gs_sbook INDEX e_row_id-index.
*    IF sy-subrc EQ 0.
*      CASE e_column_id.
*        WHEN 'CARRID'.
*          CONCATENATE
*          e_column_id
*          'deðeri'
*          gs_sbook-carrid
*          INTO lv_mess
*          SEPARATED BY space.
*          MESSAGE lv_mess TYPE 'I'.

    MESSAGE 'SKDFA' TYPE 'I'.

*      ENDCASE.
**
*    ENDIF.
  ENDMETHOD.
  METHOD double_click.
    DATA: lv_mess  TYPE char200,
          lv_value TYPE string.

    READ TABLE gt_sbook INTO gs_sbook INDEX e_row-index.
    IF sy-subrc = 0.
      FIELD-SYMBOLS: <fs_value> TYPE any.

      ASSIGN COMPONENT e_column-fieldname OF STRUCTURE gs_sbook TO <fs_value>.
      IF sy-subrc = 0.

        lv_value = <fs_value>.

        " Mesajý oluþtur ve göster
        CONCATENATE 'Týklanan kolon:'
                    e_column-fieldname
                    ', Satýrýn deðeri:'
                    lv_value
                    INTO lv_mess
                    SEPARATED BY space.

        MESSAGE lv_mess TYPE 'I'.
      ELSE.
        MESSAGE 'Kolon deðeri alýnamadý.' TYPE 'E'.
      ENDIF.
    ELSE.
      MESSAGE 'Veri bulunamadý.' TYPE 'E'.
    ENDIF.
  ENDMETHOD.


  METHOD data_changed.
    DATA: ls_modi TYPE lvc_s_modi,
          lv_mess TYPE char200.


    LOOP AT er_data_changed->mt_good_cells INTO ls_modi.
      READ TABLE gt_sbook INTO gs_sbook INDEX ls_modi-row_id.
      IF sy-subrc EQ 0.
        CONCATENATE ls_modi-fieldname
                    ' => eski deger'
                    gs_sbook-carrid
                    ', yeni deger'
                    ls_modi-value
                    INTO lv_mess
                    SEPARATED BY space.
        MESSAGE lv_mess TYPE 'I'.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.
  METHOD handle_onf4.

    TYPES: BEGIN OF lty_value_tab,
             carrid TYPE s_carr_id,
           END OF lty_value_tab.


    DATA: lt_value_tab TYPE TABLE OF lty_value_tab,
          ls_value_tab TYPE lty_value_tab.

    DATA: lt_return_tab TYPE TABLE OF ddshretval,
          ls_return_tab TYPE ddshretval.

    CLEAR: ls_value_tab.
    ls_value_tab-carrid = 'SG'.
    APPEND ls_value_tab TO lt_value_tab.
    CLEAR: ls_value_tab.
    ls_value_tab-carrid = 'NG'.
    APPEND ls_value_tab TO lt_value_tab.
    CLEAR: ls_value_tab.
    ls_value_tab-carrid = 'BG'.
    APPEND ls_value_tab TO lt_value_tab.


    CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
      EXPORTING
        retfield     = 'CARRID'
        window_title = 'CARRID F4'
        value_org    = 'S'
      TABLES
        value_tab    = lt_value_tab
        return_tab   = lt_return_tab.


*    READ TABLE lt_return_tab INTO ls_return_tab WITH KEY fieldname = 'F0001'.
*    IF sy-subrc EQ 0.
*      READ TABLE  gt_sflight ASSIGNING <gfs_sflight> INDEX es_row_no-row_id.
*      IF sy-subrc EQ 0.
*        <gfs_sflight>-carrid = ls_return_tab-fieldval.
*
*        go_alv2->refresh_table_display(  ).
*      ENDIF.
*
*    ENDIF.
*    er_event_data->m_event_handled = 'X'.

  ENDMETHOD.

  METHOD handle_button_click.

    DATA: lv_mess TYPE char200.
    READ TABLE gt_sflight INTO gs_sflight INDEX es_row_no-row_id.
    IF sy-subrc EQ 0.
      CASE es_col_id-fieldname.
        WHEN 'DELETE'.
          BREAK-POINT.
          CONCATENATE es_col_id-fieldname
         ','
          gs_sflight-carrid
          gs_sflight-connid
          gs_sflight-currency
          gs_sflight-planetype
          INTO lv_mess
          SEPARATED BY space.
          MESSAGE lv_mess TYPE 'I'.
      ENDCASE.
    ENDIF.

    READ TABLE gt_sbook INTO gs_sbook INDEX es_row_no-row_id.
    IF sy-subrc EQ 0.
      CASE es_col_id-fieldname.
        WHEN 'DELETE2'.
          CONCATENATE gs_sbook-passname
         'isimli yolcunun'
         gs_sbook-bookid
         'numaralý bileti iptal edildi.'
          INTO lv_mess
          SEPARATED BY space.
          MESSAGE lv_mess TYPE 'I'.
      ENDCASE.

    ENDIF.


  ENDMETHOD.

  METHOD handle_toolbar.
    DATA: ls_toolbar TYPE stb_button.

    CLEAR: ls_toolbar.
    ls_toolbar-function = '&DEL'.
    ls_toolbar-text = 'Silme'.
    ls_toolbar-icon = '@11@'.
    ls_toolbar-quickinfo = 'Silme butonu'.
    ls_toolbar-disabled = abap_false.
    APPEND ls_toolbar TO e_object->mt_toolbar.
    CLEAR: ls_toolbar.
    ls_toolbar-function = '&DISP'.
    ls_toolbar-text = 'Bilgi'.
    ls_toolbar-icon = '@10@'.
    ls_toolbar-disabled = abap_false.
    APPEND ls_toolbar TO e_object->mt_toolbar.



  ENDMETHOD.
  METHOD handle_user_command.
    CASE e_ucomm.
      WHEN '&DEL'.
        MESSAGE 'SÝLME ÝSLEMÝ YAPILDI' TYPE 'I'.
      WHEN '&DISP'.
        MESSAGE 'Aktif 38 biletin 23 ü erkek 15 i kadýn yolcudan oluþmaktadýr.' TYPE 'I'.
    ENDCASE.

  ENDMETHOD.
ENDCLASS.