FROM maven:3.6.2-jdk-8
  
CMD ["/bin/sh"]
ARG CLOUD_SDK_VERSION=271.0.0
ENV CLOUD_SDK_VERSION=271.0.0
ENV PATH=${PATH}/google-cloud-sdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get -qqy update
RUN apt-get install -qqy apt-transport-https lsb-release gnupg
RUN echo 'deb http://deb.debian.org/debian/ sid main' >> /etc/apt/sources.list &&     export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" &&     echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list &&     curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

RUN apt-get update
RUN apt-get install -y google-cloud-sdk=${CLOUD_SDK_VERSION}-0 kubectl

RUN gcloud --version
RUN mvn --version
RUN kubectl version --client
