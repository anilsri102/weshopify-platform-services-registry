pipeline{
    agent{
        label "worker-01-jenkins"
    }
    tools{
        maven 'MAVEN_HOME'
    }
    stages{
        stage("Pull the code from SCM"){
            steps{
                echo "========Pull the code from SCM=========="
                git branch: 'master',
                    url: 'https://github.com/anilsri102/weshopify-service-registry.git'
                    echo "=====Pull the code from SCM==========="
            }
        }
        stage("Build the Source code"){
            steps{
                echo "================Code building is starting=============="
                sh 'cd weshopify-platform-services-registry'
                sh 'cd weshopify-platform-services-registry && mvn clean package -DskipTests=true'
                echo "================Artifact Generated============="
            }
        }
        stage("Sonar Quality Analysis"){
            steps{
                echo "================Sonar Quality Gate Starting=============="
                sh 'cd weshopify-platform-services-registry'
                sh 'cd weshopify-platform-services-registry && mvn verify sonar:sonar -Dsonar.projectKey=weshopify-service-registry -Dsonar.projectName=weshopify-service-registry -Dsonar.host.url=http://3.109.8.134:9000 -Dsonar.token=sqp_2053fe642dc950fe25f6d81abbd3b6d190387216 -DskipTests=true'
                echo "================Sonar Quality Gate Analyzed the Artifact ============="
            }
        }
         stage("Deploy to Artifactory"){
            steps{
                echo "================Deploying to artifacory Started=============="
                sh 'cd weshopify-platform-services-registry && mvn deploy'
                echo "================Artifact Deploy is Completed============="
            }
        }
        stage("Copy the files to ansible server"){
            steps{
                echo "Connecting to Ansible Server"
                sshagent(['ANSIBLE_SERVER']){
                    sh 'cd weshopify-platform-services-registry && scp Dockerfile ansible-admin@172.31.0.106:/opt/ci-cd-files'
                    sh 'cd weshopify-platform-services-registry && scp weshopify-svc-registry-playbook.yml ansible-admin@172.31.0.106:/opt/ci-cd-files'
                    sh 'cd weshopify-platform-services-registry && scp jfrog.sh ansible-admin@172.31.0.106:/opt/ci-cd-files'
                    sh '''
                        ssh -tt ansible-admin@172.31.0.106 << EOF
                            ansible-playbook /opt/ci-cd-files/weshopify-svc-registry-playbook.yml
                            exit
                        EOF    

                    '''
                }
            }
        }
    }    

}
