# Enable Vault Auth Method and create Path

resource "vault_auth_backend" "devops_team1" {
  type = "userpass"
  path = "devops_team1"
}

resource "vault_auth_backend" "devops_team2" {
  type = "userpass"
  path = "devops_team2"
}

resource "vault_auth_backend" "infra_team1" {
  type = "userpass"
  path = "infra_team1"
}

resource "vault_auth_backend" "infra_team2" {
  type = "userpass"
  path = "infra_team2"
}


# Create ID under Auth Paths

resource "vault_generic_endpoint" "devops_team1_user01" {
  depends_on           = [vault_auth_backend.devops_team1]
  path                 = "auth/devops_team1/users/devopsteam1"

  data_json = <<EOT
{
  "policies": ["devops_team1_policy"],
  "password": "changeme"
}
EOT
}


resource "vault_generic_endpoint" "devops_team2_user01" {
  depends_on           = [vault_auth_backend.devops_team2]
  path                 = "auth/devops_team2/users/devopsteam2"

  data_json = <<EOT
{
  "policies": ["devops_team2_policy"],
  "password": "changeme"
}
EOT
}

resource "vault_generic_endpoint" "infra_team1_user01" {
  depends_on           = [vault_auth_backend.infra_team1]
  path                 = "auth/infra_team1/users/infrateam1"

  data_json = <<EOT
{
  "policies": ["infra_team1_policy"],
  "password": "changemei"
}
EOT
}

resource "vault_generic_endpoint" "infra_team2_user01" {
  depends_on           = [vault_auth_backend.infra_team2]
  path                 = "auth/infra_team2/users/infrateam2"

  data_json = <<EOT
{
  "policies": ["infra_team2_policy"],
  "password": "changemei"
}
EOT
}

# Enable Secret / Create Path / Select Secret Engine

resource "vault_mount" "kvv2-devops-team1" {
  path        = "kvv2_devops_team1"
  type        = "kv-v2"
  
}

resource "vault_mount" "kvv2-devops-team2" {
  path        = "kvv2_devops_team2"
  type        = "kv-v2"
  
}

resource "vault_mount" "kvv2-infra-team1" {
  path        = "kvv2_infra_team1"
  type        = "kv-v2"
  
}

resource "vault_mount" "kvv2-infra-team2" {
  path        = "kvv2_infra_team2"
  type        = "kv-v2"
  
}

# Create Secret under path of Secret Engines

resource "vault_kv_secret_v2" "aws_devrole_team1_secrets" {
  mount                      = vault_mount.kvv2-devops-team1.path
  name                       = "aws_master_devrole_team1"
  data_json                  = jsonencode(
  {
    username       = "devroleteam1",
    password       = "Password"
  }
  )
  
}

resource "vault_kv_secret_v2" "aws_adminrole_team1_secrets" {
  mount                      = vault_mount.kvv2-devops-team1.path
  name                       = "aws_master_adminole_team1"
  data_json                  = jsonencode(
  {
    username       = "adminroleteam1",
    password       = "Password"
  }
  )
  
}

resource "vault_kv_secret_v2" "aws_devrole_team2_secrets" {
  mount                      = vault_mount.kvv2-devops-team2.path
  name                       = "aws_master_devrole_team2"
  data_json                  = jsonencode(
  {
    username       = "devroleteam2",
    password       = "Password"
  }
  )
  
}

resource "vault_kv_secret_v2" "aws_infra_team1_secrets" {
  mount                      = vault_mount.kvv2-infra-team1.path
  name                       = "aws_master_adminrole_team1"
  data_json                  = jsonencode(
  {
    access_key       = "admin",
    secret_acesskey  = "Passwordxeekii12"
  }
  )
  
}

resource "vault_kv_secret_v2" "aws_infra_team2_secrets" {
  mount                      = vault_mount.kvv2-infra-team2.path
  name                       = "aws_master_adminrole_team2"
  data_json                  = jsonencode(
  {
    access_key       = "admin",
    secret_acesskey  = "Passwordxeekii12"
  }
  )
  
}


resource "vault_policy" "devops_team1_policy" {
  name = "devops_team1_policy"

  policy = <<EOT
path "kvv2_devops_team1/*" {
  capabilities = ["create", "delete", "read"]
}
EOT
}


resource "vault_policy" "devops_team2_policy" {
  name = "devops_team2_policy"

  policy = <<EOT
path "kvv2_devops_team2/*" {
  capabilities = ["create", "delete", "read"]
}
EOT
}

resource "vault_policy" "infra_team1_policy" {
  name = "infra_team1_policy"

  policy = <<EOT
path "kvv2_infra_team1/*" {
  capabilities = ["create", "delete", "read"]
}
EOT
}

# resource "vault_policy" "infra_team2_policy" {
#   name = "infra_team2_policy"

#   policy = <<EOT
# path "kvv2_infra_team2/*" {
#   capabilities = ["create", "delete", "read"]
# }
# EOT
# }