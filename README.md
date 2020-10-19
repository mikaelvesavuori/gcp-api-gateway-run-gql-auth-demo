# Demo: GCP API Gateway fronting a GraphQL API on Cloud Run, secured with Identity-Aware Proxy

This demo is based on the [official Google quickstart for API Gateway fronting a Cloud Run instance](https://cloud.google.com/api-gateway/docs/get-started-cloud-run). Lovingly repurposed from Google with <3 for the benefit of all.

The application itself is based on previous work on [cloud-run-ts-apollo-graphql](https://github.com/mikaelvesavuori/cloud-run-ts-apollo-graphql).

The example app is a GraphQL server (Apollo Server 2) that responds to the typical `/graphql` endpoint, which is also exposed in the API specification (`api-spec.yaml`).

## Prerequisites

- You have a GCP account
- You are logged in through your environment
- You have set your variables as needed in `setup.sh`

## Instructions

- Run `deploy-app.sh` to deploy your basic demo application to Cloud Run
- Set `x-google-backend.address` in `api-spec.yaml` to your Cloud Run endpoint (looks similar to `https://PROJECT_AND_RANDOM_STRING.a.run.app/graphql`)
- Refer to [https://cloud.google.com/iap/docs/app-engine-quickstart#enabling_iap](https://cloud.google.com/iap/docs/app-engine-quickstart#enabling_iap) for how to enable IAP. Copy the IAP client ID and set it in `x-google-backend.address.jwt_audience` in `api-spec.yaml`.
- Go to [IAP](https://console.cloud.google.com/security/iap) and set up your consent screen if it's not done above. You will most likely use the "External" option. Add a few users (like yourself) that should be granted access. Enable IAP for the web service.
- Run `setup.sh` to login, update your `gcloud` CLI tool and enable required APIs, and then finally deploy the API resources.
- Visit the application URL. Any requests from an accepted user should go through and the rest should be blocked.

## Running locally

### Compile and run

Install dependencies, then run `npm start` to use `ts-node` to run your code.

## References

- [Getting started with API Gateway and Cloud Run](https://cloud.google.com/api-gateway/docs/get-started-cloud-run)
- [Quickstart: Manage access with Google Accounts](https://cloud.google.com/iap/docs/app-engine-quickstart#enabling_iap)
- [gcloud services](https://cloud.google.com/sdk/gcloud/reference/services)
- [Swagger / OpenAPI Specification version 2](https://swagger.io/docs/specification/2-0/basic-structure/)
