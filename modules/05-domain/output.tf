output "dns_zone_name" {

  value = google_dns_managed_zone.i_heng_store.name
}

output "dns_zone_domain" {
  value = google_dns_managed_zone.i_heng_store.dns_name
}

output "a_record_ip" {
  value = google_dns_record_set.a_record.rrdatas
}

output "api_record" {
  value = google_dns_record_set.api_cname_record.rrdatas
}

output "argocd_record" {
  value = google_dns_record_set.argocd_cname_record.rrdatas
}