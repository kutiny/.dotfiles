#!/bin/bash

alias k=kubectl

which kubecolor &> /dev/null

if [[ "$?" -eq 0 ]]; then
    alias k=kubecolor
fi

function kpf() {
  service=$(kubectl get po | grep $1 | head -n1 | awk '{print $1}')
  echo -e "Forwarding service \e[32m$service\e[0m"
  kubectl port-forward $service $2
}

function kterm() {
  service=$(kubectl get po | grep $1 | head -n1 | awk '{print $1}')
  echo -e "Opening terminal in \e[32m$service\e[0m"
  kubectl exec -it $service -- sh
}

function kdestroy() {
  service=$(kubectl get po | grep $1 | head -n1 | awk '{print $1}')
  deployment=$(kubectl get deploy -o name | grep $1 | head -n1)
  echo -e "Destroying pod \e[32m$service\e[0m"
  kubectl delete po $service && kubectl rollout status $deployment
}

function klogs() {
  service=$(kubectl get po | grep $1 | awk '{print $1}')
  services=($(echo $service | tr ";" "\n"))
  services_count=${#services[@]}
  pod=${services[1]}
  if [[ $services_count > 1 ]]; then
      opts=""
      for (( i=1; i <= $services_count; i++ )); do
          opt="$i: ${services[$i]}"
          opts="$opts$opt;"
      done

      echo "Pods:"
      echo $opts | column -t -s';'
      echo -n "Seleciona pod: "
      read pod_no;

      sel_pod=${services[$pod_no]}
      if [[ -z $sel_pod ]]; then
          echo -e "\e[31mPod no valido.\e[0m"
          return
      fi
      pod=${services[$pod_no]}
  fi
  echo -e "Logs from \e[32m$pod\e[0m"
  kubectl logs -f $pod --tail 200
}

