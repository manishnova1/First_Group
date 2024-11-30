// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cms_variables_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CmsVariablesModel _$CmsVariablesModelFromJson(Map<String, dynamic> json) =>
    CmsVariablesModel(
      STATUS: json['STATUS'] as num?,
      CMSVARIABLES: json['CMSVARIABLES'] == null
          ? null
          : CMSVARIABLESBean.fromJson(
              json['CMSVARIABLES'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CmsVariablesModelToJson(CmsVariablesModel instance) =>
    <String, dynamic>{
      'STATUS': instance.STATUS,
      'CMSVARIABLES': instance.CMSVARIABLES,
    };

CMSVARIABLESBean _$CMSVARIABLESBeanFromJson(Map<String, dynamic> json) =>
    CMSVARIABLESBean(
      intelligenceReportConfirmationMessage:
          json['intelligenceReportConfirmationMessage'] as String?,
      IS_SSO_LOGIN: json['IS_SSO_LOGIN'] as String?,
      CustomerClaim_Ticket_INFO_Introduction:
          json['CustomerClaim_Ticket_INFO_Introduction'] as String?,
      Revp_APP_PFCaseLabel: json['Revp_APP_PFCaseLabel'] as String?,
      Revp_CP_ReferenceTooltip: json['Revp_CP_ReferenceTooltip'] as String?,
      WithInDaysMessage: json['WithInDaysMessage'] as String?,
      CompensationAlert_PayPal: json['CompensationAlert_PayPal'] as String?,
      TicketScannerDenied: json['TicketScannerDenied'] as String?,
      CustomerClaim_Compensation_INFO_Check:
          json['CustomerClaim_Compensation_INFO_Check'] as String?,
      TcsCmsVaribleResetapp: json['TcsCmsVaribleResetapp'] as String?,
      CustomerClaim_Ticket_ticketimage_googleDrive:
          json['CustomerClaim_Ticket_ticketimage_googleDrive'] as String?,
      CompensationAlert_CashableVoucher:
          json['CompensationAlert_CashableVoucher'] as String?,
      GOG_EnvironamentIndication: json['GOG_EnvironamentIndication'] as String?,
      GOGLinkNotFoundMessage: json['GOGLinkNotFoundMessage'] as String?,
      CustomerSmartCard_Validation_Incorrect:
          json['CustomerSmartCard_Validation_Incorrect'] as String?,
      CustomerMyaccount_Ticket_TOOLTIP_from:
          json['CustomerMyaccount_Ticket_TOOLTIP_from'] as String?,
      TicketToolTip_NonBarcode_Paper_Price:
          json['TicketToolTip_NonBarcode_Paper_Price'] as String?,
      CustomerClaim_Personal_INFO_Introduction_REMOVE:
          json['CustomerClaim_Personal_INFO_Introduction_REMOVE'] as String?,
      CP_MyAccountPromotion: json['CP_MyAccountPromotion'] as String?,
      CUSTOMERSMARTCARD_VALIDATION_INFO:
          json['CUSTOMERSMARTCARD_VALIDATION_INFO'] as String?,
      CompensationPaymentByCreditCard_DetailsOnRecord:
          json['CompensationPaymentByCreditCard_DetailsOnRecord'] as String?,
      CompensationPaymentByCreditCard_DetailsExpired:
          json['CompensationPaymentByCreditCard_DetailsExpired'] as String?,
      CompensationAlert_ArgosVoucher:
          json['CompensationAlert_ArgosVoucher'] as String?,
      MYACCOUTPASSWORDCRITERIYATOOLTIP:
          json['MYACCOUTPASSWORDCRITERIYATOOLTIP'] as String?,
      CustomerClaim_Ticket_INFO_ReferenceNumbers:
          json['CustomerClaim_Ticket_INFO_ReferenceNumbers'] as String?,
      CustomerClaim_Ticket_TOOLTIP_to:
          json['CustomerClaim_Ticket_TOOLTIP_to'] as String?,
      CustomerFeedback: json['CustomerFeedback'] as String?,
      CompensationPaymentByPaypal:
          json['CompensationPaymentByPaypal'] as String?,
      CustomerClaim_Journey_INFO_MultiplePassengers:
          json['CustomerClaim_Journey_INFO_MultiplePassengers'] as String?,
      BenifitsMessage: json['BenifitsMessage'] as String?,
      CompensationAlert_SeasonDirect:
          json['CompensationAlert_SeasonDirect'] as String?,
      CompensationAlert_Voucher: json['CompensationAlert_Voucher'] as String?,
      Revp_CP_underAppealIntructionText:
          json['Revp_CP_underAppealIntructionText'] as String?,
      smsCpTemplate: json['smsCpTemplate'] as String?,
      TicketToolTip_NonBarcode_CollectionReference_CTR:
          json['TicketToolTip_NonBarcode_CollectionReference_CTR'] as String?,
      CompensationAlert_CashVoucher:
          json['CompensationAlert_CashVoucher'] as String?,
      AbandonedJourneyRedirectContent:
          json['AbandonedJourneyRedirectContent'] as String?,
      CustomerClaim_Compensation_INFO_Introduction:
          json['CustomerClaim_Compensation_INFO_Introduction'] as String?,
      CustomerClaim_Ticket_OysterCardInfo:
          json['CustomerClaim_Ticket_OysterCardInfo'] as String?,
      CustomerClaim_Journey_INFO_Introduction:
          json['CustomerClaim_Journey_INFO_Introduction'] as String?,
      CustomerClaim_Ticket_TOOLTIP_Ticket_Reference_2_FieldName:
          json['CustomerClaim_Ticket_TOOLTIP_Ticket_Reference_2_FieldName']
              as String?,
      TicketFoundUseForPreClaim: json['TicketFoundUseForPreClaim'] as String?,
      CustomerClaim_Compensation_INFO_AmazonVoucher:
          json['CustomerClaim_Compensation_INFO_AmazonVoucher'] as String?,
      CompensationAlert_PAYMPingIT:
          json['CompensationAlert_PAYMPingIT'] as String?,
      ClaimSuccessSubmittedMessage:
          json['ClaimSuccessSubmittedMessage'] as String?,
      MDRANewRegisterBenefit: json['MDRANewRegisterBenefit'] as String?,
      CustomerClaim_Ticket_TOOLTIP_ticketimagefilefieldname:
          json['CustomerClaim_Ticket_TOOLTIP_ticketimagefilefieldname']
              as String?,
      CustomerClaim_Compensation_INFO_Charity:
          json['CustomerClaim_Compensation_INFO_Charity'] as String?,
      errorTicketDetails: json['errorTicketDetails'] as String?,
      CustomerClaim_Ticket_TOOLTIP_zipcodefieldname:
          json['CustomerClaim_Ticket_TOOLTIP_zipcodefieldname'] as String?,
      CustomerClaimFormEndPara: json['CustomerClaimFormEndPara'] as String?,
      TicketToolTip_NonBarcode_CollectionReference_Price:
          json['TicketToolTip_NonBarcode_CollectionReference_Price'] as String?,
      CompensationAlert_BACS: json['CompensationAlert_BACS'] as String?,
      CustomerClaim_Journey_TOOLTIP_to:
          json['CustomerClaim_Journey_TOOLTIP_to'] as String?,
      CompensationAlert_RailTravelVoucher:
          json['CompensationAlert_RailTravelVoucher'] as String?,
      ClaimSubmitErrorMessage: json['ClaimSubmitErrorMessage'] as String?,
      CustomerClaim_Compensation_INFO_Argos:
          json['CustomerClaim_Compensation_INFO_Argos'] as String?,
      Myaccount_Ticket_Tooltip_Type:
          json['Myaccount_Ticket_Tooltip_Type'] as String?,
      CompensationAlert_PayPointeVoucher:
          json['CompensationAlert_PayPointeVoucher'] as String?,
      CompensationPaymentByPaypoint:
          json['CompensationPaymentByPaypoint'] as String?,
      Revp_APP_UFNCaseHTLabel: json['Revp_APP_UFNCaseHTLabel'] as String?,
      TicketFoundNotUseOtherclaim:
          json['TicketFoundNotUseOtherclaim'] as String?,
      CustomerClaim_Ticket_TOOLTIP_from:
          json['CustomerClaim_Ticket_TOOLTIP_from'] as String?,
      CompensationPaymentByCheque:
          json['CompensationPaymentByCheque'] as String?,
      Unpaid_Fair_Notice_Legal_Statement:
          json['Unpaid_Fair_Notice_Legal_Statement'],
      RevpAPPAdditionalAdminFeeText:
          json['RevpAPPAdditionalAdminFeeText'] as String?,
      TicketToolTip_NonBarcode_Paper_Reference:
          json['TicketToolTip_NonBarcode_Paper_Reference'] as String?,
      MYACCOUTPASSWORDCRITERIYATOOL:
          json['MYACCOUTPASSWORDCRITERIYATOOL'] as String?,
      CustomerClaim_Compensation_INFO_PAYMPINGIT:
          json['CustomerClaim_Compensation_INFO_PAYMPINGIT'] as String?,
      CustomerClaim_Journey_TOOLTIP_from:
          json['CustomerClaim_Journey_TOOLTIP_from'] as String?,
      CompensationPaymentByCreditCard_DetailsRequired:
          json['CompensationPaymentByCreditCard_DetailsRequired'] as String?,
      customerClaimCompensationInfoAmazonCoUk:
          json['customerClaimCompensationInfoAmazonCoUk'],
      AgentNotification_Test: json['AgentNotification_Test'] as String?,
      Revp_APP_UFNCaseLabel: json['Revp_APP_UFNCaseLabel'] as String?,
      ClaimDecisionApproved: json['ClaimDecisionApproved'] as String?,
      CustomerMyaccount_Ticket_TOOLTIP_to:
          json['CustomerMyaccount_Ticket_TOOLTIP_to'] as String?,
      TicketToolTip_NonBarcode_Smartcard_Price:
          json['TicketToolTip_NonBarcode_Smartcard_Price'] as String?,
      CustomerClaim_Ticket_TOOLTIP_Cost:
          json['CustomerClaim_Ticket_TOOLTIP_Cost'] as String?,
      CUSTOMERCLAIM_TICKET_TOOLTIP_TICKET_REFERENCE_2_FIELDNAME_MYACCOUNT: json[
              'CUSTOMERCLAIM_TICKET_TOOLTIP_TICKET_REFERENCE_2_FIELDNAME_MYACCOUNT']
          as String?,
      TicketScannerAllowed: json['TicketScannerAllowed'] as String?,
      TicketToolTip_Barcode_Price:
          json['TicketToolTip_Barcode_Price'] as String?,
      TicketToolTip_NonBarcode_Paper_number:
          json['TicketToolTip_NonBarcode_Paper_number'] as String?,
      CompensationAlert_Charity: json['CompensationAlert_Charity'] as String?,
      GOGCommunicationPrivacyPolicyMessage:
          json['GOGCommunicationPrivacyPolicyMessage'] as String?,
      errorTicketNotFound: json['errorTicketNotFound'] as String?,
      CompensationAlert_OtherSlower:
          json['CompensationAlert_OtherSlower'] as String?,
      ClaimSuccessUpdatedMessage: json['ClaimSuccessUpdatedMessage'] as String?,
      CustomerClaim_Compensation_INFO_Credit_Debit_Card:
          json['CustomerClaim_Compensation_INFO_Credit_Debit_Card'] as String?,
      TestTipDelete: json['TestTipDelete'] as String?,
      CustomerClaim_Ticket_TOOLTIP_Ticket_Reference_1_FieldName:
          json['CustomerClaim_Ticket_TOOLTIP_Ticket_Reference_1_FieldName']
              as String?,
      CompensationPaymentByVoucher:
          json['CompensationPaymentByVoucher'] as String?,
      MDRACheckRegisterPageTitle: json['MDRACheckRegisterPageTitle'] as String?,
      InvaildTicketProvided: json['InvaildTicketProvided'] as String?,
      CompensationAlert_Cheque: json['CompensationAlert_Cheque'] as String?,
      MDRAHomeButtonCaption: json['MDRAHomeButtonCaption'] as String?,
      CompensationPaymentByPAYM: json['CompensationPaymentByPAYM'] as String?,
      CustomerClaimFormStartPara: json['CustomerClaimFormStartPara'] as String?,
      errorTravelDATENotCurrentDate:
          json['errorTravelDATENotCurrentDate'] as String?,
      CustomerClaim_Ticket_TOOLTIP_Type:
          json['CustomerClaim_Ticket_TOOLTIP_Type'] as String?,
      ClaimDecisionRejection: json['ClaimDecisionRejection'] as String?,
      CustomerClaim_OysterCard_TOOLTIP_from:
          json['CustomerClaim_OysterCard_TOOLTIP_from'] as String?,
      CustomerClaim_Journey_ToolTip_Number_of_Changes_FieldName:
          json['CustomerClaim_Journey_ToolTip_Number_of_Changes_FieldName']
              as String?,
      TicketToolTip_NonBarcode_Paper_paymenttype:
          json['TicketToolTip_NonBarcode_Paper_paymenttype'] as String?,
      CustomerClaim_Ticket_TOOLTIP_Ticket_TimeFieldName_REMOVE:
          json['CustomerClaim_Ticket_TOOLTIP_Ticket_TimeFieldName_REMOVE']
              as String?,
      Penalty_Fair_Notice_Legal_Statement:
          json['Penalty_Fair_Notice_Legal_Statement'],
      successTicketDetailsOvernight:
          json['successTicketDetailsOvernight'] as String?,
      CustomerClaim_Compensation_INFO_Thomas:
          json['CustomerClaim_Compensation_INFO_Thomas'] as String?,
      TicketToolTip_Barcode_UTNNumber:
          json['TicketToolTip_Barcode_UTNNumber'] as String?,
      CustomerClaim_Compensation_INFO_BACS:
          json['CustomerClaim_Compensation_INFO_BACS'] as String?,
      CUSTOMERCLAIM_TICKET_TOOLTIP_TICKET_REFERENCE_1_FIELDNAME_MYACCOUNT: json[
              'CUSTOMERCLAIM_TICKET_TOOLTIP_TICKET_REFERENCE_1_FIELDNAME_MYACCOUNT']
          as String?,
      TicketToolTip_NonBarcode_OtherContactless_Price:
          json['TicketToolTip_NonBarcode_OtherContactless_Price'] as String?,
      CustomerClaim_Compensation_INFO_RailTravelVoucher:
          json['CustomerClaim_Compensation_INFO_RailTravelVoucher'] as String?,
      CompensationAlert_CreditDebitCard:
          json['CompensationAlert_CreditDebitCard'] as String?,
      CustomerClaim_Compensation_INFO_PayPal:
          json['CustomerClaim_Compensation_INFO_PayPal'] as String?,
      CustomerPortalAlertMessage: json['CustomerPortalAlertMessage'] as String?,
      CompensationPaymentByCharity:
          json['CompensationPaymentByCharity'] as String?,
      CustomerClaim_Personal_INFO_Remember_My_Details:
          json['CustomerClaim_Personal_INFO_Remember_My_Details'] as String?,
      CustomerClaim_Compensation_INFO_Cheque:
          json['CustomerClaim_Compensation_INFO_Cheque'] as String?,
      CompensationAlert_AmazoncoukGiftCard:
          json['CompensationAlert_AmazoncoukGiftCard'] as String?,
      CompensationAlert_BankAccount:
          json['CompensationAlert_BankAccount'] as String?,
      CustomerClaim_Ticket_TOOLTIP_Ticket_Image:
          json['CustomerClaim_Ticket_TOOLTIP_Ticket_Image'] as String?,
      Smartcard_Approval_Warning: json['Smartcard_Approval_Warning'] as String?,
      CustomerClaim_Journey_INFO_delayTypeLength:
          json['CustomerClaim_Journey_INFO_delayTypeLength'] as String?,
      MultiLegV2AmendDesscription:
          json['MultiLegV2AmendDesscription'] as String?,
      Revp_CP_AppealIntructionText2:
          json['Revp_CP_AppealIntructionText2'] as String?,
      Warning_NoTicket_NotDefaced:
          json['Warning_NoTicket_NotDefaced'] as String?,
      testTestUpdate: json['testTestUpdate'],
      CompensationAlert_ThomasCookVoucher:
          json['CompensationAlert_ThomasCookVoucher'] as String?,
      PTTCommunicationPrivacyPolicyMessage:
          json['PTTCommunicationPrivacyPolicyMessage'] as String?,
      ClaimAlreadySubmittedMessage:
          json['ClaimAlreadySubmittedMessage'] as String?,
      MultiLegV2MultipleLegFound: json['MultiLegV2MultipleLegFound'] as String?,
      GOGwelcomeTxt: json['GOGwelcomeTxt'] as String?,
      Fraud_placeholder: json['Fraud_placeholder'] as String?,
    );

Map<String, dynamic> _$CMSVARIABLESBeanToJson(CMSVARIABLESBean instance) =>
    <String, dynamic>{
      'intelligenceReportConfirmationMessage':
          instance.intelligenceReportConfirmationMessage,
      'IS_SSO_LOGIN': instance.IS_SSO_LOGIN,
      'CustomerClaim_Ticket_INFO_Introduction':
          instance.CustomerClaim_Ticket_INFO_Introduction,
      'Revp_APP_PFCaseLabel': instance.Revp_APP_PFCaseLabel,
      'Revp_CP_ReferenceTooltip': instance.Revp_CP_ReferenceTooltip,
      'WithInDaysMessage': instance.WithInDaysMessage,
      'CompensationAlert_PayPal': instance.CompensationAlert_PayPal,
      'TicketScannerDenied': instance.TicketScannerDenied,
      'CustomerClaim_Compensation_INFO_Check':
          instance.CustomerClaim_Compensation_INFO_Check,
      'TcsCmsVaribleResetapp': instance.TcsCmsVaribleResetapp,
      'CustomerClaim_Ticket_ticketimage_googleDrive':
          instance.CustomerClaim_Ticket_ticketimage_googleDrive,
      'CompensationAlert_CashableVoucher':
          instance.CompensationAlert_CashableVoucher,
      'GOG_EnvironamentIndication': instance.GOG_EnvironamentIndication,
      'GOGLinkNotFoundMessage': instance.GOGLinkNotFoundMessage,
      'CustomerSmartCard_Validation_Incorrect':
          instance.CustomerSmartCard_Validation_Incorrect,
      'CustomerMyaccount_Ticket_TOOLTIP_from':
          instance.CustomerMyaccount_Ticket_TOOLTIP_from,
      'TicketToolTip_NonBarcode_Paper_Price':
          instance.TicketToolTip_NonBarcode_Paper_Price,
      'CustomerClaim_Personal_INFO_Introduction_REMOVE':
          instance.CustomerClaim_Personal_INFO_Introduction_REMOVE,
      'CP_MyAccountPromotion': instance.CP_MyAccountPromotion,
      'CUSTOMERSMARTCARD_VALIDATION_INFO':
          instance.CUSTOMERSMARTCARD_VALIDATION_INFO,
      'CompensationPaymentByCreditCard_DetailsOnRecord':
          instance.CompensationPaymentByCreditCard_DetailsOnRecord,
      'CompensationPaymentByCreditCard_DetailsExpired':
          instance.CompensationPaymentByCreditCard_DetailsExpired,
      'CompensationAlert_ArgosVoucher': instance.CompensationAlert_ArgosVoucher,
      'MYACCOUTPASSWORDCRITERIYATOOLTIP':
          instance.MYACCOUTPASSWORDCRITERIYATOOLTIP,
      'CustomerClaim_Ticket_INFO_ReferenceNumbers':
          instance.CustomerClaim_Ticket_INFO_ReferenceNumbers,
      'CustomerClaim_Ticket_TOOLTIP_to':
          instance.CustomerClaim_Ticket_TOOLTIP_to,
      'CustomerFeedback': instance.CustomerFeedback,
      'CompensationPaymentByPaypal': instance.CompensationPaymentByPaypal,
      'CustomerClaim_Journey_INFO_MultiplePassengers':
          instance.CustomerClaim_Journey_INFO_MultiplePassengers,
      'BenifitsMessage': instance.BenifitsMessage,
      'CompensationAlert_SeasonDirect': instance.CompensationAlert_SeasonDirect,
      'CompensationAlert_Voucher': instance.CompensationAlert_Voucher,
      'Revp_CP_underAppealIntructionText':
          instance.Revp_CP_underAppealIntructionText,
      'smsCpTemplate': instance.smsCpTemplate,
      'TicketToolTip_NonBarcode_CollectionReference_CTR':
          instance.TicketToolTip_NonBarcode_CollectionReference_CTR,
      'CompensationAlert_CashVoucher': instance.CompensationAlert_CashVoucher,
      'AbandonedJourneyRedirectContent':
          instance.AbandonedJourneyRedirectContent,
      'CustomerClaim_Compensation_INFO_Introduction':
          instance.CustomerClaim_Compensation_INFO_Introduction,
      'CustomerClaim_Ticket_OysterCardInfo':
          instance.CustomerClaim_Ticket_OysterCardInfo,
      'CustomerClaim_Journey_INFO_Introduction':
          instance.CustomerClaim_Journey_INFO_Introduction,
      'CustomerClaim_Ticket_TOOLTIP_Ticket_Reference_2_FieldName':
          instance.CustomerClaim_Ticket_TOOLTIP_Ticket_Reference_2_FieldName,
      'TicketFoundUseForPreClaim': instance.TicketFoundUseForPreClaim,
      'CustomerClaim_Compensation_INFO_AmazonVoucher':
          instance.CustomerClaim_Compensation_INFO_AmazonVoucher,
      'CompensationAlert_PAYMPingIT': instance.CompensationAlert_PAYMPingIT,
      'ClaimSuccessSubmittedMessage': instance.ClaimSuccessSubmittedMessage,
      'MDRANewRegisterBenefit': instance.MDRANewRegisterBenefit,
      'CustomerClaim_Ticket_TOOLTIP_ticketimagefilefieldname':
          instance.CustomerClaim_Ticket_TOOLTIP_ticketimagefilefieldname,
      'CustomerClaim_Compensation_INFO_Charity':
          instance.CustomerClaim_Compensation_INFO_Charity,
      'errorTicketDetails': instance.errorTicketDetails,
      'CustomerClaim_Ticket_TOOLTIP_zipcodefieldname':
          instance.CustomerClaim_Ticket_TOOLTIP_zipcodefieldname,
      'CustomerClaimFormEndPara': instance.CustomerClaimFormEndPara,
      'TicketToolTip_NonBarcode_CollectionReference_Price':
          instance.TicketToolTip_NonBarcode_CollectionReference_Price,
      'CompensationAlert_BACS': instance.CompensationAlert_BACS,
      'CustomerClaim_Journey_TOOLTIP_to':
          instance.CustomerClaim_Journey_TOOLTIP_to,
      'CompensationAlert_RailTravelVoucher':
          instance.CompensationAlert_RailTravelVoucher,
      'ClaimSubmitErrorMessage': instance.ClaimSubmitErrorMessage,
      'CustomerClaim_Compensation_INFO_Argos':
          instance.CustomerClaim_Compensation_INFO_Argos,
      'Myaccount_Ticket_Tooltip_Type': instance.Myaccount_Ticket_Tooltip_Type,
      'CompensationAlert_PayPointeVoucher':
          instance.CompensationAlert_PayPointeVoucher,
      'CompensationPaymentByPaypoint': instance.CompensationPaymentByPaypoint,
      'Revp_APP_UFNCaseHTLabel': instance.Revp_APP_UFNCaseHTLabel,
      'TicketFoundNotUseOtherclaim': instance.TicketFoundNotUseOtherclaim,
      'CustomerClaim_Ticket_TOOLTIP_from':
          instance.CustomerClaim_Ticket_TOOLTIP_from,
      'CompensationPaymentByCheque': instance.CompensationPaymentByCheque,
      'Unpaid_Fair_Notice_Legal_Statement':
          instance.Unpaid_Fair_Notice_Legal_Statement,
      'RevpAPPAdditionalAdminFeeText': instance.RevpAPPAdditionalAdminFeeText,
      'TicketToolTip_NonBarcode_Paper_Reference':
          instance.TicketToolTip_NonBarcode_Paper_Reference,
      'MYACCOUTPASSWORDCRITERIYATOOL': instance.MYACCOUTPASSWORDCRITERIYATOOL,
      'CustomerClaim_Compensation_INFO_PAYMPINGIT':
          instance.CustomerClaim_Compensation_INFO_PAYMPINGIT,
      'CustomerClaim_Journey_TOOLTIP_from':
          instance.CustomerClaim_Journey_TOOLTIP_from,
      'CompensationPaymentByCreditCard_DetailsRequired':
          instance.CompensationPaymentByCreditCard_DetailsRequired,
      'customerClaimCompensationInfoAmazonCoUk':
          instance.customerClaimCompensationInfoAmazonCoUk,
      'AgentNotification_Test': instance.AgentNotification_Test,
      'Revp_APP_UFNCaseLabel': instance.Revp_APP_UFNCaseLabel,
      'ClaimDecisionApproved': instance.ClaimDecisionApproved,
      'CustomerMyaccount_Ticket_TOOLTIP_to':
          instance.CustomerMyaccount_Ticket_TOOLTIP_to,
      'TicketToolTip_NonBarcode_Smartcard_Price':
          instance.TicketToolTip_NonBarcode_Smartcard_Price,
      'CustomerClaim_Ticket_TOOLTIP_Cost':
          instance.CustomerClaim_Ticket_TOOLTIP_Cost,
      'CUSTOMERCLAIM_TICKET_TOOLTIP_TICKET_REFERENCE_2_FIELDNAME_MYACCOUNT':
          instance
              .CUSTOMERCLAIM_TICKET_TOOLTIP_TICKET_REFERENCE_2_FIELDNAME_MYACCOUNT,
      'TicketScannerAllowed': instance.TicketScannerAllowed,
      'TicketToolTip_Barcode_Price': instance.TicketToolTip_Barcode_Price,
      'TicketToolTip_NonBarcode_Paper_number':
          instance.TicketToolTip_NonBarcode_Paper_number,
      'CompensationAlert_Charity': instance.CompensationAlert_Charity,
      'GOGCommunicationPrivacyPolicyMessage':
          instance.GOGCommunicationPrivacyPolicyMessage,
      'errorTicketNotFound': instance.errorTicketNotFound,
      'CompensationAlert_OtherSlower': instance.CompensationAlert_OtherSlower,
      'ClaimSuccessUpdatedMessage': instance.ClaimSuccessUpdatedMessage,
      'CustomerClaim_Compensation_INFO_Credit_Debit_Card':
          instance.CustomerClaim_Compensation_INFO_Credit_Debit_Card,
      'TestTipDelete': instance.TestTipDelete,
      'CustomerClaim_Ticket_TOOLTIP_Ticket_Reference_1_FieldName':
          instance.CustomerClaim_Ticket_TOOLTIP_Ticket_Reference_1_FieldName,
      'CompensationPaymentByVoucher': instance.CompensationPaymentByVoucher,
      'MDRACheckRegisterPageTitle': instance.MDRACheckRegisterPageTitle,
      'InvaildTicketProvided': instance.InvaildTicketProvided,
      'CompensationAlert_Cheque': instance.CompensationAlert_Cheque,
      'MDRAHomeButtonCaption': instance.MDRAHomeButtonCaption,
      'CompensationPaymentByPAYM': instance.CompensationPaymentByPAYM,
      'CustomerClaimFormStartPara': instance.CustomerClaimFormStartPara,
      'errorTravelDATENotCurrentDate': instance.errorTravelDATENotCurrentDate,
      'CustomerClaim_Ticket_TOOLTIP_Type':
          instance.CustomerClaim_Ticket_TOOLTIP_Type,
      'ClaimDecisionRejection': instance.ClaimDecisionRejection,
      'CustomerClaim_OysterCard_TOOLTIP_from':
          instance.CustomerClaim_OysterCard_TOOLTIP_from,
      'CustomerClaim_Journey_ToolTip_Number_of_Changes_FieldName':
          instance.CustomerClaim_Journey_ToolTip_Number_of_Changes_FieldName,
      'TicketToolTip_NonBarcode_Paper_paymenttype':
          instance.TicketToolTip_NonBarcode_Paper_paymenttype,
      'CustomerClaim_Ticket_TOOLTIP_Ticket_TimeFieldName_REMOVE':
          instance.CustomerClaim_Ticket_TOOLTIP_Ticket_TimeFieldName_REMOVE,
      'Penalty_Fair_Notice_Legal_Statement':
          instance.Penalty_Fair_Notice_Legal_Statement,
      'successTicketDetailsOvernight': instance.successTicketDetailsOvernight,
      'CustomerClaim_Compensation_INFO_Thomas':
          instance.CustomerClaim_Compensation_INFO_Thomas,
      'TicketToolTip_Barcode_UTNNumber':
          instance.TicketToolTip_Barcode_UTNNumber,
      'CustomerClaim_Compensation_INFO_BACS':
          instance.CustomerClaim_Compensation_INFO_BACS,
      'CUSTOMERCLAIM_TICKET_TOOLTIP_TICKET_REFERENCE_1_FIELDNAME_MYACCOUNT':
          instance
              .CUSTOMERCLAIM_TICKET_TOOLTIP_TICKET_REFERENCE_1_FIELDNAME_MYACCOUNT,
      'TicketToolTip_NonBarcode_OtherContactless_Price':
          instance.TicketToolTip_NonBarcode_OtherContactless_Price,
      'CustomerClaim_Compensation_INFO_RailTravelVoucher':
          instance.CustomerClaim_Compensation_INFO_RailTravelVoucher,
      'CompensationAlert_CreditDebitCard':
          instance.CompensationAlert_CreditDebitCard,
      'CustomerClaim_Compensation_INFO_PayPal':
          instance.CustomerClaim_Compensation_INFO_PayPal,
      'CustomerPortalAlertMessage': instance.CustomerPortalAlertMessage,
      'CompensationPaymentByCharity': instance.CompensationPaymentByCharity,
      'CustomerClaim_Personal_INFO_Remember_My_Details':
          instance.CustomerClaim_Personal_INFO_Remember_My_Details,
      'CustomerClaim_Compensation_INFO_Cheque':
          instance.CustomerClaim_Compensation_INFO_Cheque,
      'CompensationAlert_AmazoncoukGiftCard':
          instance.CompensationAlert_AmazoncoukGiftCard,
      'CompensationAlert_BankAccount': instance.CompensationAlert_BankAccount,
      'CustomerClaim_Ticket_TOOLTIP_Ticket_Image':
          instance.CustomerClaim_Ticket_TOOLTIP_Ticket_Image,
      'Smartcard_Approval_Warning': instance.Smartcard_Approval_Warning,
      'CustomerClaim_Journey_INFO_delayTypeLength':
          instance.CustomerClaim_Journey_INFO_delayTypeLength,
      'MultiLegV2AmendDesscription': instance.MultiLegV2AmendDesscription,
      'Revp_CP_AppealIntructionText2': instance.Revp_CP_AppealIntructionText2,
      'Warning_NoTicket_NotDefaced': instance.Warning_NoTicket_NotDefaced,
      'testTestUpdate': instance.testTestUpdate,
      'CompensationAlert_ThomasCookVoucher':
          instance.CompensationAlert_ThomasCookVoucher,
      'PTTCommunicationPrivacyPolicyMessage':
          instance.PTTCommunicationPrivacyPolicyMessage,
      'ClaimAlreadySubmittedMessage': instance.ClaimAlreadySubmittedMessage,
      'MultiLegV2MultipleLegFound': instance.MultiLegV2MultipleLegFound,
      'GOGwelcomeTxt': instance.GOGwelcomeTxt,
      'Fraud_placeholder': instance.Fraud_placeholder,
    };
