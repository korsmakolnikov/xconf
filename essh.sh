user=korsmakolnikov
ip=$1
uip="$user@$ip"
echo "connecting to $uip"
ssh -v -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $uip

                                                 
