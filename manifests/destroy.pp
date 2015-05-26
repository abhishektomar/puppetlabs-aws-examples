####

class aws_vpc (
	$vpcdetails,
	) {
    ec2_securitygroup { "sg_${vpcdetails[vpcname]}":
      ensure   => absent,
      region => "${vpcdetails[region]}",
    } ~>

    ec2_vpc_internet_gateway { "igw_${vpcdetails[vpcname]}":
      ensure => absent,
      region => "${vpcdetails[region]}",
    } ~>

    ec2_vpc_subnet { 'public-us-east-1b':
      ensure => absent,
      region => "${vpcdetails[region]}",
    } ~>

    ec2_vpc_subnet { 'public-us-east-1c':
      ensure => absent,
      region => "${vpcdetails[region]}",
    } ~>

    ec2_vpc_subnet { 'public-us-east-1d':
      ensure => absent,
      region => "${vpcdetails[region]}",
    } ~>

    ec2_vpc_subnet { 'public-us-east-1e':
      ensure => absent,
      region => "${vpcdetails[region]}",
    } ~>

    ec2_vpc_routetable { "public_${vpcdetails[vpcname]}":
      ensure => absent,
      region => "${vpcdetails[region]}",
    } ~>

    ec2_vpc { "${vpcdetails[vpcname]}":
      ensure => absent,
      region => "${vpcdetails[region]}",
    }
}

include aws_vpc
