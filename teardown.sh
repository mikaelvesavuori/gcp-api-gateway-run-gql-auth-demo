# Basic GCP settings
PROJECT_ID="my-project"
REGION="europe-west1" # Allowed values for API Gateway (beta): asia-east1, europe-west1, us-central1

# Cloud Run
SERVICE_NAME="gql-api"

# API Gateway
GATEWAY_ID="demo-gateway"
API_ID="demo-api"
CONFIG_ID="demo-config"

# IAM service account for API Gateway
SERVICE_ACCOUNT_NAME="serviceaccount-demo-api"

# Cloud Run
gcloud beta run services delete $SERVICE_NAME --region $REGION --platform managed --quiet

# API Gateway
gcloud beta api-gateway api-configs delete $CONFIG_ID --api=$API_ID --quiet
gcloud beta api-gateway apis delete $API_ID --quiet
gcloud beta api-gateway gateways delete $GATEWAY_ID --location $REGION --quiet

# IAM service account
gcloud iam service-accounts delete $SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com

echo "Make sure to delete all of your storage buckets as well!"