FROM amazonlinux:2

RUN yum update -y \
    && yum install -y curl \
                       gcc \
                       gcc-c++ \
                       make \
                       openssl-devel \
                       libcurl-devel \
                       readline-devel \
                       which

ENV NODE_VERSION 14.x
RUN curl -sL https://rpm.nodesource.com/setup_$NODE_VERSION | bash - \
    && yum install -y nodejs


RUN echo "[mongodb-org-4.4]" >> /etc/yum.repos.d/mongodb-org-4.4.repo \
    && echo "name=MongoDB Repository" >> /etc/yum.repos.d/mongodb-org-4.4.repo \
    && echo "baseurl=https://repo.mongodb.org/yum/amazon/2/mongodb-org/4.4/x86_64/" >> /etc/yum.repos.d/mongodb-org-4.4.repo \
    && echo "gpgcheck=1" >> /etc/yum.repos.d/mongodb-org-4.4.repo \
    && echo "enabled=1" >> /etc/yum.repos.d/mongodb-org-4.4.repo \
    && echo "gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc" >> /etc/yum.repos.d/mongodb-org-4.4.repo \
    && yum install -y mongodb-org

EXPOSE 27017

COPY . .


RUN npm install


CMD ["npm", "run", "start", "0.0.0.0:5010"]