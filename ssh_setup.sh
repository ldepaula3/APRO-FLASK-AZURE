# Generate SSH keys - machine where you git clone
ssh-keygen -t rsa -f $HOME/apro_flask_azure/.ssh/id_rsa

# Generate authorized_keys
cat $HOME/apro_flask_azure/.ssh/id_rsa.pub >> $HOME/apro_flask_azure/.ssh/authorized_keys