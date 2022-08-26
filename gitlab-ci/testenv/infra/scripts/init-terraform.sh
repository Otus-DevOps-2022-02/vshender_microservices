#!/bin/bash

# This script is run on a Gitlab runner.

# Install dependencies.
apt update && apt install -y openssh-client wget unzip

# Generate an SSH key for the environment instance access.
ssh-keygen -t rsa -b 4096 -C appuser -N "" -f ~/.ssh/appuser

# Install Terraform.
wget https://hashicorp-releases.yandexcloud.net/terraform/1.2.6/terraform_1.2.6_linux_amd64.zip -O /tmp/terraform.zip
unzip -o -d /usr/local/bin/ /tmp/terraform.zip

# Configure Terraform.
cat <<EOF > ~/.terraformrc
provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}
EOF

sed -e "s/{{ envname }}/$CI_ENVIRONMENT_SLUG/; s/{{ access_key }}/$YC_STATE_BUCKET_ACCESS_KEY/; s/{{ secret_key }}/$YC_STATE_BUCKET_SECRET_KEY/" ../templates/backend.tf.template > backend.tf
cat backend.tf

# Create docker-compose.
mkdir files
sed -e "s/{{ reddit_app_image }}/${DOCKER_IMAGE_NAME//\//\\/}/" ../templates/docker-compose.yml.template > files/docker-compose.yml
cat files/docker-compose.yml

# Initialize Terraform.
terraform init
