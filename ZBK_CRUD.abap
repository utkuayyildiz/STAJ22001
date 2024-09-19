*&---------------------------------------------------------------------*
*& Include          ZBK_CRUD
*&---------------------------------------------------------------------*

AT SELECTION-SCREEN OUTPUT.


  LOOP AT SCREEN.
    CASE screen-group1.
      WHEN 'PA1'.
        IF p_rad1 = 'X'.
          screen-active = '0'.
        ENDIF.


        IF p_rad3 = 'X'.
          screen-active = '1'.
        ENDIF.
*
        IF p_rad4 = 'X'.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
      WHEN 'PA2'.
        IF p_rad1 = 'X'.
          screen-active = '0'.
        ENDIF.
        IF p_rad2 = 'X'.
          screen-active = '1'.
        ENDIF.
        IF p_rad3 = 'X'.
          screen-active = '1'.
        ENDIF.
        IF p_rad4 = 'X'.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
      WHEN 'PA3'.
        IF p_rad1 = 'X'.
          screen-active = '0'.
        ENDIF.
        IF p_rad2 = 'X'.
          screen-active = '1'.
        ENDIF.
        IF p_rad3 = 'X'.
          screen-active = '1'.
        ENDIF.
        IF p_rad4 = 'X'.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
         WHEN 'PA4'.
        IF p_rad1 = 'X'.
          screen-active = '0'.
        ENDIF.
        IF p_rad2 = 'X'.
          screen-active = '1'.
        ENDIF.
        IF p_rad3 = 'X'.
          screen-active = '1'.
        ENDIF.
        IF p_rad4 = 'X'.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
         WHEN 'PA5'.
        IF p_rad1 = 'X'.
          screen-active = '0'.
        ENDIF.

        IF p_rad3 = 'X'.
          screen-active = '1'.
        ENDIF.
*
        IF p_rad4 = 'X'.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
         WHEN 'PA6'.
        IF p_rad1 = 'X'.
          screen-active = '0'.
        ENDIF.

        IF p_rad3 = 'X'.
          screen-active = '1'.
        ENDIF.
*
        IF p_rad4 = 'X'.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
    ENDCASE.
  ENDLOOP.

  IF p_rad3 EQ 'X'.
    SELECT isim soyisim sehir
         FROM zbk_db
    INTO CORRESPONDING FIELDS OF TABLE gt_tablo
    WHERE numara    = gv_num.
    IF sy-subrc = 0.
      LOOP AT gt_tablo INTO gs_tablo.
        gv_isim = gs_tablo-isim.
        gv_soy = gs_tablo-soyisim.
        gv_sehir = gs_tablo-sehir.
      ENDLOOP.
    ENDIF.
  ENDIF.

START-OF-SELECTION.


  IF p_rad3 EQ 'X'. "Veri güncelleme
    SELECT *
    FROM zbk_db
    INTO TABLE gt_tablo
    WHERE numara = gv_num.
    UPDATE zbk_db SET isim = gv_isim
        soyisim = gv_soy
        sehir = gv_sehir
         WHERE numara = gv_num.
    IF sy-subrc = 0.
      MESSAGE 'Employee Record Updated' TYPE 'I'.
    ELSEIF sy-subrc <> 0 .
      MESSAGE 'Wrong Employee ID3' TYPE 'E'.
      EXIT.
    ENDIF.
    EXIT.
  ENDIF.


  IF p_rad1 EQ 'X'. "Veri görüntüleme
    SELECT *
    FROM zbk_db
    INTO TABLE gt_tablo
    WHERE numara = gv_num.
    IF sy-subrc = 0 .
      LOOP AT gt_tablo INTO gs_tablo.
        FORMAT COLOR 1 INTENSIFIED ON. "Baþlýklara koyu renk ekleme
        WRITE: /3 'Calisan Numarasi',
                20 'Ýsim',
                35 'Soyisim',
                70  'Sehir'.
        ULINE. " FOR UNDERLINE
        FORMAT COLOR 2 INTENSIFIED ON.
        WRITE:/3 gs_tablo-numara, 20 gs_tablo-isim,35 gs_tablo-soyisim,70 gs_tablo-sehir.
      ENDLOOP.
      ULINE.
    ENDIF.
  ENDIF.


    IF p_rad2 EQ 'X'.
      gs_tablo-numara = gv_num.
      gs_tablo-isim = gv_isim.
      gs_tablo-soyisim = gv_soy.
      gs_tablo-sehir = gv_sehir.
      gs_tablo-pozisyon = gv_pozi.
      gs_tablo-araba = gv_araba.
      INSERT zbk_db FROM gs_tablo.
      IF sy-subrc = 0.
        MESSAGE 'Çalýþan kaydý eklendi.' TYPE 'I'.
      ELSEIF sy-subrc <> 0 .
        MESSAGE 'Yanlýþ çalýþan numarasý' TYPE 'E'.
        EXIT.
      ENDIF.
      EXIT.
    ENDIF.

  IF p_rad4 EQ 'X' .
    DELETE FROM zbk_db WHERE numara = gv_num.
    IF sy-subrc = 0.
      MESSAGE 'Calisan kaydi silindi' TYPE 'I'.
    ELSEIF sy-subrc <> 0 .
      MESSAGE 'Yanlis calisan numarasi girdiniz.' TYPE 'E'.
      EXIT.
    ENDIF.

  ENDIF.


AT SELECTION-SCREEN ON RADIOBUTTON GROUP rg1.