set -e

export ANSI_YELLOW="\e[1;33m"
export ANSI_GREEN="\e[32m"
export ANSI_RESET="\e[0m"

echo -e "\n $ANSI_YELLOW *** testing docker run - openldap *** $ANSI_RESET \n"

echo -e "$ANSI_YELLOW Download, start openldap with 'dummy creds': $ANSI_RESET"

docker run -d -p 389:389 --name ldap -e SLAPD_PASSWORD=mysecretpassword -e SLAPD_DOMAIN=ldap.example.org quay.io/ibm/openldap:2.4.44
docker inspect ldap | grep 'Running'

# firewalls in travis make this the most stable way to verify this ldap instance is running. Without credentials being passed and accepted, the ldap server would exit 
# leaving 'inspect| grep' as viable to verify values passed were accepted, starting the ldap server.
