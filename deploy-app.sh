# Basic GCP settings
REGION="europe-west1" # Allowed values for API Gateway (beta): asia-east1, europe-west1, us-central1

# Cloud Run
SERVICE_NAME="gql-api"
IMAGE="gcr.io/$PROJECT_ID/$SERVICE_NAME"

# Build
gcloud builds submit --tag $IMAGE

# Deploy
gcloud run deploy $SERVICE_NAME \
  --image $IMAGE \
  --region $REGION \
  --platform managed \
  --allow-unauthenticated