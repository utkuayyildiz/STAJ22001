*&---------------------------------------------------------------------*
*& Include          ZBK_EV_CLS
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

  ENDMETHOD.

  METHOD hotspot_click.


  ENDMETHOD.

  METHOD double_click.

  ENDMETHOD.

  METHOD data_changed.
    DATA: ls_modi TYPE lvc_s_modi,
          lv_mess TYPE char200.

    DATA: gt_tablo TYPE TABLE OF gty_table,
          gs_tablo TYPE gty_table.

    LOOP AT er_data_changed->mt_good_cells INTO ls_modi.

      READ TABLE gt_tablo INTO gs_tablo INDEX ls_modi-row_id.
      IF sy-subrc EQ 0.
        CONCATENATE ls_modi-fieldname
                    '=> eski deðer '
                    gs_tablo-ad
                    ', yeni deðer'
                    ls_modi-value
                    INTO lv_mess
                    SEPARATED BY
                    space.
        message lv_mess type 'I'.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD handle_onf4.

  ENDMETHOD.

  METHOD handle_button_click.

  ENDMETHOD.

  METHOD handle_toolbar.

  ENDMETHOD.

  METHOD handle_user_command.

  ENDMETHOD.
ENDCLASS.