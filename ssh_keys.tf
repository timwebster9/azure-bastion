/*
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}
*/

resource "null_resource" "ssh_keys" {
    provisioner "local-exec" {
        command = <<EOT
          ssh-keygen -m PEM -t rsa -b 4096 -P "" -f ./id_rsa
          az keyvault secret set --name cmdline-ssh-private-key --vault-name bastionkv675674475675 --value ./id_rsa
    EOT  
    }
}

data "local_file" "ssh_public_key" {
    filename = "./id_rsa.pub"

    depends_on = [
      null_resource.ssh_keys
    ]
}