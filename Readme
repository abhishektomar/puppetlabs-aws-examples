Puppet AWS Module Examples
==========================

Prerequsite
-----------
1. puppetlabs-aws module installed.(https://github.com/puppetlabs/puppetlabs-aws)


Usage
-----

**Creating VPC:**

Below Example will create a vpc in us-east region with 4 public subnets.

~~~
aws_vpc::vpcdetails:
    vpcname: "example"
    ensure: present
    cidr_block: "10.20.0.0/16"
    region: "us-east-1" 
    domainname: "example.in"
    domainname-servers: "AmazonProvidedDNS"
    sg-cidr: "0.0.0.0/0"
    public-subnets: 
        public-us-east-1b:
            cidr_block: "10.20.2.0/24"
            availability_zone: "us-east-1b"
            route_table: "public_example"
            map_public_ip_on_launch: "true"
        public-us-east-1c:
            cidr_block: "10.20.3.0/24"
            availability_zone: "us-east-1c"
            route_table: "public_example"
            map_public_ip_on_launch: "true"
        public-us-east-1d:
            cidr_block: "10.20.4.0/24"
            availability_zone: "us-east-1d"
            route_table: "public_example"
            map_public_ip_on_launch: "true"
        public-us-east-1e:
            cidr_block: "10.20.5.0/24"
            availability_zone: "us-east-1e"
            route_table: "public_example"
            map_public_ip_on_launch: "true"
    private-subnets:
        private-us-east-1b:
            cidr_block: "10.20.22.0/24"
            availability_zone: "us-east-1b"
            route_table: "private_example"
    loadbalancers:
~~~

**Creating EC2 Instance:**

Below Example will run the EC2 instance if it is in stopped state or it is absent.

~~~ 
web-testing1:
    ensure: running
    availability_zone: "us-east-1b"
    subnet: "public-us-east-1b"
    region: "us-east-1"
    image_id: "ami-aa776ec2"
    instance_type: "t2.micro"
    monitoring: false
    key_name: "example"
    security_groups:
        - "sg_example"
    tags:
        created_by: puppet
~~~

**Creating an ELB:**

~~~
loadbalancers:
    test-elb:
        ensure: "present"
        region: "us-east-1"
        scheme: "internet-facing"
        availability_zones:
            - "us-east-1c"
            - "us-east-1b"
            - "us-east-1e"
            - "us-east-1d"
        instances:
            - "web-testing1"
        security_groups:
            - "default"
            - "sg_example"
        listeners:
            instance_port: 80
            instance_protocol: "HTTP"
            load_balancer_port: 80
            protocol: "HTTP"
        tags:
            created_by: puppet
~~~

**Creating a Route53 Entry:**
~~~
route53:
    domaintesting.example.in.:
        ensure: present
        ttl: '300'
        values:
            - 'internal-test-123123213.us-east-1.elb.amazonaws.com'
        zone: 'example.in.'
~~~
