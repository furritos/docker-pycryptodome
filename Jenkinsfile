pipeline {

   agent { 
      node { 
         label 'jenkins-agent'
         checkout scmGit(branches: [[name: '*/v2.7']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/furritos/docker-pycryptodome']])
      }
   }

   options {
      buildDiscarder(logRotator(numToKeepStr: '30'))
      timestamps()
   }

   parameters {
      string(name: "DockerHub_Name", defaultValue: 'furritos', description: 'DockerHub repository name')
      string(name: "Branch_Name", defaultValue: 'v2.7', description: '')
      string(name: "Image_Name", defaultValue: 'furritos/pycryptodome', description: 'Image name')
      string(name: "Image_Tag", defaultValue: '2.7-alpine', description: 'Image tag')
      booleanParam(name: "PushImage", defaultValue: false)
   }

   stages {
      stage("Build docker images") {
         steps {
            script {
               echo "Bulding docker images"
               def buildArgs = "-f Dockerfile ."
               docker.build("${params.Image_Name}:${params.Image_Tag}", buildArgs)
            }
         }
      }

      stage("Push to Dockerhub") {
         when { 
            equals expected: "true", 
            actual: "${params.PushImage}"
         }
         steps {
            script {
               echo "Pushing the image to docker hub"
               def localImage = "${params.Image_Name}:${params.Image_Tag}"
               def repositoryName = "${params.DockerHub_Name}/${localImage}"
               sh "docker tag ${localImage} ${repositoryName} "
               docker.withRegistry("", "DockerHubCredential") {
                  def image = docker.image("${repositoryName}");
                  image.push()
               }
            }
         }
      }
   }
   
}