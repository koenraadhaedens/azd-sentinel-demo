param location string
param workspaceName string

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: workspaceName
  location: location
  sku: {
    name: 'PerGB2018'
  }
  properties: {
    retentionInDays: 30
  }
}

resource sentinel 'Microsoft.SecurityInsights/OnboardingStates@2022-12-01-preview' = {
  name: 'default'
  scope: logAnalytics
  properties: {
    onboardingState: 'Onboarded'
  }
}
