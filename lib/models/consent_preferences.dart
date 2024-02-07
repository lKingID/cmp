library opencmp;

class ConsentPreferences {
  final int cmpSdkId;
  final int cmpSdkVersion;
  final int policyVersion;
  final int gdprApplies;
  final String publisherCc;
  final int useNonStandardStacks;
  final String vendorConsents;
  final String vendorLegitimateInterests;
  final String purposeConsents;
  final String purposeLegitimateInterests;
  final String specialFeaturesOptIns;
  final String publisherConsent;
  final String publisherLegitimateInterests;
  final String publisherCustomPurposesConsents;
  final String publisherCustomPurposesLegitimateInterests;
  final String customVendorConsents;
  final String customVendorLegitimateInterests;

  ConsentPreferences(
      this.cmpSdkId,
      this.cmpSdkVersion,
      this.policyVersion,
      this.gdprApplies,
      this.publisherCc,
      this.useNonStandardStacks,
      this.vendorConsents,
      this.vendorLegitimateInterests,
      this.purposeConsents,
      this.purposeLegitimateInterests,
      this.specialFeaturesOptIns,
      this.publisherConsent,
      this.publisherLegitimateInterests,
      this.publisherCustomPurposesConsents,
      this.publisherCustomPurposesLegitimateInterests,
      this.customVendorConsents,
      this.customVendorLegitimateInterests,);

  ConsentPreferences.fromJson(Map<String, dynamic> json)
      : cmpSdkId = json['IABTCF_CmpSdkID'],
        cmpSdkVersion = json['IABTCF_CmpSdkVersion'],
        policyVersion = json['IABTCF_PolicyVersion'],
        gdprApplies = json['IABTCF_gdprApplies'],
        publisherCc = json['IABTCF_PublisherCC'],
        useNonStandardStacks = json['IABTCF_UseNonStandardStacks'],
        vendorConsents = json['IABTCF_VendorConsents'],
        vendorLegitimateInterests = json['IABTCF_VendorLegitimateInterests'],
        purposeConsents = json['IABTCF_PurposeConsents'],
        purposeLegitimateInterests = json['IABTCF_PurposeLegitimateInterests'],
        specialFeaturesOptIns = json['IABTCF_SpecialFeaturesOptIns'],
        publisherConsent = json['IABTCF_PublisherConsent'],
        publisherLegitimateInterests =
            json['IABTCF_PublisherLegitimateInterests'],
        publisherCustomPurposesConsents =
            json['IABTCF_PublisherCustomPurposesConsents'],
        publisherCustomPurposesLegitimateInterests =
            json['IABTCF_PublisherCustomPurposesLegitimateInterests'],
        customVendorConsents = json['IABTCF_CustomVendorConsents'],
        customVendorLegitimateInterests =
            json['IABTCF_CustomVendorLegitimateInterests'];

  Map<String, dynamic> toJson() => {
        'IABTCF_CmpSdkID': cmpSdkId,
        'IABTCF_CmpSdkVersion': cmpSdkVersion,
        'IABTCF_PolicyVersion': policyVersion,
        'IABTCF_gdprApplies': gdprApplies,
        'IABTCF_PublisherCC': publisherCc,
        'IABTCF_UseNonStandardStacks': useNonStandardStacks,
        'IABTCF_VendorConsents': vendorConsents,
        'IABTCF_VendorLegitimateInterests': vendorLegitimateInterests,
        'IABTCF_PurposeConsents': purposeConsents,
        'IABTCF_PurposeLegitimateInterests': purposeLegitimateInterests,
        'IABTCF_SpecialFeaturesOptIns': specialFeaturesOptIns,
        'IABTCF_PublisherConsent': publisherConsent,
        'IABTCF_PublisherLegitimateInterests': publisherLegitimateInterests,
        'IABTCF_PublisherCustomPurposesConsents':
            publisherCustomPurposesConsents,
        'IABTCF_PublisherCustomPurposesLegitimateInterests':
            publisherCustomPurposesLegitimateInterests,
        'IABTCF_CustomVendorConsents': customVendorConsents,
        'IABTCF_CustomVendorLegitimateInterests':
            customVendorLegitimateInterests,
      };
}
