# Setup ssh-agent
if [ -f ~/.ssh-agent ]; then
    . ~/.ssh-agent
fi
if [ -z "$SSH_AGENT_PID" ] || ! kill -0 $SSH_AGENT_PID; then
    ssh-agent > ~/.ssh-agent
    . ~/.ssh-agent
fi
if ! ssh-add -l >& /dev/null; then
	ssh-add ~/.ssh/id_rsa 
	ssh-add ~/.ssh/id_rsa_fujiswork
fi
