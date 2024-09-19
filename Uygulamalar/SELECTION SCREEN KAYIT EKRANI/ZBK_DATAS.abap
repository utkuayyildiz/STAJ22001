DATA: gt_fcat TYPE lvc_t_fcat,
      gs_fcat TYPE lvc_s_fcat.





DATA: gv_ad        TYPE char20,
      gv_soyad     TYPE char20,
      gv_tarih     TYPE datum,
      gv_departman TYPE char20,
      gv_yas       TYPE i,
      gv_rad1      TYPE xfeld,
      gv_rad2      TYPE xfeld.

data: gv_izin type int4.






TYPES: BEGIN OF gty_sbook,
         bookid     TYPE numc4,
         luggweight TYPE int4,
         forcuram   TYPE int4,
         forcurkey  TYPE char10,
         loccuram   TYPE int4,
         loccurkey  TYPE char10,
         passname   TYPE char30,
       END OF gty_sbook.

DATA: gs_cell_color_sbook TYPE lvc_s_scol.



DATA: gt_sbook TYPE TABLE OF gty_sbook,
      gs_sbook TYPE gty_sbook.


DATA: gv_bookid     TYPE numc4,
      gv_luggweight TYPE int4,
      gv_forcuram   TYPE int4,
      gv_forcurkey  TYPE char10,
      gv_loccuram   TYPE int4,
      gv_loccurkey  TYPE char10,
      gv_passname   TYPE char30.


data: gs_layout_sbook type lvc_s_layo.



DATA: go_cont TYPE REF TO cl_gui_custom_container.
DATA: go_splitter TYPE REF TO cl_gui_splitter_container.


DATA: go_cont2 TYPE REF TO cl_gui_custom_container.



DATA: go_gui1 TYPE REF TO cl_gui_container,
      go_gui2 TYPE REF TO cl_gui_container.

DATA: go_alv_sbook  TYPE REF TO cl_gui_alv_grid.



TYPES: BEGIN OF gty_table,
         ad         TYPE char20,
         soyad      TYPE char20,
         d_tarih    TYPE datum,
         departman  TYPE char20,
         yas        TYPE int4,
         cinsiyet   TYPE char20,
         sil        TYPE char10,
         line_color TYPE char4,
         izin type int4,
         cell_color TYPE lvc_t_scol,
       END OF gty_table.





DATA: gs_cell_color TYPE lvc_s_scol.

DATA: gt_table TYPE TABLE OF gty_table,
      gs_table TYPE zbk_calisan.


DATA: gs_layout TYPE lvc_s_layo.


FIELD-SYMBOLS : <gfs_stable> TYPE gty_table.