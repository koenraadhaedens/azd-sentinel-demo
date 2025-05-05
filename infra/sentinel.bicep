param workspaceName string
param location string
param sku string = 'PerGB2018'



resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2017-03-15-preview' = {
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
