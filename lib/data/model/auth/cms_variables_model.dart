import 'package:json_annotation/json_annotation.dart';

part 'cms_variables_model.g.dart';

@JsonSerializable()
class CmsVariablesModel {
  num? STATUS;
  CMSVARIABLESBean? CMSVARIABLES;

  CmsVariablesModel({this.STATUS, this.CMSVARIABLES});

  factory CmsVariablesModel.fromJson(Map<String, dynamic> json) =>
      _$CmsVariablesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CmsVariablesModelToJson(this);
}

@JsonSerializable()
class CMSVARIABLESBean {
  String? intelligenceReportConfirmationMessage;
  String? IS_SSO_LOGIN;
  String? CustomerClaim_Ticket_INFO_Introduction;
  String? Revp_APP_PFCaseLabel;
  String? Revp_CP_ReferenceTooltip;
  String? WithInDaysMessage;
  String? CompensationAlert_PayPal;
  String? TicketScannerDenied;
  String? CustomerClaim_Compensation_INFO_Check;
  String? TcsCmsVaribleResetapp;
  String? CustomerClaim_Ticket_ticketimage_googleDrive;
  String? CompensationAlert_CashableVoucher;
  String? GOG_EnvironamentIndication;
  String? GOGLinkNotFoundMessage;
  String? CustomerSmartCard_Validation_Incorrect;
  String? CustomerMyaccount_Ticket_TOOLTIP_from;
  String? TicketToolTip_NonBarcode_Paper_Price;
  String? CustomerClaim_Personal_INFO_Introduction_REMOVE;
  String? CP_MyAccountPromotion;
  String? CUSTOMERSMARTCARD_VALIDATION_INFO;
  String? CompensationPaymentByCreditCard_DetailsOnRecord;
  String? CompensationPaymentByCreditCard_DetailsExpired;
  String? CompensationAlert_ArgosVoucher;
  String? MYACCOUTPASSWORDCRITERIYATOOLTIP;
  String? CustomerClaim_Ticket_INFO_ReferenceNumbers;
  String? CustomerClaim_Ticket_TOOLTIP_to;
  String? CustomerFeedback;
  String? CompensationPaymentByPaypal;
  String? CustomerClaim_Journey_INFO_MultiplePassengers;
  String? BenifitsMessage;
  String? CompensationAlert_SeasonDirect;
  String? CompensationAlert_Voucher;
  String? Revp_CP_underAppealIntructionText;
  String? smsCpTemplate;
  String? TicketToolTip_NonBarcode_CollectionReference_CTR;
  String? CompensationAlert_CashVoucher;
  String? AbandonedJourneyRedirectContent;
  String? CustomerClaim_Compensation_INFO_Introduction;
  String? CustomerClaim_Ticket_OysterCardInfo;
  String? CustomerClaim_Journey_INFO_Introduction;
  String? CustomerClaim_Ticket_TOOLTIP_Ticket_Reference_2_FieldName;
  String? TicketFoundUseForPreClaim;
  String? CustomerClaim_Compensation_INFO_AmazonVoucher;
  String? CompensationAlert_PAYMPingIT;
  String? ClaimSuccessSubmittedMessage;
  String? MDRANewRegisterBenefit;
  String? CustomerClaim_Ticket_TOOLTIP_ticketimagefilefieldname;
  String? CustomerClaim_Compensation_INFO_Charity;
  String? errorTicketDetails;
  String? CustomerClaim_Ticket_TOOLTIP_zipcodefieldname;
  String? CustomerClaimFormEndPara;
  String? TicketToolTip_NonBarcode_CollectionReference_Price;
  String? CompensationAlert_BACS;
  String? CustomerClaim_Journey_TOOLTIP_to;
  String? CompensationAlert_RailTravelVoucher;
  String? ClaimSubmitErrorMessage;
  String? CustomerClaim_Compensation_INFO_Argos;
  String? Myaccount_Ticket_Tooltip_Type;
  String? CompensationAlert_PayPointeVoucher;
  String? CompensationPaymentByPaypoint;
  String? Revp_APP_UFNCaseHTLabel;
  String? TicketFoundNotUseOtherclaim;
  String? CustomerClaim_Ticket_TOOLTIP_from;
  String? CompensationPaymentByCheque;
  dynamic Unpaid_Fair_Notice_Legal_Statement;
  String? RevpAPPAdditionalAdminFeeText;
  String? TicketToolTip_NonBarcode_Paper_Reference;
  String? MYACCOUTPASSWORDCRITERIYATOOL;
  String? CustomerClaim_Compensation_INFO_PAYMPINGIT;
  String? CustomerClaim_Journey_TOOLTIP_from;
  String? CompensationPaymentByCreditCard_DetailsRequired;

