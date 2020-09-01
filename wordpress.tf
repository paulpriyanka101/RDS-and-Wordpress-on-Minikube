
resource "null_resource" "minikubestart" {
 provisioner "local-exec" {
      command = "minikube start"
   }
}

provider "kubernetes" {
 config_context_cluster = "minikube"
}

resource "kubernetes_deployment" "wordpressdc" {
 metadata {
  name = "wordpress"
 }
 
 spec {
  replicas = 2
  selector {
   match_labels = {
    env = "dev"
    app = "wordpress"
   }
            
  }
  
  template {
   metadata {
    labels = {
     env = "dev"
     app = "wordpress"
    }
   }

   spec {
    container {
     image = "wordpress:4.8-apache"
     name = "mywpsite"
    }
   }
  }
 }
}

resource "kubernetes_service" "wordpresslb" {
	depends_on = [kubernetes_deployment.wordpressdc]

 	metadata {
  		name = "wordpresslb"
 	}

 	spec {
  		selector = {
   		app = "wordpress"
  	}
  
  port {
   protocol = "TCP"
   port = 80
   target_port = 80
  }
  
  type = "NodePort"
 }
}
