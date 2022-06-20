pipeline{
    environment {
       AWS_PRIVATE_KEY = credentials('kt_aws_private_key')
       AWS_ACCESS_KEY_ID = credentials('kt_aws_access_key')
       AWS_SECRET_KEY_ID = credentials('kt_aws_secret_key')
    }


    agent { label 'demo-docker-slave' }
    stages{
        stage("Deploy via Ansible") {
          steps {
              sh '''yum install python python-pip awscli -y
              yum update -y && yum upgrade -y
              pip install boto boto3'''
              
              sh 'yes | cp  ansible.inv /etc/ansible/hosts'
              sh 'ansible-playbook create_ec2_instance.yml --extra-vars "AWS_ACCESS_KEY=$AWS_ACCESS_KEY_ID AWS_SECRET_KEY=$AWS_SECRET_KEY_ID"'
   
              sshagent(credentials : ['kt_aws_private_key']){
                  sh ''' ec2_publicIP=$(cat /etc/ansible/ec2_publicIP)
                  ssh-keyscan -H $ec2_publicIP >> ~/.ssh/known_hosts
                  ssh ubuntu@$ec2_publicIP "mkdir ~/php-app; sudo apt-get update -y && sudo apt-get upgrade -y; sudo apt-get install php python -y; python --version"
                  scp -r $(pwd)/* ubuntu@$ec2_publicIP:~/php-app/ 
                  ssh ubuntu@$ec2_publicIP "cd ~/php-app; php -S 0.0.0.0:8088 < /dev/null &> /dev/null &"
                  '''
                  
              }
              sh 'echo "Hello"'
            }
        }
        
    }
     
    
        post {

        success{
            mail to: 'bhairavi.borawake@afourtech.com',
             subject: "[JENKINS]: ${currentBuild.fullDisplayName} Succeed",
             body: "Project Name : ${currentBuild.fullDisplayName}\n  Status       : Succeed\n  Log          : ${env.BUILD_URL}/consoleText"
            }

        failure{
           mail to: 'bhairavi.borawake@afourtech.com',
             subject: "[JENKINS]: ${currentBuild.fullDisplayName} Failed",
             body: "Project Name : ${currentBuild.fullDisplayName}\n  Status       : Failed\n  Log          : ${env.BUILD_URL}/consoleText"
        }
    }

  
}
