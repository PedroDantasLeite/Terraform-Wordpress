resource "kubernetes_service" "wordpress-service" {
    metadata {
        name = "wordpress-service011"
    }
    spec {
        selector = {
            app = "wordpress"
        }

        type = "LoadBalancer"

        port {
            port = 80
            target_port = 80
        }
    }
}