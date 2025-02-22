class ZCL_ZDEPM2_DPC_EXT definition
  public
  inheriting from ZCL_ZDEPM2_DPC
  create public .

public section.
protected section.

  methods PRODUCTSET_CREATE_ENTITY
    redefinition .
  methods PRODUCTSET_DELETE_ENTITY
    redefinition .
  methods PRODUCTSET_GET_ENTITY
    redefinition .
  methods PRODUCTSET_GET_ENTITYSET
    redefinition .
  methods PRODUCTSET_UPDATE_ENTITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZDEPM2_DPC_EXT IMPLEMENTATION.


  METHOD productset_create_entity.
    DATA: ls_entity     LIKE er_entity,
          ls_headerdata TYPE bapi_epm_product_header,
          lt_return     TYPE TABLE OF bapiret2.

    TRY .
        CALL METHOD io_data_provider->read_entry_data
          IMPORTING
            es_data = ls_entity.
      CATCH /iwbep/cx_mgw_tech_exception.
    ENDTRY.

    IF ls_entity IS NOT INITIAL.
      ls_headerdata-product_id     = ls_entity-productid.
      ls_headerdata-type_code      = ls_entity-typecode.
      ls_headerdata-category       = ls_entity-category.
      ls_headerdata-name           = ls_entity-name.
      ls_headerdata-description    = ls_entity-description.
      ls_headerdata-supplier_id    = ls_entity-supplierid.
      ls_headerdata-supplier_name  = ls_entity-suppliername.
      ls_headerdata-tax_tarif_code = ls_entity-tax.
      ls_headerdata-measure_unit   = ls_entity-measurement.
      ls_headerdata-currency_code  = ls_entity-currency.

      CALL FUNCTION 'BAPI_EPM_PRODUCT_CREATE'
        EXPORTING
          headerdata = ls_headerdata
*         persist_to_db = abap_true
        TABLES
*         CONVERSION_FACTORS       =
          return     = lt_return.
    ENDIF.

    IF lt_return is INITIAL.
      er_entity = ls_entity.
    ENDIF.
  ENDMETHOD.


  METHOD productset_delete_entity.
**TRY.
*CALL METHOD SUPER->PRODUCTSET_DELETE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.

    DATA: ls_keyprp  LIKE LINE OF it_key_tab,
          ls_product TYPE bapi_epm_product_id.

    READ TABLE it_key_tab INTO ls_keyprp WITH KEY name = 'ProductID' TRANSPORTING value.
    IF sy-subrc EQ 0.
      ls_product-product_id = ls_keyprp-value.

      CALL FUNCTION 'BAPI_EPM_PRODUCT_DELETE'
        EXPORTING
          product_id = ls_product
*         PERSIST_TO_DB       = ABAP_TRUE
* TABLES
*         RETURN     =
        .

    ENDIF.
  ENDMETHOD.


  METHOD productset_get_entity.
**TRY.
*CALL METHOD SUPER->PRODUCTSET_GET_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_request_object       =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**  IMPORTING
**    er_entity               =
**    es_response_context     =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.

    DATA: ls_keyprp     LIKE LINE OF it_key_tab,
          ls_product    TYPE bapi_epm_product_id,
          ls_headerdata TYPE bapi_epm_product_header.

    READ TABLE it_key_tab INTO ls_keyprp WITH KEY name = 'ProductID' TRANSPORTING value.
    IF sy-subrc EQ 0.
      ls_product-product_id = ls_keyprp-value.

      CALL FUNCTION 'BAPI_EPM_PRODUCT_GET_DETAIL'
        EXPORTING
          product_id = ls_product
        IMPORTING
          headerdata = ls_headerdata
*       TABLES
*         CONVERSION_FACTORS       =
*         RETURN     =
        .

      IF ls_headerdata IS NOT INITIAL.
        er_entity-productid    = ls_headerdata-product_id.
        er_entity-typecode     = ls_headerdata-type_code.
        er_entity-category     = ls_headerdata-category.
        er_entity-name         = ls_headerdata-name.
        er_entity-description  = ls_headerdata-description.
        er_entity-supplierid   = ls_headerdata-supplier_id.
        er_entity-suppliername = ls_headerdata-supplier_name.
        er_entity-tax          = ls_headerdata-tax_tarif_code.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD productset_get_entityset.
    DATA: it_headerdata TYPE TABLE OF bapi_epm_product_header,
          ls_headerdata LIKE LINE OF it_headerdata,
          ls_entityset  LIKE LINE OF et_entityset,
          ls_order      LIKE LINE OF it_order,
          lt_orderby    TYPE /iwbep/t_mgw_tech_order,
          ls_orderby    LIKE LINE OF lt_orderby,
          lt_sortname   TYPE abap_sortorder_tab,
          ls_sortname   LIKE LINE OF lt_sortname,
          ls_filterso   TYPE /iwbep/s_mgw_select_option,
          ls_so         TYPE /iwbep/s_cod_select_option,
          lt_idrange    TYPE TABLE OF bapi_epm_product_id_range,
          ls_idrange    TYPE bapi_epm_product_id_range,
          lv_top        TYPE string,
          ls_top        TYPE bapi_epm_max_rows.

    CALL METHOD io_tech_request_context->get_top
      RECEIVING
        rv_top = lv_top.