  dynamic customerClaimCompensationInfoAmazonCoUk;

  String? AgentNotification_Test;
  String? Revp_APP_UFNCaseLabel;
  String? ClaimDecisionApproved;
  String? CustomerMyaccount_Ticket_TOOLTIP_to;
  String? TicketToolTip_NonBarcode_Smartcard_Price;
  String? CustomerClaim_Ticket_TOOLTIP_Cost;
  String? CUSTOMERCLAIM_TICKET_TOOLTIP_TICKET_REFERENCE_2_FIELDNAME_MYACCOUNT;
  String? TicketScannerAllowed;
  String? TicketToolTip_Barcode_Price;
  String? TicketToolTip_NonBarcode_Paper_number;
  String? CompensationAlert_Charity;
  String? GOGCommunicationPrivacyPolicyMessage;
  String? errorTicketNotFound;
  String? CompensationAlert_OtherSlower;
  String? ClaimSuccessUpdatedMessage;
  String? CustomerClaim_Compensation_INFO_Credit_Debit_Card;
  String? TestTipDelete;
  String? CustomerClaim_Ticket_TOOLTIP_Ticket_Reference_1_FieldName;
  String? CompensationPaymentByVoucher;
  String? MDRACheckRegisterPageTitle;
  String? InvaildTicketProvided;
  String? CompensationAlert_Cheque;
  String? MDRAHomeButtonCaption;
  String? CompensationPaymentByPAYM;
  String? CustomerClaimFormStartPara;
  String? errorTravelDATENotCurrentDate;
  String? CustomerClaim_Ticket_TOOLTIP_Type;
  String? ClaimDecisionRejection;
  String? CustomerClaim_OysterCard_TOOLTIP_from;
  String? CustomerClaim_Journey_ToolTip_Number_of_Changes_FieldName;
  String? TicketToolTip_NonBarcode_Paper_paymenttype;
  String? CustomerClaim_Ticket_TOOLTIP_Ticket_TimeFieldName_REMOVE;
  dynamic Penalty_Fair_Notice_Legal_Statement;
  String? successTicketDetailsOvernight;
  String? CustomerClaim_Compensation_INFO_Thomas;
  String? TicketToolTip_Barcode_UTNNumber;
  String? CustomerClaim_Compensation_INFO_BACS;
  String? CUSTOMERCLAIM_TICKET_TOOLTIP_TICKET_REFERENCE_1_FIELDNAME_MYACCOUNT;
  String? TicketToolTip_NonBarcode_OtherContactless_Price;
  String? CustomerClaim_Compensation_INFO_RailTravelVoucher;
  String? CompensationAlert_CreditDebitCard;
  String? CustomerClaim_Compensation_INFO_PayPal;
  String? CustomerPortalAlertMessage;
  String? CompensationPaymentByCharity;
  String? CustomerClaim_Personal_INFO_Remember_My_Details;
  String? CustomerClaim_Compensation_INFO_Cheque;
  String? CompensationAlert_AmazoncoukGiftCard;
  String? CompensationAlert_BankAccount;
  String? CustomerClaim_Ticket_TOOLTIP_Ticket_Image;
  String? Smartcard_Approval_Warning;
  String? CustomerClaim_Journey_INFO_delayTypeLength;
  String? MultiLegV2AmendDesscription;
  String? Revp_CP_AppealIntructionText2;
  String? Warning_NoTicket_NotDefaced;

  dynamic testTestUpdate;

