param workspaceName string

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' existing = {
  name: workspaceName
}

resource analyticRule 'Microsoft.SecurityInsights/alertRules@2023-02-01-preview' = {
  name: 'BruteForceDetection'
  scope: logAnalyticsWorkspace
  kind: 'Scheduled'
  properties: {
    displayName: 'Brute Force Attack Detection'
    description: 'Detects multiple failed login attempts for the same account within a short time window'
    enabled: true
    query: '''
      SecurityEvent
      | where EventID == 4625
      | where AccountType == "User"
      | summarize FailedAttempts = count() by TargetAccount, bin(TimeGenerated, 5m)
      | where FailedAttempts > 5
    '''
    queryFrequency: 'PT5M'
    queryPeriod: 'PT5M'
    severity: 'Medium'
    triggerOperator: 'GreaterThan'
    triggerThreshold: 0
    tactics: [
      'CredentialAccess'
      'InitialAccess'
    ]
    incidentConfiguration: {
      createIncident: true
      groupingConfiguration: {
        enabled: true
        reopenClosedIncident: false
        lookbackDuration: 'PT1H'
        matchingMethod: 'Selected'
        groupByEntities: ['Account']
      }
    }
    customDetails: {
      FailedAttempts: 'FailedAttempts'
    }
    suppressionDuration: 'PT1H'
    suppressionEnabled: false
  }
}
