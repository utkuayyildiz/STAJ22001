*&---------------------------------------------------------------------*
*& Include          ZBK_SC
*&---------------------------------------------------------------------*


**&---------------------------------------------------------------------*
**& Module STATUS_0060 OUTPUT
**&---------------------------------------------------------------------*
**&
**&---------------------------------------------------------------------*
MODULE status_0060 OUTPUT.
*  SET PF-STATUS '70'.
*  SET TITLEBAR 'xxx'.
ENDMODULE.
MODULE user_command_0060 INPUT.
  CASE sy-ucomm.
*    WHEN '&BACK'.
*      SET SCREEN 0.
    WHEN '&SAVE'.
*      CLEAR gv_ad.
*      CLEAR gv_soyad.
*      CLEAR gv_tarih.
*      CLEAR gv_departman.
*      CLEAR gv_yas.
*



      IF gv_ad IS INITIAL.
        MESSAGE 'Ad alaný boþ olamaz.' TYPE 'E'.
        EXIT.
      ENDIF.

      IF gv_soyad IS INITIAL.
        MESSAGE 'Soyad alaný boþ olamaz.' TYPE 'E'.
        EXIT.
      ENDIF.

      IF gv_tarih IS INITIAL.
        MESSAGE 'Doðum Tarihi alaný boþ olamaz.' TYPE 'E'.
        EXIT.
      ENDIF.

      IF gv_departman IS INITIAL.
        MESSAGE 'Departman alaný boþ olamaz.' TYPE 'E'.
        EXIT.
      ENDIF.

      IF gv_yas IS INITIAL.
        MESSAGE 'Yaþ alaný boþ olamaz.' TYPE 'E'.
        EXIT.
      ENDIF.


      gs_table-ad = gv_ad.
      gs_table-soyad = gv_soyad.
      gs_table-d_tarih = gv_tarih.
      gs_table-departman = gv_departman.
      gs_table-yas = gv_yas.
      gs_table-izin = gv_izin.

      IF gv_rad1 EQ abap_true.
        gs_table-cinsiyet = 'Erkek'.
      ELSEIF gv_rad2 EQ abap_true.
        gs_table-cinsiyet = 'Kadýn'.
      ENDIF.

      INSERT INTO zbk_calisan VALUES gs_table.
      COMMIT WORK AND WAIT.

      CALL SCREEN 510 STARTING AT 10 10
                       ENDING AT 40 30.


    WHEN '&CLSN'.
      CALL SCREEN 70.
  ENDCASE.
ENDMODULE.


*&---------------------------------------------------------------------*
*& Module STATUS_0050 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0050 OUTPUT.
  SET PF-STATUS '30'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0050  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0050 INPUT.
  CASE sy-ucomm.
    WHEN '&BACK'.
      SET SCREEN 0.
*      PERFORM display_sbook.
    WHEN '&TAB1'.
      tabstrip-activetab = '&TAB1'.
    WHEN '&TAB2'.
      tabstrip-activetab = '&TAB2'.
      PERFORM display_alv.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0510 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0510 OUTPUT.
  SET PF-STATUS '505'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0510  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0510 INPUT.
  CASE sy-ucomm.
    WHEN '&CANCEL'.
      SET SCREEN 0.
    WHEN '&DISPLAY'.
      tabstrip-activetab = '&TAB2'.
      PERFORM display_alv.
      SET SCREEN 0.
  ENDCASE.
ENDMODULE.

MODULE status_0301 OUTPUT.
  SET PF-STATUS '301'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0001  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0301 INPUT.
  CASE sy-ucomm.
    WHEN '&BACK'.
      SET SCREEN 0 .
  ENDCASE.
ENDMODULE.

MODULE status_0070 OUTPUT.
  SET PF-STATUS '900'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0070  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0070 INPUT.
  CASE sy-ucomm.
    WHEN '&BACK'.
      SET SCREEN 0.
    WHEN '&STAB1'.
      tabstrip2-activetab = '&STAB1'.
    WHEN '&STAB2'.
      tabstrip2-activetab = '&STAB2'.
      PERFORM display_sbook.

    WHEN '&SAVE2'.
      PARAMETERS : gvid    TYPE i,
                   gvcura  TYPE i,
                   gvcurk  TYPE char5,
                   gvlcura TYPE i,
                   gvlcurk TYPE char5,
                   gvlug   TYPE i,
                   gvpas   TYPE char20.

      CLEAR: gs_sbook.
      gs_sbook-bookid = gvid.
      gs_sbook-forcuram = gvcura.
      gs_sbook-forcurkey = gvcurk.
      gs_sbook-loccuram = gvlcura.
      gs_sbook-loccurkey = gvlcurk.
      gs_sbook-luggweight = gvlug.
      gs_sbook-passname = gvpas.
      INSERT INTO zbk_sbook VALUES gs_sbook.


      MESSAGE 'Bilet Kaydý Oluþturuldu.' TYPE 'I'.

  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0007 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0007 OUTPUT.
  SET PF-STATUS '7'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0007  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0007 INPUT.
  CASE sy-ucomm.
    WHEN '&BACK'.
      SET SCREEN 0 .

    WHEN '&SC1'.
      CALL SCREEN 50.
    WHEN '&SC2'.
      CALL SCREEN 70.
  ENDCASE.
ENDMODULE.