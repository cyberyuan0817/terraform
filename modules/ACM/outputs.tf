output "ssl_cert_arn" {
    value = aws_acm_certificate.my_ssl.arn
}

output "ssl_uat_cert_arn" {
    value = aws_acm_certificate.my_uat_ssl.arn
}