  String? CompensationAlert_ThomasCookVoucher;
  String? PTTCommunicationPrivacyPolicyMessage;
  String? ClaimAlreadySubmittedMessage;
  String? MultiLegV2MultipleLegFound;
  String? GOGwelcomeTxt;
  String? Fraud_placeholder;

  CMSVARIABLESBean(
      {this.intelligenceReportConfirmationMessage,
      this.IS_SSO_LOGIN,
      this.CustomerClaim_Ticket_INFO_Introduction,
      this.Revp_APP_PFCaseLabel,
      this.Revp_CP_ReferenceTooltip,
      this.WithInDaysMessage,
      this.CompensationAlert_PayPal,
      this.TicketScannerDenied,
      this.CustomerClaim_Compensation_INFO_Check,
      this.TcsCmsVaribleResetapp,
      this.CustomerClaim_Ticket_ticketimage_googleDrive,
      this.CompensationAlert_CashableVoucher,
      this.GOG_EnvironamentIndication,
      this.GOGLinkNotFoundMessage,
      this.CustomerSmartCard_Validation_Incorrect,
      this.CustomerMyaccount_Ticket_TOOLTIP_from,
      this.TicketToolTip_NonBarcode_Paper_Price,
      this.CustomerClaim_Personal_INFO_Introduction_REMOVE,
      this.CP_MyAccountPromotion,
      this.CUSTOMERSMARTCARD_VALIDATION_INFO,
      this.CompensationPaymentByCreditCard_DetailsOnRecord,
      this.CompensationPaymentByCreditCard_DetailsExpired,
      this.CompensationAlert_ArgosVoucher,
      this.MYACCOUTPASSWORDCRITERIYATOOLTIP,
      this.CustomerClaim_Ticket_INFO_ReferenceNumbers,
      this.CustomerClaim_Ticket_TOOLTIP_to,
      this.CustomerFeedback,
      this.CompensationPaymentByPaypal,
      this.CustomerClaim_Journey_INFO_MultiplePassengers,
      this.BenifitsMessage,
      this.CompensationAlert_SeasonDirect,
      this.CompensationAlert_Voucher,
      this.Revp_CP_underAppealIntructionText,
      this.smsCpTemplate,
      this.TicketToolTip_NonBarcode_CollectionReference_CTR,
      this.CompensationAlert_CashVoucher,
      this.AbandonedJourneyRedirectContent,
      this.CustomerClaim_Compensation_INFO_Introduction,
      this.CustomerClaim_Ticket_OysterCardInfo,
      this.CustomerClaim_Journey_INFO_Introduction,
      this.CustomerClaim_Ticket_TOOLTIP_Ticket_Reference_2_FieldName,
      this.TicketFoundUseForPreClaim,
      this.CustomerClaim_Compensation_INFO_AmazonVoucher,
      this.CompensationAlert_PAYMPingIT,
      this.ClaimSuccessSubmittedMessage,
      this.MDRANewRegisterBenefit,
      this.CustomerClaim_Ticket_TOOLTIP_ticketimagefilefieldname,
      this.CustomerClaim_Compensation_INFO_Charity,
      this.errorTicketDetails,
      this.CustomerClaim_Ticket_TOOLTIP_zipcodefieldname,
      this.CustomerClaimFormEndPara,
      this.TicketToolTip_NonBarcode_CollectionReference_Price,
      this.CompensationAlert_BACS,
      this.CustomerClaim_Journey_TOOLTIP_to,
      this.CompensationAlert_RailTravelVoucher,
      this.ClaimSubmitErrorMessage,
      this.CustomerClaim_Compensation_INFO_Argos,
      this.Myaccount_Ticket_Tooltip_Type,
      this.CompensationAlert_PayPointeVoucher,
      this.CompensationPaymentByPaypoint,
      this.Revp_APP_UFNCaseHTLabel,
      this.TicketFoundNotUseOtherclaim,
      this.CustomerClaim_Ticket_TOOLTIP_from,
      this.CompensationPaymentByCheque,
      this.Unpaid_Fair_Notice_Legal_Statement,
      this.RevpAPPAdditionalAdminFeeText,
      this.TicketToolTip_NonBarcode_Paper_Reference,
      this.MYACCOUTPASSWORDCRITERIYATOOL,
      this.CustomerClaim_Compensation_INFO_PAYMPINGIT,
      this.CustomerClaim_Journey_TOOLTIP_from,
      this.CompensationPaymentByCreditCard_DetailsRequired,
      this.customerClaimCompensationInfoAmazonCoUk,
      this.AgentNotification_Test,
      this.Revp_APP_UFNCaseLabel,
      this.ClaimDecisionApproved,
      this.CustomerMyaccount_Ticket_TOOLTIP_to,
      this.TicketToolTip_NonBarcode_Smartcard_Price,
      this.CustomerClaim_Ticket_TOOLTIP_Cost,
      this.CUSTOMERCLAIM_TICKET_TOOLTIP_TICKET_REFERENCE_2_FIELDNAME_MYACCOUNT,
      this.TicketScannerAllowed,
      this.TicketToolTip_Barcode_Price,
      this.TicketToolTip_NonBarcode_Paper_number,
      this.CompensationAlert_Charity,
      this.GOGCommunicationPrivacyPolicyMessage,
      this.errorTicketNotFound,
      this.CompensationAlert_OtherSlower,
      this.ClaimSuccessUpdatedMessage,
      this.CustomerClaim_Compensation_INFO_Credit_Debit_Card,
      this.TestTipDelete,
      this.CustomerClaim_Ticket_TOOLTIP_Ticket_Reference_1_FieldName,
      this.CompensationPaymentByVoucher,
      this.MDRACheckRegisterPageTitle,
      this.InvaildTicketProvided,
      this.CompensationAlert_Cheque,
      this.MDRAHomeButtonCaption,
      this.CompensationPaymentByPAYM,
      this.CustomerClaimFormStartPara,
      this.errorTravelDATENotCurrentDate,
      this.CustomerClaim_Ticket_TOOLTIP_Type,
      this.ClaimDecisionRejection,
      this.CustomerClaim_OysterCard_TOOLTIP_from,
      this.CustomerClaim_Journey_ToolTip_Number_of_Changes_FieldName,
      this.TicketToolTip_NonBarcode_Paper_paymenttype,
      this.CustomerClaim_Ticket_TOOLTIP_Ticket_TimeFieldName_REMOVE,
      this.Penalty_Fair_Notice_Legal_Statement,
      this.successTicketDetailsOvernight,
      this.CustomerClaim_Compensation_INFO_Thomas,
      this.TicketToolTip_Barcode_UTNNumber,
      this.CustomerClaim_Compensation_INFO_BACS,
      this.CUSTOMERCLAIM_TICKET_TOOLTIP_TICKET_REFERENCE_1_FIELDNAME_MYACCOUNT,
      this.TicketToolTip_NonBarcode_OtherContactless_Price,
      this.CustomerClaim_Compensation_INFO_RailTravelVoucher,
      this.CompensationAlert_CreditDebitCard,
      this.CustomerClaim_Compensation_INFO_PayPal,
      this.CustomerPortalAlertMessage,
      this.CompensationPaymentByCharity,
      this.CustomerClaim_Personal_INFO_Remember_My_Details,
      this.CustomerClaim_Compensation_INFO_Cheque,
      this.CompensationAlert_AmazoncoukGiftCard,
      this.CompensationAlert_BankAccount,
      this.CustomerClaim_Ticket_TOOLTIP_Ticket_Image,
      this.Smartcard_Approval_Warning,
      this.CustomerClaim_Journey_INFO_delayTypeLength,
      this.MultiLegV2AmendDesscription,
      this.Revp_CP_AppealIntructionText2,
      this.Warning_NoTicket_NotDefaced,
      this.testTestUpdate,
      this.CompensationAlert_ThomasCookVoucher,
      this.PTTCommunicationPrivacyPolicyMessage,
      this.ClaimAlreadySubmittedMessage,
      this.MultiLegV2MultipleLegFound,
      this.GOGwelcomeTxt,
      this.Fraud_placeholder});

  factory CMSVARIABLESBean.fromJson(Map<String, dynamic> json) =>
      _$CMSVARIABLESBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CMSVARIABLESBeanToJson(this);
}
