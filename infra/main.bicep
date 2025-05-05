targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Name of the environment that can be used as part of naming resource convention')
param environmentName string
@minLength(1)
@description('Primary location for all resources')
param location string

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'rg-${environmentName}'
  location: location
}

param logAnalyticsWorkspaceName string = 'law-${uniqueString(environmentName)}'


module logAnalyticsModule 'sentinel.bicep' = {
  name: 'logAnalyticsDeployment'
  params: {
    location: location
    workspaceName: logAnalyticsWorkspaceName
  }
  scope: rg
}

module bruteForceRule 'brute-force-rule.bicep' = {
  name: 'BruteForceDetectionRule'
  params: {
    workspaceName: logAnalyticsWorkspaceName
    location: location
  }
  scope: rg
}

output workspaceId string = logAnalyticsModule.outputs.workspaceId
