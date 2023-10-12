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
      string(name: "Branch_Name", defaultValue: 'master', description: '')
      string(name: "Image_Name", defaultValue: "${params.DockerHub_Name}/pycryptodome", description: 'Image name')
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