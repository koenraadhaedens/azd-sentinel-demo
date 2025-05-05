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

// Outputs to be used in main.bicep
output workspaceId string = logAnalyticsWorkspace.id

// Enable Microsoft Sentinel on the workspace
resource sentinel 'Microsoft.SecurityInsights/workspaces@2022-12-01-preview' = {
  name: workspaceName  // Must match Log Analytics workspace name
  location: location
  properties: {}
  dependsOn: [
    logAnalyticsWorkspace
  ]
}