*    IF  lv_top IS NOT INITIAL.
    ls_top-bapimaxrow = lv_top.

*      CALL FUNCTION 'BAPI_EPM_PRODUCT_GET_LIST'
*        EXPORTING
*          max_rows   = ls_top
*        TABLES
*          headerdata = it_headerdata.

    READ TABLE it_filter_select_options INTO ls_filterso WITH KEY property = 'ProductID'
                                        TRANSPORTING select_options.
*
    IF sy-subrc EQ 0.
      READ TABLE ls_filterso-select_options INTO ls_so INDEX 1.
*
      IF sy-subrc EQ 0.
        CLEAR: ls_idrange.

        ls_idrange-sign   = ls_so-sign.
        ls_idrange-option = ls_so-option.
        ls_idrange-low    = ls_so-low.
        ls_idrange-high   = ls_so-high.
        APPEND ls_idrange TO lt_idrange.

        CALL FUNCTION 'BAPI_EPM_PRODUCT_GET_LIST'
          EXPORTING
            max_rows          = ls_top
          TABLES
            headerdata        = it_headerdata
            selparamproductid = lt_idrange.
      ENDIF.
    ELSE.
      CALL FUNCTION 'BAPI_EPM_PRODUCT_GET_LIST'
        EXPORTING
          max_rows   = ls_top
        TABLES
          headerdata = it_headerdata.
    ENDIF.

    IF it_headerdata IS NOT INITIAL.
      LOOP AT it_headerdata INTO ls_headerdata.
        CLEAR ls_entityset.

        ls_entityset-productid    = ls_headerdata-product_id.
        ls_entityset-typecode     = ls_headerdata-type_code.
        ls_entityset-category     = ls_headerdata-category.
        ls_entityset-name         = ls_headerdata-name.
        ls_entityset-description  = ls_headerdata-description.
        ls_entityset-supplierid   = ls_headerdata-supplier_id.
        ls_entityset-suppliername = ls_headerdata-supplier_name.
        ls_entityset-tax          = ls_headerdata-tax_tarif_code.
        ls_entityset-measurement  = ls_headerdata-measure_unit.
        ls_entityset-currency     = ls_headerdata-currency_code.

        APPEND ls_entityset TO et_entityset.
      ENDLOOP.
    ENDIF.

*    IF it_order IS NOT INITIAL.
*      READ TABLE it_order INTO ls_order WITH KEY property = 'ProductID'.
*
*      IF sy-subrc EQ 0.
*        CASE ls_order-order.
*          WHEN 'asc'.
*            SORT et_entityset BY productid.
*          WHEN 'desc'.
*            SORT et_entityset BY productid DESCENDING.
*          WHEN OTHERS.
**            Do nothing
*        ENDCASE.
*      ENDIF.
*    ENDIF.

    CALL METHOD io_tech_request_context->get_orderby
      RECEIVING
        rt_orderby = lt_orderby.

    IF lt_orderby IS NOT INITIAL.
      LOOP AT lt_orderby INTO ls_orderby.
        ls_sortname-name = ls_orderby-property.

        IF ls_orderby-order = 'desc'.
          ls_sortname-descending = abap_true.
        ELSE.
          ls_sortname-descending = abap_false.
        ENDIF.

        APPEND ls_sortname TO lt_sortname.
      ENDLOOP.

      SORT et_entityset BY (lt_sortname).
    ENDIF.
  ENDMETHOD.


  METHOD productset_update_entity.
    DATA: ls_entity      LIKE er_entity,
          ls_product     TYPE bapi_epm_product_id,
          ls_headerdata  TYPE bapi_epm_product_header,
          ls_headerdatax TYPE bapi_epm_product_headerx,
          lt_return      TYPE TABLE OF bapiret2.

    TRY.
        CALL METHOD io_data_provider->read_entry_data
          IMPORTING
            es_data = ls_entity.
      CATCH /iwbep/cx_mgw_tech_exception .
    ENDTRY.

    IF  ls_entity IS NOT INITIAL.
      ls_product-product_id = ls_entity-productid.

      ls_headerdata-product_id  = ls_entity-productid.
      ls_headerdata-name        = ls_entity-name.
      ls_headerdata-description = ls_entity-description.

      ls_headerdatax-product_id  = ls_entity-productid.
      ls_headerdatax-name        = 'X'.
      ls_headerdatax-description = 'X'.

      CALL FUNCTION 'BAPI_EPM_PRODUCT_CHANGE'
        EXPORTING
          product_id  = ls_product
          headerdata  = ls_headerdata
          headerdatax = ls_headerdatax
*         PERSIST_TO_DB             = ABAP_TRUE
        TABLES
*         CONVERSION_FACTORS        =
*         CONVERSION_FACTORSX       =
          return      = lt_return.

    ENDIF.
  ENDMETHOD.
ENDCLASS.
