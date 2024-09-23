* *&---------------------------------------------------------------------*
*& Include          ZBK_SCREEN_PBO_PAI
*&---------------------------------------------------------------------*


*
*
* MODULE status_0100 OUTPUT.
*   SET PF-STATUS '101'.
** SET TITLEBAR 'xxx'.
* ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0101 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
  MODULE user_command_0100 INPUT.
    CASE sy-ucomm.
      WHEN '&BACK'.
        SET SCREEN 0.
    ENDCASE.
  ENDMODULE.

  MODULE status_0101 OUTPUT.
    SET PF-STATUS '101'.
* SET TITLEBAR 'xxx'.
  ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0101  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
  MODULE user_command_0101 INPUT.
    CASE sy-ucomm.
      WHEN '&BACK'.
        SET SCREEN 0.
    ENDCASE.
  ENDMODULE.
* *&---------------------------------------------------------------------*
*& Module STATUS_0040 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
  MODULE status_0040 OUTPUT.
    SET PF-STATUS '150'.

  ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0040  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
  MODULE user_command_0040 INPUT.
    CASE sy-ucomm.
      WHEN '&BACK'.
        SET SCREEN 0.
        LEAVE PROGRAM.
      WHEN '&LOGIN'.

        DATA: gv_pers_name TYPE char20.

*        PARAMETERS: pers_id TYPE i,
*                    p_pword TYPE char20.

*        SELECT SINGLE pers_name
*               INTO gv_pers_name
*               FROM zbk_dnm_pers
*               WHERE id = uid
*                 AND sifre = upa
*                 AND durum = 'AKTIF'.

PARAMETERS: pid type i,
  pord type i.



      IF pid eq 2 and pord eq 1234.
       write: 'Giriþ baþarýlý. Hoþ geldiniz',sy-uname.
       call screen 6.
       else.
         write: 'hatalý giriþ yaptýnýz'.

      ENDIF.

* Sonuç kontrolü
        IF sy-subrc = 0.
          WRITE: / 'Giriþ baþarýlý. Hoþ geldiniz,', gv_pers_name.
        ELSE.
          WRITE: / 'Hatalý giriþ. Lütfen bilgilerinizi kontrol edin ve tekrar deneyin.'.
        ENDIF.

      WHEN '&SIGN'.
        CALL SCREEN 404.
        MESSAGE 'KAYDOL' TYPE 'I'.

    ENDCASE.
  ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0006 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
  MODULE status_0006 OUTPUT.
    SET PF-STATUS '66'.
* SET TITLEBAR 'xxx'.
  ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0006  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
  MODULE user_command_0006 INPUT.
    CASE sy-ucomm.
      WHEN '&BACK'.
        SET SCREEN 40.
      WHEN '&KAYDET'.
        IF pa_rad2 = 'X'.
          DATA: gs_tablo TYPE zbk_urun.

          CREATE OBJECT lo_urun
            EXPORTING
              iv_id    = islem_id
              iv_ad    = p_ad
              iv_durum = p_durum
              iv_type  = p_type.


          lo_urun->urun_ekle( ).
        ELSEIF pa_rad1 = 'X'.
          PERFORM zbk_tablo.
        ELSEIF pa_rad3 = 'X'.
          lo_urun->urun_guncelle( ).
          IF sy-subrc = 0.
            MESSAGE 'Ürün güncellendi' TYPE 'I'.
          ELSE.
            MESSAGE 'Ürün güncellenirken hata oluþtu' TYPE 'E'.
          ENDIF.
        ELSEIF pa_rad4 = 'X'.
          CREATE OBJECT lo_urun
            EXPORTING
              iv_id    = islem_id
              iv_ad    = p_ad
              iv_durum = p_durum
              iv_type  = p_type.
          lo_urun->urun_sil( iv_id = islem_id ).
          IF sy-subrc = 0.
            MESSAGE 'Ürün silindi' TYPE 'I'.
          ELSE.
            MESSAGE 'Ürün silinirken hata oluþtu' TYPE 'E'.
          ENDIF.
        ELSE .
          IF
          p_type <> ''.
            lo_urun->urun_tipi_getir( iv_type = p_type ).
          ELSEIF p_id <> 0.
            lo_urun->urun_getir( iv_id = islem_id ).
          ENDIF.

        ENDIF.
      WHEN '&USER'.
        SET SCREEN 850.

    ENDCASE.

  ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0750 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
  MODULE status_0750 OUTPUT.
    SET PF-STATUS '352'.
  ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0750  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
  MODULE user_command_0750 INPUT.
    CASE sy-ucomm.
      WHEN '&BACK'.
        LEAVE PROGRAM.
    ENDCASE.
  ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0850 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
  MODULE status_0850 OUTPUT.
    SET PF-STATUS '851'.
    PERFORM zbk_uye.
  ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0850  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
  MODULE user_command_0850 INPUT.
    CASE sy-ucomm.
      WHEN '&BACK'.
        SET SCREEN 0.
    ENDCASE.
  ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0404 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
  MODULE status_0404 OUTPUT.
    SET PF-STATUS '404'.
* SET TITLEBAR 'xxx'.
  ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0404  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
  MODULE user_command_0404 INPUT.
    CASE sy-ucomm.
      WHEN '&BACK'.
        LEAVE PROGRAM.

      WHEN '&ONAY'.
        INCLUDE zbk_kayit.
        SET SCREEN 40.
    ENDCASE.
  ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0533 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
  MODULE status_0533 OUTPUT.
    SET PF-STATUS '533'.
* SET TITLEBAR 'xxx'.
  ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0533  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
  MODULE user_command_0533 INPUT.
    CASE sy-ucomm..
      WHEN '&EXIT'.
        LEAVE PROGRAM.
    ENDCASE.
  ENDMODULE.