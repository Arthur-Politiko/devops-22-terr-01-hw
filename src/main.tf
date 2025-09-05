
# resource "random_password" "random_string" {
#   length      = 16
#   special     = false
#   min_upper   = 1
#   min_lower   = 1
#   min_numeric = 1
# }


# resource "docker_image" "hello_world" {
#   name         = "nginx:latest"
#   keep_locally = false
# }

# resource "docker_container" "nginx" {
#   image = docker_image.hello_world.image_id
#   name  = "example_${random_password.random_string.result}"

#   ports {
#     internal = 80
#     external = 9090
#   }
# }
