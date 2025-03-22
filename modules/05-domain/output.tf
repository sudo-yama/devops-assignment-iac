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
value = "${var.api_name}.${join(",", google_dns_record_set.monitor_cname_record.rrdatas)}"
}

output "argocd_record" {
  value = "${var.argocd_name}.${join(",", google_dns_record_set.monitor_cname_record.rrdatas)}"
}

output "monitor_record" {
  value = "${var.monitor_name}.${join(",", google_dns_record_set.monitor_cname_record.rrdatas)}"
}