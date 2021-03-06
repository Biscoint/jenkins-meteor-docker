# docker stop jenkins
# docker rm jenkins
docker run -p 8080:8080 -p 50000:50000 -v ~/biscoint-apk-keystore.jks:/opt/biscoint-apk-keystore.jks -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --restart unless-stopped --env JAVA_OPTS="-Xmx2g -Dorg.jenkinsci.plugins.durabletask.BourneShellScript.HEARTBEAT_CHECK_INTERVAL=900 -Duser.timezone=America/Sao_Paulo" --name jenkins -d biscoint/jenkins-meteor:latest &
