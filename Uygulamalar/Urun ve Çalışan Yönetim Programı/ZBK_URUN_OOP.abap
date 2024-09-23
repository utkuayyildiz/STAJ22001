
 REPORT zbk_urun_oop.

 DATA: gs_sat_fcat TYPE lvc_s_fcat,
       gt_sat_fcat TYPE lvc_t_fcat.




 TYPES: BEGIN OF ty_urun,
          ad          TYPE string,
          id          TYPE string,
          durum       TYPE string,
          satistarihi TYPE d,
          type        TYPE zbk_urun_tip,
          satissaat   TYPE p LENGTH 7 DECIMALS 2, " Example decimal field
        END OF ty_urun.


 TYPES : BEGIN OF gty_uye,
           pers_name  TYPE char20,
           pers_age   TYPE i,
           pers_dep   TYPE char20,
           durum      TYPE char20,
           uzaklastir TYPE char1,
         END OF gty_uye.

 DATA: gt_satilan TYPE TABLE OF ty_urun,
       gs_satilan TYPE ty_urun.



 DATA: uname TYPE i VALUE 1,
       pword TYPE i VALUE 123.


* data: persid type i value 2,
*       ppword type i value 1234.



 CONSTANTS: c_screen_login TYPE i VALUE 40.

 TYPES: BEGIN OF gty_table,
          id      TYPE zbk_urun_id,
          type    TYPE string,
          durum   TYPE string,
          ad      TYPE string,
          o_tarih TYPE zbk_urun_eklenme_tarih,
          sat     TYPE char1,
          sure    TYPE int4,

        END OF gty_table.



 DATA: gt_user TYPE TABLE OF zbk_user,
       gs_user TYPE zbk_user.


 DATA: gt_table TYPE TABLE OF gty_table,
       gs_table TYPE gty_table.

 FIELD-SYMBOLS: <gfs_table> TYPE gty_table.

 DATA: gv_sure TYPE zbk_urun_bulunma_tarih.

 DATA: gt_fieldcatalog TYPE lvc_t_fcat,
       gs_fieldcatalog TYPE lvc_s_fcat.

 DATA: go_alv       TYPE REF TO cl_gui_alv_grid,
       go_container TYPE REF TO cl_gui_container.

 DATA: go_ko TYPE REF TO cl_gui_custom_container.

 CLASS lcl_urun DEFINITION DEFERRED.
 CLASS lcl_ekran DEFINITION DEFERRED.
*  CLASS lcl_user DEFINITION DEFERRED.
 CLASS cl_event_receiver DEFINITION DEFERRED.
 DATA: go_event_receiver TYPE REF TO cl_event_receiver.






 DATA: onay TYPE char1.

 INCLUDE zbk_oop_pbo.
 INCLUDE zbk_oop_pai.

*   INCLUDE zbk_form_alv.




 PARAMETERS: islem_id TYPE int4 MODIF ID pa0.


* SELECTION-SCREEN BEGIN OF BLOCK blk2 WITH FRAME TITLE TEXT-102.
*
* PARAMETERS: gv_uname TYPE char20 MODIF ID pu1,
*             gv_pword TYPE char20 MODIF ID pu2 OBLIGATORY.
*
* SELECTION-SCREEN END OF BLOCK blk2.

 SELECTION-SCREEN BEGIN OF BLOCK blk1 WITH FRAME TITLE TEXT-101.
 PARAMETERS: p_rad1 MODIF ID r1 RADIOBUTTON GROUP rg1,
             p_rad2 MODIF ID r1 RADIOBUTTON GROUP rg1,
             p_rad3 MODIF ID r1 RADIOBUTTON GROUP rg1,
             p_rad4 MODIF ID r1 RADIOBUTTON GROUP rg1,
             p_rad5 MODIF ID r1 RADIOBUTTON GROUP  rg1.
 SELECTION-SCREEN END OF BLOCK blk1.


 SELECTION-SCREEN BEGIN OF SCREEN 0.
 PARAMETERS: pa_rad1 MODIF ID ra1 RADIOBUTTON GROUP r1,
             pa_rad2 MODIF ID ra2 RADIOBUTTON GROUP r1,
             pa_rad3 MODIF ID ra3 RADIOBUTTON GROUP r1,
             pa_rad4 MODIF ID ra4 RADIOBUTTON GROUP r1,
             pa_rad5 MODIF ID ra5 RADIOBUTTON GROUP r1.
 SELECTION-SCREEN END OF SCREEN 0.


 SELECTION-SCREEN BEGIN OF BLOCK blk2 .
 PARAMETERS: srad1 MODIF ID sr1 RADIOBUTTON GROUP r2,
             srad2 MODIF ID sr2 RADIOBUTTON GROUP r2,
             srad3 MODIF ID sr3 RADIOBUTTON GROUP r2.
 SELECTION-SCREEN END OF BLOCK blk2.




 PARAMETERS: p_id    TYPE int4 MODIF ID pa1,
             p_type  TYPE char20 MODIF ID pa2,
             p_ad    TYPE char20 MODIF ID pa3,
             p_durum TYPE char20 MODIF ID pa4.



 PARAMETERS: username TYPE i MODIF ID u1,
             password TYPE i MODIF ID u1.


* PARAMETERS: pers_id TYPE char10 MODIF ID p1,
*             p_pword TYPE i MODIF ID p1.


 DATA: lv_row_id    TYPE lvc_index,
       lv_col_id    TYPE string,
       lv_secim     TYPE char10,
       lv_id        TYPE zbk_urun_id,
       lv_new_secim TYPE char10.

 DATA: lo_urun  TYPE REF TO lcl_urun,
       lo_ekran TYPE REF TO lcl_ekran.

 DATA: lv_mess TYPE char200.

 INCLUDE zbk_urun_cla.
 INCLUDE zbk_user_cl.
 PERFORM zbk_uye.
 INCLUDE zbk_user_manager.
 CLASS lcl_report_generator DEFINITION DEFERRED.
 INCLUDE zbk_satis_rapor.
 INCLUDE zbk_ev_cla.



 DATA: gt_excluding TYPE ui_functions,
       gv_excluding TYPE ui_func.

 DATA: gt_sort TYPE lvc_t_sort,
       gs_sort TYPE lvc_s_sort.

 DATA: gt_filter TYPE lvc_t_filt,
       gs_filter TYPE lvc_s_filt.

 DATA: gs_layout TYPE lvc_s_layo.

 INCLUDE zbk_urun_oop_zbk_tablof01.

 INITIALIZATION.
   CALL SCREEN 40.
   uname = 1.
   pword = 123.


   INCLUDE zbk_select_screen.


 START-OF-SELECTION.

   INCLUDE zbk_screen_pbo_pai.