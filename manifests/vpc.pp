####
# AWS::VPC - Create VPC 
####

class aws::vpc (
	$vpcdetails,
	) {

    $defaults = {
        ensure => "${vpcdetails[ensure]}",
        region => "${vpcdetails[region]}",
        vpc => "${vpcdetails[vpcname]}",
    }

	ec2_vpc { "${vpcdetails[vpcname]}":
		ensure           => "${vpcdetails[ensure]}",
		cidr_block       => "${vpcdetails[cidr_block]}",
		instance_tenancy => "default",
		region           => "${vpcdetails[region]}",
        dhcp_options    => "dhcp_${vpcdetails[vpcname]}",
	}
	
	ec2_securitygroup { "sg_${vpcdetails[vpcname]}":
		ensure => "${vpcdetails[ensure]}",
		region => "${vpcdetails[region]}",
		vpc => "${vpcdetails[vpcname]}",
		description => "Security Group for VPC, maintained by puppet",
        tags => {
                name => "sg_${vpcdetails[vpcname]}",
                created_by => $::id,
        },
		ingress => [{
			security_group => "sg_${vpcdetails[vpcname]}",
		}, {
			protocol => "tcp",
			port => 22,
			cidr => "${vpcdetails[sg-cidr]}",
		}]
	}
    
    ec2_vpc_internet_gateway { "igw_${vpcdetails[vpcname]}":
        ensure => "${vpcdetails[ensure]}",
        region => "${vpcdetails[region]}",
        vpc => "${vpcdetails[vpcname]}",
    }

    ec2_vpc_routetable { "public_${vpcdetails[vpcname]}":
        ensure => "${vpcdetails[ensure]}",
        region => "${vpcdetails[region]}",
        vpc => "${vpcdetails[vpcname]}",
        routes => [
            {
                destination_cidr_block => "${vpcdetails[cidr_block]}",
                gateway => 'local'
            }, {
                destination_cidr_block => "0.0.0.0/0",
                gateway => "igw_${vpcdetails[vpcname]}"
            },
        ]
    }

    ec2_vpc_dhcp_options { "dhcp_${vpcdetails[vpcname]}":
        region => "${vpcdetails[region]}",
        domain_name => "${vpcdetails[domainname]}",
        domain_name_servers => "${vpcdetails[domainname-servers]}",
    }

    $public_subnet = $vpcdetails[public-subnets]
    create_resources(ec2_vpc_subnet, $public_subnet, $defaults)

}
