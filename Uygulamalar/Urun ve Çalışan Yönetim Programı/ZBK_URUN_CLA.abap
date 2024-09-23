*&---------------------------------------------------------------------*
*& Include          ZBK_URUN_CLA
*&---------------------------------------------------------------------*
 CLASS lcl_urun DEFINITION.
   PUBLIC SECTION.
     METHODS:
       constructor
         IMPORTING
           iv_id    TYPE int4
           iv_ad    TYPE char20
           iv_durum TYPE char20
           iv_type  TYPE char20,
       urun_ekle,
       update_days_since,
       urun_guncelle,
       urun_tipi_getir
         IMPORTING
                   iv_type        TYPE char20
         RETURNING VALUE(rv_data) TYPE zbk_urun,


       urun_sat
         IMPORTING
           iv_id TYPE int4,
       urun_sil
         IMPORTING
           iv_id TYPE int4,
       urun_getir
         IMPORTING
                   iv_id          TYPE int4
         RETURNING VALUE(rv_data) TYPE zbk_urun.

     CLASS-METHODS: class_constructor.

   PRIVATE SECTION.
     DATA: mv_id    TYPE int4,
           mv_ad    TYPE char20,
           mv_durum TYPE char20,
           mv_type  TYPE char20,
           gs_tablo TYPE zbk_urun.

 ENDCLASS.

 CLASS lcl_urun IMPLEMENTATION.
   METHOD constructor.
     mv_id    = iv_id.
     mv_ad    = iv_ad.
     mv_durum = iv_durum.
     mv_type  = iv_type.
   ENDMETHOD.

   METHOD class_constructor.




   ENDMETHOD.
   METHOD urun_ekle.
*     DATA: ls_tablo TYPE zbk_urun.



     IF mv_id IS INITIAL OR mv_ad IS INITIAL OR mv_durum IS INITIAL OR mv_type IS INITIAL.
       MESSAGE 'Lütfen tüm alanlarý doldurunuz.' TYPE 'E'.
       RETURN.
     ENDIF.

     gs_tablo-id = mv_id.
     gs_tablo-ad = mv_ad.
     gs_tablo-durum = mv_durum.
     gs_tablo-type = mv_type.
     gs_tablo-o_tarih = sy-datum.
     gs_tablo-sure = 0.
     INSERT zbk_urun FROM gs_tablo.
     IF sy-subrc EQ 0.
       MESSAGE 'Kayýt oluþturuldu.' TYPE 'I'.
     ELSE.
       MESSAGE 'Kayýt ekleme gerçekleþtirilemedi.' TYPE 'E'.
     ENDIF.
   ENDMETHOD.
   METHOD update_days_since.
     DATA: lt_tablo TYPE TABLE OF zbk_urun,
           lv_today TYPE sy-datum.

     lv_today = sy-datum.

     SELECT * FROM zbk_urun INTO TABLE lt_tablo.

     LOOP AT lt_tablo INTO DATA(ls_tablo).
       ls_tablo-sure = lv_today - ls_tablo-o_tarih.
       MODIFY zbk_urun FROM ls_tablo.
     ENDLOOP.
   ENDMETHOD.


   METHOD urun_guncelle.
     UPDATE zbk_urun
       SET ad = mv_ad
           type = mv_type
           durum = mv_durum
       WHERE id = mv_id.
     IF sy-subrc = 0.
       MESSAGE 'Kayýt güncellendi' TYPE 'I'.
     ELSE.
       MESSAGE 'Güncelleme iþlemi gerçekleþtirilemedi' TYPE 'E'.
     ENDIF.
   ENDMETHOD.

   METHOD urun_sil.
     DELETE FROM zbk_urun
       WHERE id = iv_id.
     IF sy-subrc = 0.
       MESSAGE 'Kayýt silindi' TYPE 'I'.
     ELSE.
       MESSAGE 'Silme iþlemi gerçekleþtirilemedi' TYPE 'E'.
     ENDIF.
   ENDMETHOD.
   METHOD urun_sat.


   ENDMETHOD.
   METHOD urun_getir.
     DATA: lt_table TYPE TABLE OF zbk_urun,  " Ýç tablo
           ls_table TYPE zbk_urun.           " Tek bir satýr

     " Load the table with the data where type matches iv_type
     SELECT * FROM zbk_urun
       WHERE id = @iv_id
       INTO TABLE @lt_table.

     IF lines( lt_table ) > 0.
       LOOP AT lt_table INTO ls_table.

       ENDLOOP.
     ELSE.
       WRITE: / 'No data found for type', iv_id.
     ENDIF.
     DATA: lt_data TYPE TABLE OF zbk_urun,
           lo_alv  TYPE REF TO cl_salv_table.

     SELECT * FROM zbk_urun
       WHERE id = @iv_id
        INTO TABLE @lt_table.


     CALL METHOD cl_salv_table=>factory
       EXPORTING
         list_display = if_salv_c_bool_sap=>false " ALV Displayed in List Mode
       IMPORTING
         r_salv_table = lo_alv
       CHANGING
         t_table      = lt_table.


     lo_alv->display( ).




   ENDMETHOD.


   METHOD urun_tipi_getir.
     DATA: lt_table TYPE TABLE OF zbk_urun,  " Ýç tablo
           ls_table TYPE zbk_urun.           " Tek bir satýr

     " Load the table with the data where type matches iv_type
     SELECT * FROM zbk_urun
       WHERE type = @iv_type
       INTO TABLE @lt_table.

     IF lines( lt_table ) > 0.
       LOOP AT lt_table INTO ls_table.

       ENDLOOP.
     ELSE.
       WRITE: / 'No data found for type', iv_type.
     ENDIF.
     DATA: lt_data TYPE TABLE OF zbk_urun,   " Ýç tablo
           lo_alv  TYPE REF TO cl_salv_table.  " SALV referans nesnesi

     " Verileri iç tabloya yükleme
     SELECT * FROM zbk_urun
       WHERE type = @iv_type
        INTO TABLE @lt_table.

     " SALV nesnesini oluþturma
     CALL METHOD cl_salv_table=>factory
       IMPORTING
         r_salv_table = lo_alv
       CHANGING
         t_table      = lt_table.



     " SALV ekranýný gösterme
     lo_alv->display( ).

   ENDMETHOD.

 ENDCLASS.


 START-OF-SELECTION.

   CREATE OBJECT lo_urun
     EXPORTING
       iv_id    = islem_id
       iv_ad    = p_ad
       iv_durum = p_durum
       iv_type  = p_type.
   CREATE OBJECT lo_ekran.

   lo_urun->update_days_since( ).
   IF p_rad2 EQ 'X'.
     lo_urun->urun_ekle( ).
   ELSEIF p_rad3 EQ 'X'.
     lo_urun->urun_guncelle( ).
   ELSEIF p_rad4 EQ 'X'.
     lo_urun->urun_sil( iv_id = islem_id ).
   ELSEIF p_rad1 EQ 'X'.

     PERFORM zbk_tablo.
   ELSEIF p_rad5 EQ 'X'.
     IF p_type <> ''.
       lo_urun->urun_tipi_getir( iv_type = p_type ).
     ELSEIF p_id <> 0.
       lo_urun->urun_getir( iv_id = p_id ).
     ENDIF.








   ENDIF.