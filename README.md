# Terraform-mongodb

This module is primary written for provisioning of GCE instance from our Mongodb image

It does a few things :
* Downloads RAW disk from GCS and create an image from it using packer
* Provision MongoDB config on GCE instance
* Create (GCP) firewall rules so GKE pods can reach GCE MongoDB instances


## Configuration

Variables.tf explanation  (followed by default values if applicable) :

* project - name of GCP project
* zone - zone of GCP project
* instance_name - base for GCE instances name
* cluster_ipv4_cidr - IPv4 CIDR of GKE cluster - for firewall rule setting
* node_count:1 - number of MongoDB nodes to deploy
* machine_type:n1-standard-1 - type of instance to deploy to
* raw_image_source - URL of tar archive containing RAW source for MongoDB image (you can use Packer image template to generate image, as mentioned above)
* rs:none - name of Replica Set. Leave default to not setup Replica Set
* data_disk_gb:30 - size of persistent data disk, in GB - it will be mounted on /var/lib/mongodb and formatted as XFS
* data_disk_type:pd-standard - type of persistent data disk - pd-standard or pd-ssd

## Usage

```hcl
module "mongodb-prod" {
  source = "./mongodb"
  project = "my-gcp-project"
  zone = "europe-west3-c"
  instance_name = "mongodb-prod"
  cluster_ipv4_cidr = "10.123.0.0/14"
  node_count = "3"
  raw_image_source = "https://storage.googleapis.com/packer-img/mongodb3.4-disk-latest.tar.gz"
  rs = "prod"
}

```
