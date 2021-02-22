# This script is meant to be called from Dockerfile before all others.
# It contains the shell commands to be executed as root.

echo "\nRunning ${0} as `whoami`\n"

# Standard preparations.
apt-get update -qqy
export LANG=C.UTF-8

# Create secondary journal directory (prevents unhealthy container state).
cd /usr/irissys/mgr
printf "\nConfiguring alternate journal directory..."
sed -i "s/AlternateDirectory=.*/AlternateDirectory=\/usr\/irissys\/mgr\/journal2\//" /usr/irissys/iris.cpf
mkdir journal2
chown --reference=journal journal2

export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true
# Set timezone to NL.
echo 'tzdata tzdata/Areas select Europe' | debconf-set-selections
echo 'tzdata tzdata/Zones/Europe select Amsterdam' | debconf-set-selections
# Set timezone to UTC.
# echo 'tzdata tzdata/Areas select Etc' | debconf-set-selections
# echo 'tzdata tzdata/Zones/Etc select UTC' | debconf-set-selections
apt-get install -qqy --no-install-recommends tzdata

# Clean up apt stuff.
rm -rf /var/lib/apt/lists/*
