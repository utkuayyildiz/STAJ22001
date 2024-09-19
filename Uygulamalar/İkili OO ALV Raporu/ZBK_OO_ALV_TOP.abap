*&---------------------------------------------------------------------*
*& Include          ZBK_OO_ALV_TOP

TYPES: BEGIN OF gty_sflight,
         carrid    TYPE s_carr_id,
         connid    TYPE s_conn_id,
         price     TYPE s_price,
         currency  TYPE s_currcode,
         fldate    TYPE s_date,
         planetype TYPE s_planetye,
         delete    TYPE char10,
       END OF gty_sflight.

TYPES: BEGIN OF gty_sbook,
         carrid     TYPE s_carr_id,
         connid     TYPE s_conn_id,
         bookid     TYPE s_book_id,
         forcurkey  TYPE s_curr,
         smoker     TYPE s_smoker,
         delete2    TYPE char10,
         luggweight TYPE s_lugweigh,
         fldate     TYPE s_date,
         forcuram   TYPE s_f_cur_pr,
         passname   TYPE s_passname,
         loccuram   TYPE s_l_cur_pr,

       END OF gty_sbook.


PARAMETERS: p_vari TYPE disvariant-variant.


DATA: go_alv  TYPE REF TO cl_gui_alv_grid.

DATA: go_gui1 TYPE REF TO cl_gui_container,
      go_gui2 TYPE REF TO cl_gui_container.
DATA: go_alv2 TYPE REF TO cl_gui_alv_grid.


DATA: go_splitter TYPE REF TO cl_gui_splitter_container.
*

DATA: go_cont TYPE REF TO cl_gui_custom_container.

DATA: gt_tablo TYPE TABLE OF zbk_calisan.

DATA: gt_sbook TYPE TABLE OF gty_sbook,
      gs_sbook TYPE gty_sbook.

DATA: gt_sbook2 TYPE TABLE OF sbook,
      gs_sbook2 TYPE sbook.

DATA: gt_sflight TYPE TABLE OF gty_sflight,
      gs_sflight TYPE gty_sflight.


DATA: gs_cell_color TYPE lvc_s_scol.



DATA: gt_fieldcatalog  TYPE lvc_t_fcat,
      gs_fieldcatalog  TYPE lvc_s_fcat,
      gs_fieldcatalog2 TYPE lvc_s_fcat,
      gt_fieldcatalog2 TYPE lvc_t_fcat,
      gs_layout        TYPE lvc_s_layo.

DATA:gs_variant     TYPE disvariant,
     gs_variant_tmp TYPE disvariant.



DATA: gt_excluding TYPE ui_functions,
      gv_excluding TYPE ui_func.

DATA: gt_sort TYPE lvc_t_sort,
      gs_sort TYPE lvc_s_sort.

DATA: gt_filter TYPE lvc_t_filt,
      gs_filter TYPE lvc_s_filt.

FIELD-SYMBOLS:<gfs_sflight> TYPE gty_sflight.



FIELD-SYMBOLS: <gfs_fcat2> TYPE lvc_s_fcat.


FIELD-SYMBOLS : <gfs_fcat> TYPE lvc_s_fcat.

FIELD-SYMBOLS: <gfs_sbook> TYPE gty_sbook.

CLASS cl_event_receiver DEFINITION DEFERRED.
DATA: go_event_receiver TYPE REF TO cl_event_receiver.