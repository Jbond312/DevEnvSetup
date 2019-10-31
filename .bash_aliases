#If the last character of the alias value is blank, then the next command word following the alias is also checked for alias expansion

#General
alias ls='ls -Alh'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../'
alias reload='source ~/.bash_profile'

#Docker
alias dps='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dprune='docker system prune'

#Docker-Compose
alias dcup='docker-compose up'
alias dcdown='docker-compose down'
alias dcbuild='docker-compose build'

#Kubernetes
alias kall='kubectl get all '
