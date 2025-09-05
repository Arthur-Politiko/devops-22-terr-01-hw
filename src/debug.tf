output "sa_file_path" {
  value = var.yc_sa_file
}

output "sa_file_exists" {
  value = fileexists(var.yc_sa_file)
}