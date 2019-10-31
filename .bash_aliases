#If the last character of the alias value is blank, then the next command word following the alias is also checked for alias expansion

#General
alias ls='ls -Alh --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../'
alias reload='source ~/.bash_profile'
alias path='echo -e ${PATH//:/\\n}'

#Docker
alias d='docker '
alias dps='docker ps -a '
alias di='docker images'
alias drm='docker rm '
alias drmi='docker rmi '
alias dprune='docker system prune'
alias dtag='docker tag '

#Docker-Compose
alias dc='docker-compose '
alias dcup='docker-compose up'
alias dcdown='docker-compose down'
alias dcbuild='docker-compose build'

#Kubernetes
alias k='kubectl '
alias kall='k get all '
alias kp='k get pods '
alias ks='k get services '
alias kd='k get deployments '
alias kl='k logs -f '