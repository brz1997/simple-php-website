pipeline{
    environment {
        ANSIBLE_PRIVATE_KEY=credentials('KTvm-private-key')
    }


    agent { 
        docker { image 'krashnat922/devops-ansible-poc:latest' }
    }
    stages{
/*
        stage("Build Docker Image") {
          steps{
            script {
              docker.withRegistry("", "afour-services-dockerhub") {
                  sh "docker build --network=host -t ${imageName} ."
                }
            }
          }
        }

        stage("Push Image to Registry") {
          steps{
            script {
              docker.withRegistry("", "afour-services-dockerhub") {
                  sh "docker push ${imageName}"
                  sh "docker rmi --force \$(docker images -q ${imageName} | uniq)"
                 }
            }
          }
        }
        */

        stage("Deploy via Ansible") {
          steps {
              //sh 'pip install --upgrade requests==2.20.1'
              sh 'ansible --version'
              
              //sh 'ansible-playbook create_ec2.yml'
                /*sh 'ansible-playbook -i ansible.inv --private-key=$ANSIBLE_PRIVATE_KEY main.yml'
             /*  ansiblePlaybook disableHostKeyChecking: true, installation: 'ansible', inventory: 'ansible.inv', playbook: 'main.yml', vaultCredentialsId: 'KTvm-private-key'
            */
              echo "Hello"
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
