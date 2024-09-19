
* *&---------------------------------------------------------------------*
*& Report ZBK_SCREEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbk_screen.

CONTROLS tabstrip TYPE TABSTRIP.
CONTROLS tabstrip2 TYPE TABSTRIP.

 CONSTANTS: c_screen_login TYPE i VALUE 7.


 call screen 7.

*CALL SCREEN 50.
*call screen 105.
CLASS cl_event_receiver DEFINITION DEFERRED.

INCLUDE zbk_datas.
INCLUDE zbk_evclas.
INCLUDE zbk_alv.

  INCLUDE zbk_sc.
  INCLUDE zbk_sbook_alv.