pipeline{
    environment {
       // def imageName = "krashnat922/devops-ansible-poc:ec2${env.BUILD_ID}"
        //def imageName = "krashnat922/devops-ansible-poc:ec253"
        //ANSIBLE_PRIVATE_KEY=credentials('KTvm-private-key')
        AWS_ACCESS_KEY_ID = credentials('kt_aws_access_key')
        AWS_SECRET_KEY_ID = credentials('kt_aws_secret_key')
    }


    agent { label 'devops-poc' }
    stages{
/*
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

*/
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
             //sh 'ansible-playbook -i ansible.inv --private-key=$ANSIBLE_PRIVATE_KEY main.yml'
              //ansiblePlaybook disableHostKeyChecking: true, installation: 'ansible', inventory: 'ansible.inv', playbook: 'main.yml', vaultCredentialsId: 'KTvm-private-key'
             //ansiblePlaybook become: true, becomeUser: 'ubuntu', disableHostKeyChecking: true, extras: 'AWS_KEY=xxxxx,AWS_SECRET=yyyyy', installation: 'ansible', playbook: '', sudo: true, sudoUser: 'ubuntu', vaultCredentialsId: 'KTvm-private-key'
              sh '''yum install python python-pip awscli -y
              yum update -y && yum upgrade -y
              pip install boto boto3'''
          // withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'kt_personal_aws_creds', secretKeyVariable: 'AWS_SECRET_KEY_ID']]) {
               sh 'ansible-playbook create_ec2.yml --extra-vars "AWS_ACCESS_KEY=$AWS_ACCESS_KEY_ID AWS_SECRET_KEY=$AWS_SECRET_KEY_ID"'
   
//}
              sh 'echo "Hello"'
            }
        }
        
  /*
stage("Deploy service on k8s-bm-staging") {
          steps {
            kubernetesDeploy(kubeconfigId: 'bm-staging-kubeconfig',
               configs: 'nodePOC.yaml',
               enableConfigSubstitution: true)
            }
        }
        */
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
