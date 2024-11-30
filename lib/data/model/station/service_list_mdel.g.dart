// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_list_mdel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceListMdel _$ServiceListMdelFromJson(Map<String, dynamic> json) =>
    ServiceListMdel(
      STSESSION: json['STSESSION'] == null
          ? null
          : STSESSIONBean.fromJson(json['STSESSION'] as Map<String, dynamic>),
      ENDSTATION: json['ENDSTATION'] as String?,
      STARTSTATION: json['STARTSTATION'] as String?,
      STATUS: json['STATUS'] as num?,
      RECORDCOUNT: json['RECORDCOUNT'] as num?,
      ASERVICELIST: (json['ASERVICELIST'] as List<dynamic>?)
          ?.map((e) => ASERVICELISTBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceListMdelToJson(ServiceListMdel instance) =>
    <String, dynamic>{
      'STSESSION': instance.STSESSION,
      'ENDSTATION': instance.ENDSTATION,
      'STARTSTATION': instance.STARTSTATION,
      'STATUS': instance.STATUS,
      'RECORDCOUNT': instance.RECORDCOUNT,
      'ASERVICELIST': instance.ASERVICELIST,
    };

ASERVICELISTBean _$ASERVICELISTBeanFromJson(Map<String, dynamic> json) =>
    ASERVICELISTBean(
      DIFFERENCE: json['DIFFERENCE'] as num?,
      SIGNEDDIFFERENCE: json['SIGNEDDIFFERENCE'] as num?,
      AET: json['AET'] as String?,
      NOW: json['NOW'] as String?,
      TRAINIDENTITY: json['TRAINIDENTITY'] as String?,
      AAT: json['AAT'] as String?,
      FUTURETRAIN: json['FUTURETRAIN'] as num?,
      RID: json['RID'] as String?,
      DET: json['DET'] as String?,
      PTD: json['PTD'] as String?,
      SERVICEID: json['SERVICEID'] as String?,
      SERVICEDATE: json['SERVICEDATE'] as String?,
      DAT: json['DAT'] as String?,
      TOC: json['TOC'] as String?,
      PTA: json['PTA'] as String?,
    );

Map<String, dynamic> _$ASERVICELISTBeanToJson(ASERVICELISTBean instance) =>
    <String, dynamic>{
      'DIFFERENCE': instance.DIFFERENCE,
      'SIGNEDDIFFERENCE': instance.SIGNEDDIFFERENCE,
      'AET': instance.AET,
      'NOW': instance.NOW,
      'TRAINIDENTITY': instance.TRAINIDENTITY,
      'AAT': instance.AAT,
      'FUTURETRAIN': instance.FUTURETRAIN,
      'RID': instance.RID,
      'DET': instance.DET,
      'PTD': instance.PTD,
      'SERVICEID': instance.SERVICEID,
      'SERVICEDATE': instance.SERVICEDATE,
      'DAT': instance.DAT,
      'TOC': instance.TOC,
      'PTA': instance.PTA,
    };

STSESSIONBean _$STSESSIONBeanFromJson(Map<String, dynamic> json) =>
    STSESSIONBean(
      SSESSIONID: json['SSESSIONID'] as String?,
      SSESSIONTYPE: json['SSESSIONTYPE'] as String?,
    );

Map<String, dynamic> _$STSESSIONBeanToJson(STSESSIONBean instance) =>
    <String, dynamic>{
      'SSESSIONID': instance.SSESSIONID,
      'SSESSIONTYPE': instance.SSESSIONTYPE,
    };
