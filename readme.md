# Terraform with Vault Integration

This is a sample project demonstrating the integration of **Terraform** with **Vault** for managing authentication, secrets, and policies for various teams.

## How to Test the Integration

Follow the steps below to test the Terraform configuration with your Vault server.

### Prerequisites
- Vault server is set up and accessible.
- Terraform is installed on your machine.

### Steps to Test

1. **Clone the repository** (if applicable):
   ```bash
   git clone git@github.com:TunNyein/terraform-vault.git
   cd terraform-vault

2. Create a terraform.tfvars file:
In your terminal, navigate to the project directory and create the terraform.tfvars file to store the Vault root token:


```bash
 touch terraform.tfvars

```
3. Paste your Vault root token:
Open the terraform.tfvars file and paste the Vault server root token as shown below:

```bash
vault_server1_rtoken = "YOUR_VAULT_SERVER_ROOT_TOKEN"
```
4. Run Terraform to apply the configuration:
After saving the changes, run the following Terraform command to apply the configuration:

```bash
terraform apply -auto-approve
```

**This command will:**

- Authenticate with Vault using the root token provided.
- Create the necessary paths for the teams (e.g., devops_team1, infra_team1).
- Set up user accounts for the teams.
- Enable secret engines for storing team-specific secrets.
- Apply policies to manage access to secrets.

**Verifying the Integration**
1. Check Vault:
Log into your Vault server and check if the paths, users, and policies were created correctly.

2. Check Secrets:
Ensure that secrets have been stored under the designated paths (e.g., kvv2_devops_team1).

3. Test Authentication:
Use the Vault UI or CLI to test authentication using the user accounts created by Terraform.

**Cleanup**
To remove the resources created by Terraform, run:


```bash
terraform destroy -auto-approve
```