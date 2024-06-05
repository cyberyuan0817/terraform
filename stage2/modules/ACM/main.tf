# Request an ACM certificate
resource "aws_acm_certificate" "my_ssl" {
  domain_name       = "alb.${var.host_web_address}"
  validation_method = "DNS"


  tags = {
    Name = "my-web-cert"
  }
}


resource "null_resource" "acm_dependency" {
  depends_on = [aws_acm_certificate.my_ssl]
}


// Create Route 53 DNS validation record (CNAME)
resource "aws_route53_record" "cert_validation" {
  zone_id = var.zone_id // Route53 Zone ID

  name    = tolist(aws_acm_certificate.my_ssl.domain_validation_options)[0].resource_record_name
  type    = "CNAME"
  ttl     = 3600
  records = [tolist(aws_acm_certificate.my_ssl.domain_validation_options)[0].resource_record_value]

}




# Request an ACM certificate
resource "aws_acm_certificate" "my_uat_ssl" {
  domain_name       = "uat.${var.host_web_address}"
  validation_method = "DNS"

  tags = {
    Name = "my-uat-web-cert"
  }
}


resource "null_resource" "acm_uat_dependency" {
  depends_on = [aws_acm_certificate.my_ssl]
}


// Create Route 53 DNS validation record (CNAME)
resource "aws_route53_record" "cert_uat_validation" {
  zone_id = var.zone_id // Route53 Zone ID

  name    = tolist(aws_acm_certificate.my_uat_ssl.domain_validation_options)[0].resource_record_name
  type    = "CNAME"
  ttl     = 3600
  records = [tolist(aws_acm_certificate.my_uat_ssl.domain_validation_options)[0].resource_record_value]

}
