param location string
param workspaceName string

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2023-10-01-preview' = {
  name: workspaceName
  location: location
  properties: {
    retentionInDays: 30
    features: {
      legacy: 0
    }
  }
  sku: {
    name: 'PerGB2018'
  }
}

resource sentinel 'Microsoft.SecurityInsights/workspaces@2022-12-01-preview' = {
  name: logAnalytics.name
  location: location
  properties: {}
}
