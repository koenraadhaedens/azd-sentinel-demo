param name string
param location string
param sku string
param tags object



resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2017-03-15-preview' = {
  name: name
  location: location
  tags: tags
  properties: {
    sku: {
      name: sku
    }
  }
}

// Outputs to be used in main.bicep
output workspaceId string = logAnalyticsWorkspace.id
output workspaceName string = logAnalyticsWorkspace.name
