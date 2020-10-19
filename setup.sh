# Basic GCP settings
PROJECT_ID="my-project"
REGION="europe-west1" # Allowed values for API Gateway (beta): asia-east1, europe-west1, us-central1

# Cloud Run
SERVICE_NAME="gql-api"
IMAGE="gcr.io/$PROJECT_ID/$SERVICE_NAME"

# IAM service account for API Gateway
SERVICE_ACCOUNT_NAME="serviceaccount-demo-api"

# API Gateway
GATEWAY_ID="demo-gateway"
API_ID="demo-api"
CONFIG_ID="demo-config"

# Login, update, enable APIs
gcloud auth login
gcloud components update
gcloud services enable run.googleapis.com
gcloud services enable apigateway.googleapis.com
gcloud services enable servicemanagement.googleapis.com
gcloud services enable servicecontrol.googleapis.com
gcloud services enable iap.googleapis.com

# Create service account
gcloud iam service-accounts create $SERVICE_ACCOUNT_NAME \
  --description="IAP Demo Service Account" \
  --display-name "IAP Demo Service Account"

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/iap.admin"

# Reference: https://cloud.google.com/api-gateway/docs/get-started-cloud-run
# Create API configuration
gcloud beta api-gateway api-configs create $CONFIG_ID \
  --api=$API_ID \
  --openapi-spec=api-spec.yaml \
  --project=$PROJECT_ID \
  --backend-auth-service-account=$SERVICE_ACCOUNT_EMAIL

# Verify API config
gcloud beta api-gateway api-configs describe $CONFIG_ID \
  --api=$API_ID \
  --project=$PROJECT_ID

# Deploy API
gcloud beta api-gateway gateways create $GATEWAY_ID \
  --api=$API_ID \
  --api-config=$CONFIG_ID \
  --location=$REGION \
  --project=$PROJECT_ID

# Verify API gateway
gcloud beta api-gateway gateways describe $GATEWAY_ID \
  --location=$REGION \
  --project=$PROJECT_ID

# Set hostname from "defaultHostname" from previous command; will look similar to "demo-gateway-n3nf83ks.ew.gateway.dev"
HOSTNAME=

# Test API
curl https://$HOSTNAME/