# Incident Orchestrator Demo

This demo shows how to use Flow Orchestrator to create an Incident Response Plan.

## Installation Instructions

Get your own private clone of this demo in a 30-day scratch org by [CLICKING HERE](https://hosted-scratch.herokuapp.com/launch?template=https://github.com/SFDC-Assets/incident-orchestrator-demo&email=required).

Or manually clone this demo using the instructions below.

1. Clone the repository:

```
git clone https://github.com/SFDC-Assets/incident-orchestrator-demo
cd incident-orchestrator-demo
```

2. Install **shane-sfdx-plugins** (if you don't already have it)

  ```
  sfdx plugins:install shane-sfdx-plugins
  ```

3. Install **sfdx-migration-automatic** (if you don't already have it)

  ```
  sfdx plugins:install sfdx-migration-automatic
  ```


4. Run the startup script

  ```
  sh orgInit.sh
  ```