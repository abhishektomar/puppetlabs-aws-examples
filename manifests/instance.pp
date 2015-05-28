##
class aws_vpc::instance (
	$vpcdetails = hiera_hash(aws_vpc::vpcdetails),
    ) {
    
    $defaults = {
        ensure => "${vpcdetails[ensure]}",
        region => "${vpcdetails[region]}",
    }

    $instance_details = $vpcdetails[instances]
    create_resources(ec2_instance, $instance_details, $defaults) 

    $elb_details = $vpcdetails[loadbalancers]
    create_resources(elb_loadbalancer, $elb_details)

    $route53_details = $vpcdetails[route53]
    create_resources(route53_cname_record, $route53_details)
}

include aws_vpc::instance
