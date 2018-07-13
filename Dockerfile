FROM jenkins/jenkins:2.131

USER root
COPY jenkins-plugins.txt /usr/share/jenkins/ref/plugins.txt
#RUN mkdir -p /usr/share/jenkins/ref/plugins/ && /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# install docker engine

RUN apt-get update
RUN apt-get install -y apt-transport-https dirmngr unzip
RUN echo 'deb https://apt.dockerproject.org/repo debian-stretch main' >> /etc/apt/sources.list
#RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys F76221572C52609D
RUN apt-get update
RUN apt-get install -y --allow-unauthenticated docker-engine
RUN usermod -aG docker root && usermod -aG docker jenkins

# install meteor
RUN curl https://install.meteor.com/ | sh

# fixing ubuntu OOM bug
RUN uname -r
RUN apt-get upgrade -y

RUN mkdir /opt/android/ && cd /opt/android && wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip /opt/android/sdk-tools-linux-4333796.zip -d /opt/android/android-sdk-tools && rm /opt/android/sdk-tools-linux-4333796.zip

ENV ANDROID_HOME=/opt/android/android-sdk-tools
ENV PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

RUN mkdir -p $ANDROID_HOME/licenses && echo -e "\nd56f5187479451eabf01fb78af6dfcb131a6481e" > $ANDROID_HOME/licenses/android-sdk-license
RUN sdkmanager "platform-tools" "platforms;android-28"

# drop back to the regular jenkins user - good practice
USER jenkins