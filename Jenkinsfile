pipeline{
    environment {
        def imageName = "afouruser/afour-services:PHP-POC-${env.BRANCH_NAME}-v0.0-${env.BUILD_ID}"
    }


  agent { 
    docker { dockerfile true } 
  }
    stages{

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

        stage("Deploy service on k8s-bm-staging") {
          when{
                branch 'main'
          }
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
