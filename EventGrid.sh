# Variables
RESOURCE_GROUP=rg-eventgrid-demo
LOCATION=uksouth
TOPIC_NAME=myegtopicdemo
SUBSCRIPTION_NAME=myegsubscription
ENDPOINThttps://azureeventgridsubscriber20250813153450-cdc8c6hyc6f0gvga.canadacentral-01.azurewebsites.net/api/events

# Create resource group
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create custom Event Grid topic
az eventgrid topic create \
    --name $TOPIC_NAME \
    --location $LOCATION \
    --resource-group $RESOURCE_GROUP

# Get topic endpoint & key
az eventgrid topic show --name $TOPIC_NAME --resource-group $RESOURCE_GROUP --query "endpoint" --output tsv
az eventgrid topic key list --name $TOPIC_NAME --resource-group $RESOURCE_GROUP --query "key1" --output tsv

# Create Event Grid subscription (points to Web API endpoint)
az eventgrid event-subscription create \
    --name $SUBSCRIPTION_NAME \
    --source-resource-id $(az eventgrid topic show --name $TOPIC_NAME --resource-group $RESOURCE_GROUP --query "id" -o tsv) \
    --endpoint $ENDPOINT \
    --event-delivery-schema EventGridSchema