# Orderby---Query-option
Odata - Orderby + filter

/sap/opu/odata/sap/ZDEPM2_SRV/PRODUCTSet('HT-1031')
/sap/opu/odata/sap/ZDEPM2_SRV/PRODUCTSet?$orderby=Name desc
/sap/opu/odata/sap/ZDEPM2_SRV/PRODUCTSet?$orderby=ProductID desc, Description desc
/sap/opu/odata/sap/ZDEPM2_SRV/PRODUCTSet?$orderby=ProductID ge 'HT-1001' and ProductID le 'HT-1010'
/sap/opu/odata/sap/ZDEPM2_SRV/PRODUCTSet?$filter=ProductID ge 'HT-1001' and ProductID le 'HT-1010'
