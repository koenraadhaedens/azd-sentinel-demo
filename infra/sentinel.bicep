param location string
param workspaceName string

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: workspaceName // same as the Log Analytics workspace
  location: location
  sku: {
    name: sku
  }
  properties: {
    retentionInDays: 30
  }
}

resource sentinel 'Microsoft.SecurityInsights/workspaces@2022-12-01-preview' = {
  name: workspaceName // same as the Log Analytics workspace
  location: location
  properties: {}
}

// Outputs to be used in main.bicep
output workspaceId string = logAnalytics.id
output workspaceName string = logAnalytics.name
