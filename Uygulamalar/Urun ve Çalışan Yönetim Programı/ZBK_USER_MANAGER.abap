*&---------------------------------------------------------------------*
*& Include          ZBK_USER_MANAGER
*&---------------------------------------------------------------------*
TABLES: zbk_dnm_pers.

CLASS lcl_user_manager DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_id    TYPE int4
          iv_name  TYPE char20
          iv_durum TYPE char20,
      register_user,
      authenticate_user
        IMPORTING
          iv_username TYPE char20
          iv_password TYPE char20
        RETURNING VALUE(rv_result) TYPE abap_bool,
      get_user_details
        IMPORTING
          iv_id TYPE int4
        RETURNING VALUE(rv_user) TYPE zbk_dnm_pers,
      update_user
        IMPORTING
          iv_id TYPE int4
          iv_name TYPE char20
          iv_durum TYPE char20.

  PRIVATE SECTION.
    DATA: mv_id    TYPE int4,
          mv_name  TYPE char20,
          mv_durum TYPE char20.
ENDCLASS.

CLASS lcl_user_manager IMPLEMENTATION.
  METHOD constructor.
    mv_id = iv_id.
    mv_name = iv_name.
    mv_durum = iv_durum.
  ENDMETHOD.

  METHOD register_user.
    
    DATA: gs_user TYPE zbk_dnm_pers.

    gs_user-pers_name = mv_name. 
    gs_user-durum = mv_durum.

    INSERT zbk_dnm_pers FROM gs_user.
    IF sy-subrc = 0.
      MESSAGE 'Kullanýcý baþarýyla kaydedildi.' TYPE 'I'.
    ELSE.
      MESSAGE 'Kullanýcý kaydedilemedi.' TYPE 'E'.
    ENDIF.
  ENDMETHOD.

  METHOD authenticate_user.
    DATA: ls_user TYPE zbk_dnm_pers.
    data: lt_user type zbk_dnm_pers.

    SELECT SINGLE *
      INTO ls_user
      FROM zbk_dnm_pers
    WHERE pers_name = iv_username AND sifre = iv_password.


    IF sy-subrc = 0.
      rv_result = abap_true.
    ELSE.
      rv_result = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD get_user_details.
    DATA: gs_user TYPE zbk_dnm_pers.

    SELECT SINGLE *
      INTO gs_user
      FROM zbk_dnm_pers
      WHERE id = iv_id.


    rv_user = gs_user.
  ENDMETHOD.

  METHOD update_user.
    UPDATE zbk_dnm_pers
      SET pers_name = @iv_name,
          durum = @iv_durum
      WHERE id = @iv_id.
    IF sy-subrc = 0.
      MESSAGE 'Kullanýcý baþarýyla güncellendi.' TYPE 'I'.
    ELSE.
      MESSAGE 'Kullanýcý güncellenemedi.' TYPE 'E'.
    ENDIF.
  ENDMETHOD.
ENDCLASS.