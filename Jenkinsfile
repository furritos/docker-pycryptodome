pipeline {

   agent { 
      node { 
         label 'jenkins-agent'
      }
   }

   options {
      buildDiscarder(logRotator(numToKeepStr: '30'))
      timestamps()
   }

   parameters {
      string(name: "DockerHub_Name", defaultValue: 'furritos', description: 'DockerHub repository name')
      string(name: "Branch_Name", defaultValue: 'v3.8', description: '')
      string(name: "Image_Name", defaultValue: 'pycryptodome', description: 'Image name')
      string(name: "Image_Tag", defaultValue: '3.8-alpine', description: 'Image tag')
      booleanParam(name: "PushImage", defaultValue: true)
   }

   stages {

      stage("Build Docker images") {
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
               echo "Pushing the image to Docker hub"
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