pipeline{
    environment {
        def imageName = "krashnat922/devops-ansible-poc:ec2${env.BUILD_ID}"
        //def imageName = "krashnat922/devops-ansible-poc:ec253"
        //ANSIBLE_PRIVATE_KEY=credentials('KTvm-private-key')
    }


    agent any
    stages{

        stage("Build Docker Image") {
          steps{
            script {
              docker.withRegistry("", "KT-dockerHub") {
                  sh "docker build --network=host -t ${imageName} ."
                }
            }
          }
        }

        stage("Push Image to Registry") {
          steps{
            script {
              docker.withRegistry("", "KT-dockerHub") {
                  sh "docker push ${imageName}"
                  sh "docker rmi --force \$(docker images -q ${imageName} | uniq)"
                 }
            }
          }
        }

/*
        stage("Deploy via Ansible") {
          steps {
              //sh 'pip install --upgrade requests==2.20.1'
              //sh 'echo -e "[defaults]\nremote_tmp     = /tmp/ansible-$USER\nsudo_user      = root\nsudo           = true" > ansible.cfg'
              //sh 'ansible --version'
              //sh 'mkdir /etc/ansible'
              //sh 'cp /app/ansible.cfg .'
              //sh 'cat /app/ansible.cfg'
              //sh 'cat ansible.cfg' 
              //sh 'ansible-playbook create_ec2.yml'
                /*sh 'ansible-playbook -i ansible.inv --private-key=$ANSIBLE_PRIVATE_KEY main.yml'
             /*  ansiblePlaybook disableHostKeyChecking: true, installation: 'ansible', inventory: 'ansible.inv', playbook: 'main.yml', vaultCredentialsId: 'KTvm-private-key'
            
              echo "Hello"
            }
        }
        
  */
stage("Deploy service on k8s-bm-staging") {
          steps {
            kubernetesDeploy(kubeconfigId: 'bm-staging-kubeconfig',
               configs: 'nodePOC.yaml',
               enableConfigSubstitution: true)
            }
        }



    }
     
    
        post {

        success{
            mail to: 'krishna.tapdiya@afourtech.com',
             subject: "[JENKINS]: ${currentBuild.fullDisplayName} Succeed",
             body: "Project Name : ${currentBuild.fullDisplayName}\n  Status       : Succeed\n  Log          : ${env.BUILD_URL}/consoleText"
            }

        failure{
           mail to: 'krishna.tapdiya@afourtech.com',
             subject: "[JENKINS]: ${currentBuild.fullDisplayName} Failed",
             body: "Project Name : ${currentBuild.fullDisplayName}\n  Status       : Failed\n  Log          : ${env.BUILD_URL}/consoleText"
        }
    }

  
}
