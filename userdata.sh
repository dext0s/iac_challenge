#!/bin/bash -xe
##PARAMETERS##
app_name="django_app"
app_user="appuser"
install_script="install.sh"
app_repo="https://github.com/dext0s/django_app.git"
##END OF PARAMETERS##
app_dir="/app/${app_name}"
app_basedir=$( dirname $app_dir)
yum update -y
yum install -y git
useradd -m "$app_user"
mkdir -p $app_dir
chown -R "${app_user}:${app_user}" "$app_basedir"
su - "$app_user" -c "git clone $app_repo $app_dir"
su - "$app_user" -c "cd $app_dir; chmod +x $install_script; ./${install_script}"
