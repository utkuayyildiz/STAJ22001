*&---------------------------------------------------------------------*
*& Include          ZBK_SATIS_RAPOR
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Include          ZBK_REPORT_GENERATOR
*&---------------------------------------------------------------------*
tables: zbk_satilan.
data go_report type REF TO lcl_report_generator.
CLASS lcl_report_generator DEFINITION.
  PUBLIC SECTION.
    METHODS:
      generate_sales_report
        IMPORTING
          iv_start_date TYPE d
          iv_end_date   TYPE d,
      generate_inventory_report,
      generate_user_activity_report.
  PRIVATE SECTION.
    METHODS:
      display_report
        IMPORTING
          it_data TYPE zbk_satilan.
ENDCLASS.

CLASS lcl_report_generator IMPLEMENTATION.

  METHOD generate_sales_report.
    DATA: lt_sales TYPE TABLE OF zbk_satilan,
          lv_total_sales TYPE p DECIMALS 2.

    SELECT * FROM zbk_satilan
      INTO TABLE @lt_sales
      WHERE satistarihi BETWEEN @iv_start_date AND @iv_end_date.


    LOOP AT lt_sales INTO DATA(ls_sale).
      lv_total_sales = lv_total_sales + ls_sale-id .
    ENDLOOP.

    display_report( zbk_satilan ).

    WRITE: / 'Toplam Satış Miktarı:', lv_total_sales.
  ENDMETHOD.

  METHOD generate_inventory_report.
    DATA: lt_inventory TYPE TABLE OF zbk_satilan.

    SELECT * FROM zbk_satilan
      INTO TABLE lt_inventory.

    " Raporu göster
    display_report( zbk_satilan ).
  ENDMETHOD.

  METHOD generate_user_activity_report.
    DATA: lt_user_activity TYPE TABLE OF zbk_user. " Burada kullanıcı aktiviteleri için gerekli tabloyu tanımlayın.

    SELECT * FROM zbk_user
      INTO TABLE lt_user_activity.

    display_report( zbk_satilan ).
  ENDMETHOD.

  METHOD display_report.

    data: lt_sale type table of zbk_satilan.
    LOOP AT lt_sale INTO DATA(ls_report).
      WRITE: / ls_report-satissaat, ls_report-satistarihi.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

create object go_report.


go_report->generate_user_activity_report( ).