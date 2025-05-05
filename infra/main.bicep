param location string = resourceGroup().location
param logAnalyticsWorkspaceName string = 'law-${uniqueString(resourceGroup().id)}'

module logAnalyticsModule 'sentinel.bicep' = {
  name: 'logAnalyticsDeployment'
  params: {
    location: location
    workspaceName: logAnalyticsWorkspaceName
  }
}
