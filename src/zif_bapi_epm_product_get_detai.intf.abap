interface ZIF_BAPI_EPM_PRODUCT_GET_DETAI
  public .


  types:
    SNWD_PRODUCT_ID type C length 000010 .
  types:
    SNWD_PRODUCT_TYPE_CODE type C length 000002 .
  types:
    SNWD_PRODUCT_CATEGORY type C length 000040 .
  types:
    SNWD_DESC type C length 000255 .
  types:
    SNWD_PARTNER_ID type C length 000010 .
  types:
    SNWD_COMPANY_NAME type C length 000080 .
  types:
    SNWD_QUANTITY_UNIT type C length 000003 .
  types:
    SNWD_WEIGHT_MEASURE type P length 7  decimals 000003 .
  types:
    SNWD_WEIGHT_UNIT type C length 000003 .
  types:
    SEPM_PRICE_BAPI type P length 12  decimals 000004 .
  types:
    SNWD_CURR_CODE type C length 000005 .
  types:
    SNWD_DIMENSION type P length 7  decimals 000003 .
  types:
    SNWD_DIM_UNIT type C length 000003 .
  types:
    SNWD_PRODUCT_PIC_URL type C length 000255 .
  types:
    begin of BAPI_EPM_PRODUCT_HEADER,
      PRODUCT_ID type SNWD_PRODUCT_ID,
      TYPE_CODE type SNWD_PRODUCT_TYPE_CODE,
      CATEGORY type SNWD_PRODUCT_CATEGORY,
      NAME type SNWD_DESC,
      DESCRIPTION type SNWD_DESC,
      SUPPLIER_ID type SNWD_PARTNER_ID,
      SUPPLIER_NAME type SNWD_COMPANY_NAME,
      TAX_TARIF_CODE type INT1,
      MEASURE_UNIT type SNWD_QUANTITY_UNIT,
      WEIGHT_MEASURE type SNWD_WEIGHT_MEASURE,
      WEIGHT_UNIT type SNWD_WEIGHT_UNIT,
      PRICE type SEPM_PRICE_BAPI,
      CURRENCY_CODE type SNWD_CURR_CODE,
      WIDTH type SNWD_DIMENSION,
      DEPTH type SNWD_DIMENSION,
      HEIGHT type SNWD_DIMENSION,
      DIM_UNIT type SNWD_DIM_UNIT,
      PRODUCT_PIC_URL type SNWD_PRODUCT_PIC_URL,
    end of BAPI_EPM_PRODUCT_HEADER .
  types:
    begin of BAPI_EPM_PRODUCT_ID,
      PRODUCT_ID type SNWD_PRODUCT_ID,
    end of BAPI_EPM_PRODUCT_ID .
  types:
    begin of BAPI_EPM_PRODUCT_CONV_FACTORS,
      PRODUCT_ID type SNWD_PRODUCT_ID,
      SOURCE_UNIT type SNWD_QUANTITY_UNIT,
      TARGET_UNIT type SNWD_QUANTITY_UNIT,
      NUMERATOR type INT4,
      DENOMINATOR type INT4,
    end of BAPI_EPM_PRODUCT_CONV_FACTORS .
  types:
    __2                            type standard table of BAPI_EPM_PRODUCT_CONV_FACTORS  with non-unique default key .
  types:
    BAPI_MTYPE type C length 000001 .
  types:
    SYMSGID type C length 000020 .
  types:
    SYMSGNO type N length 000003 .
  types:
    BAPI_MSG type C length 000220 .
  types:
    BALOGNR type C length 000020 .
  types:
    BALMNR type N length 000006 .
  types:
    SYMSGV type C length 000050 .
  types:
    BAPI_PARAM type C length 000032 .
  types:
    BAPI_FLD type C length 000030 .
  types:
    BAPILOGSYS type C length 000010 .
  types:
    begin of BAPIRET2,
      TYPE type BAPI_MTYPE,
      ID type SYMSGID,
      NUMBER type SYMSGNO,
      MESSAGE type BAPI_MSG,
      LOG_NO type BALOGNR,
      LOG_MSG_NO type BALMNR,
      MESSAGE_V1 type SYMSGV,
      MESSAGE_V2 type SYMSGV,
      MESSAGE_V3 type SYMSGV,
      MESSAGE_V4 type SYMSGV,
      PARAMETER type BAPI_PARAM,
      ROW type INT4,
      FIELD type BAPI_FLD,
      SYSTEM type BAPILOGSYS,
    end of BAPIRET2 .
  types:
    __BAPIRET2                     type standard table of BAPIRET2                       with non-unique default key .
endinterface.
