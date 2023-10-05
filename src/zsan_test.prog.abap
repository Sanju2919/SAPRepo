*&---------------------------------------------------------------------*
*& Report ZSAN_TEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsan_test.
DATA: lt_file_content TYPE TABLE OF string.

* Specify the file path on the network file share
DATA(lv_file_path) = '\\sapsource\public\Archive\config.xml'.

* Open the file for reading
CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    filename        = lv_file_path
  TABLES
    data_tab        = lt_file_content
  EXCEPTIONS
    file_open_error = 1
    file_read_error = 2
    OTHERS          = 20.

IF sy-subrc = 0.
*  File read successfully
  LOOP AT lt_file_content ASSIGNING FIELD-SYMBOL(<lfs_file_content>).
    WRITE: / <lfs_file_content>.
  ENDLOOP.
ELSE.
*  Handle file read error
  IF sy-subrc = 17.
    DATA(lv_error_message) = 'File not found on the network share.'.
  ELSE.
    lv_error_message = 'Error reading the file from the network share.'.
  ENDIF.
  WRITE: / lv_error_message.
ENDIF.
*------------------------------------------------------------------
DATA: lv_file_content_al TYPE string.

* Specify the file path on the SAP application server
DATA(lv_file_path_al) = '\\triton1\dev_transfer\202310040944261H1U.txt'.

* Open the file for reading
OPEN DATASET lv_file_path_al FOR INPUT IN TEXT MODE ENCODING DEFAULT.

* Check if the file was opened successfully
IF sy-subrc = 0.
* Read the file content
  DO.
    READ DATASET lv_file_path_al INTO lv_file_content_al.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
* Process the content as needed
    WRITE: / lv_file_content_al.
  ENDDO.
* Close the file
  CLOSE DATASET lv_file_path_al.
ELSE.
* Handle file open error
  WRITE: / 'Error opening the file.'.
ENDIF.
