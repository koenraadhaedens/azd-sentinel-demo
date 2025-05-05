param workspaceName string
param location string
param sku string = 'PerGB2018'



resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: workspaceName
  location: location
  properties: {
    sku: {
      name: sku
    }
  }
}


// Enable Microsoft Sentinel on the workspace
resource sentinelOnboarding 'Microsoft.SecurityInsights/onboardingStates@2022-01-01-preview' = {
  name: 'default'
  scope: logAnalyticsWorkspace
  properties: {} // no onboardingState property anymore
}


// Outputs to be used in main.bicep
output workspaceId string = logAnalyticsWorkspace.id

