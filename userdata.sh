#!/bin/bash
##PARAMETERS##
app_dir="/app/django_app"
app_basedir=$( dirname $app_dir)
install_script="install.sh"
##END OF PARAMETERS##
yum update -y
yum install -y git 
useradd -m "$app_user"
mkdir -p $app_dir
chown -R "${app_user}:${app_user}" "$app_basedir"
su - "$app_user" -c "git clone https://github.com/dext0s/django_app.git $app_dir"
su - "$app_user" -c "cd $app_dir; chmod +x $install_script; ./${install_script}"
#MISSING CLOUDFORMATION COMMANDS
#
