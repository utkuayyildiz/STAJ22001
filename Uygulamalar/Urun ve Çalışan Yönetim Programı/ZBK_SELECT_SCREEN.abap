*&---------------------------------------------------------------------*
*& Include          ZBK_SELECT_SCREEN
*&---------------------------------------------------------------------*



  AT SELECTION-SCREEN OUTPUT.
    LOOP AT SCREEN.
      CASE screen-group1.
        WHEN  'PA0' OR 'PA1' OR 'PA2' OR 'PA3' OR 'PA4'.
          screen-active = 0.
          IF username EQ uname AND password EQ pword.
            screen-active = 1.
          ENDIF.
          MODIFY SCREEN.


        WHEN 'P1' OR 'P2'.

          IF username IS NOT INITIAL AND password IS NOT INITIAL.
            screen-active = 0.
          ELSE.
            screen-active = 1.
          ENDIF.

          MODIFY SCREEN.
        WHEN 'P1' OR 'P2'.
          IF username EQ uname AND password EQ pword.
            screen-active = 0.
          ENDIF.
          MODIFY SCREEN.

        WHEN 'R1'.
          screen-active = 0.
          IF username EQ uname AND password EQ pword.
            screen-active = 1.
          ENDIF.
          MODIFY SCREEN.
        WHEN 'U1'.
          IF username EQ uname AND password EQ pword.
            screen-active = 0.
            MODIFY SCREEN.

          ENDIF.
        WHEN 'PA0' OR 'PA1' OR 'PA2' OR 'PA3' OR 'PA4'.
          IF p_rad2 = 'X'.
            screen-active = 1.
          ENDIF.
          MODIFY SCREEN.
      ENDCASE.

    ENDLOOP.

  AT SELECTION-SCREEN ON RADIOBUTTON GROUP rg1.







    at SELECTION-SCREEN ON RADIOBUTTON GROUP r2.

      LOOP AT SCREEN.
        CASE  screen-group2.
          WHEN 'SR2'.
            IF srad1 = 'X'.
                screen-active = 0.
            ENDIF.
             MODIFY SCREEN.

        ENDCASE.

      ENDLOOP.