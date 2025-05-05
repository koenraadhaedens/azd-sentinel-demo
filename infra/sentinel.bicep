param location string
param workspaceName string

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
output workspaceId string = logAnalytics.id
output workspaceName string = logAnalytics.name
