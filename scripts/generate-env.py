import click

@click.command()
@click.option("--giturl", prompt="Your Git URL", help="Your git URL. Example: https://github.com/validatedpatterns/industrial-edge.git.")
@click.option("--robot-account-username", prompt="Your quay robot account username", help="Your robot account username.")
@click.option("--robot-account-password", prompt="Your quay robot account password", hide_input=True, help="Your robot account password.")
@click.option("--github-username", prompt="Your Git username", help="Your Git username.")
@click.option("--github-token", prompt="Your Git token", hide_input=True, help="Your Git token.")
@click.option("--aws-access-key-id", prompt="Your AWS access key ID", help="Your AWS access key ID.")
@click.option("--aws-secret-access-key", prompt="Your AWS secret access key", hide_input=True, help="Your AWS secret access key.")
@click.option("--git-account", prompt="Your Git account", help="Your Git account.")
@click.option("--image-registry-account", prompt="Your image registry account", help="Your image registry account.")
@click.option("--image-registry-hostname", prompt="Your image registry hostname", help="Your image registry hostname.")
@click.option("--s3-bucket-region", prompt="Your S3 bucket region", help="Your S3 bucket region.")
@click.option("--s3-bucket-name", prompt="Your S3 bucket name", help="Your S3 bucket name.")
@click.option("--git-hostname", prompt="Your Git hostname", help="Your Git hostname. Example: github.com.")
@click.option("--version", prompt="Your version", default="v2.3", help="Your version.")
def create_env_file(
    giturl, robot_account_username, robot_account_password, github_username,
    github_token, aws_access_key_id, aws_secret_access_key, git_account,
    image_registry_account, image_registry_hostname, s3_bucket_region,
    s3_bucket_name, git_hostname, version
):
    """Creates a .env file with the given variables."""
    
    with open(".env", "w") as env_file:
        env_file.write("YOUR_CLUSTER_GROUP_NAME=datacenter\n")
        env_file.write("YOUR_GLOBAL_PATTERN=industrial-edge\n")
        env_file.write("YOUR_IMAGEREGISTRY_TYPE=quay\n")
        env_file.write("YOUR_DEV_REVISION=main\n")
        env_file.write("YOUR_GIT_URL=" + giturl + "\n")
        env_file.write("YOUR_ROBOT_ACCOUNT_USERNAME=" + robot_account_username + "\n")
        env_file.write("YOUR_ROBOT_ACCOUNT_PASSWORD=" + robot_account_password + "\n")
        env_file.write("YOUR_GITHUB_USERNAME=" + github_username + "\n")
        env_file.write("YOUR_GITHUB_TOKEN=" + github_token + "\n")
        env_file.write("YOUR_AWS_ACCESS_KEY_ID=" + aws_access_key_id + "\n")
        env_file.write("YOUR_AWS_SECRET_ACCESS_KEY=" + aws_secret_access_key + "\n")
        env_file.write("YOUR_GIT_ACCOUNT=" + git_account + "\n")
        env_file.write("YOUR_IMAGEREGISTRY_ACCOUNT=" + image_registry_account + "\n")
        env_file.write("YOUR_IMAGEREGISTRY_HOSTNAME=" + image_registry_hostname + "\n")
        env_file.write("YOUR_S3_BUCKET_REGION=" + s3_bucket_region + "\n")
        env_file.write("YOUR_S3_BUCKET_NAME=" + s3_bucket_name + "\n")
        env_file.write("YOUR_GIT_HOSTNAME=" + git_hostname + "\n")
        env_file.write("YOUR_VERSION=" + version + "\n")

if __name__ == "__main__":
    create_env_file()
