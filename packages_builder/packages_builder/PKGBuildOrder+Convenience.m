
#import "PKGBuildOrder+Convenience.h"

@implementation PKGBuildOrder (Convenience)

- (NSString *)referenceProjectFolderPath
{
	return self.externalSettings[PKGBuildOrderExternalSettingsReferenceProjectFolderKey];
}

- (NSString *)referenceFolderPath
{
	return self.externalSettings[PKGBuildOrderExternalSettingsReferenceFolderKey];
}

- (NSString *)scratchFolderPath
{
	return self.externalSettings[PKGBuildOrderExternalSettingsScratchFolderKey];
}

- (NSDictionary *)userDefinedSettings
{
	return self.externalSettings[PKGBuildOrderExternalSettingsUserDefinedSettingsKey];
}

- (id)userDefinedSettingsForKey:(NSString *)inKey
{
	if (inKey==nil)
		return nil;
	
	return self.externalSettings[inKey];
}

@end
