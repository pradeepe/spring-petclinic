node {
    
    environment{
        echo " project Info "
        // Sonar Project Info - You must replace these vars with the Project Name and Key from the ADOP Portal!
        SONAR_PROJECT_NAME = 'Simple Java project analyzed with the SonarQube Runner'
        SONAR_PROJECT_KEY = 'java-sonar-runner-simple'
        ENVIRONMENT_NAME = 'CI'
    }
    
    stage ('SCM checkout') {
        git credentialsId: 'github_login', url: 'https://github.com/pradeepe/spring-petclinic.git'
    }
    
    stage ('MVN Package') {
        def mvnHome = tool name: 'M3', type: 'maven'
        def mvnCMD = "${mvnHome}/bin/mvn"
        sh "${mvnCMD} clean package -DskipTests"
    }
    
    stage ('Move Dockerfile') {
        sshPublisher(publishers: [sshPublisherDesc(configName: 'Docker-Host', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//opt//docker', remoteDirectorySDF: false, removePrefix: '',sourceFiles: 'Docerfile')],   usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
    }
    
    stage ('Build Docker Image') {
        sshPublisher(publishers: [sshPublisherDesc(configName: 'Docker-Host', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''docker stop spring-petclinic;
        docker rm -f spring-petclinic;
        docker image rm -f spring-petclinic;
        cd /opt/docker
        docker build -t spring-petclinic .''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//opt//docker', remoteDirectorySDF: false, removePrefix: 'target', sourceFiles: 'target/*war')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
    }
    
    stage ('Push Docker Image') {
        withCredentials([string(credentialsId: 'DockerHubSec', variable: 'DokerHubSec')]) {
            sh "docker login -u pradeepe -p ${DokerHubSec}"
        }
        
        sh 'docker push  pradeepe/spring-petclinic:1.0.0'
    }
    
    
    stage ('Run Container on Decker Host') {
        echo 'Run Container on Decker Host'
        def DockerRun = 'docker run -d --name spring-petclinic -p 8090:8080 petclinic'
        sshPublisher(publishers: [sshPublisherDesc(configName: 'Docker-Host', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: "${DockerRun}", execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
    }
    
}
