# Operations

## Repositories
https://github.com/orgs/REMLA24-TEAM-15/repositories

## Get started quick




## URL App Helm Chart
A helm chart has been made to deploy the URL app and model deployments. The app of a particular helm chart installation can communicated with the corresponding model deployment only - this is by design.

For experimenting new models (Continous experimentation), the URL to a different ML model (Release.joblib) file can be supplied.

The path to the model can be specified in url.mlModel.url in the values.yaml file. Illustrated in [testing-one](https://github.com/REMLA24-TEAM-15/Operation/blob/main/kubernetes/charts/testing-one-values.yaml) and [testing-two](https://github.com/REMLA24-TEAM-15/Operation/blob/main/kubernetes/charts/testing-two-values.yaml)

## Vagrant provisioning
