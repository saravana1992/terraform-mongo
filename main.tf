provider "google" {
  credentials = file("account.json")
  project     = "loyal-weaver-285602"
#  region      = "us-central1"
}

module "mongodb-prod" {
  source = "./mongodb"
  project = "loyal-weaver-285602"
  zone = "us-central1-c"
  instance_name = "mongodb-prod-cluster"
  cluster_ipv4_cidr = "10.123.0.0/16"
  node_count = "3"
  raw_image_source = "https://storage.googleapis.com/packer-img/mongodb3.4-disk-latest.tar.gz"
  rs = "prod"
}
