FROM centos:6.6
MAINTAINER hary <94093146@qq.com>

ENV DEBIAN_FRONTEND noninteractive

ADD CentOS-Base.repo-6x /etc/yum.repo.d/CentOS-Base.repo

# 安装openssh-server
RUN echo "192.168.16.136  mirror.tfs.com" >>  /etc/hosts \
  && yum install -y openssh-server openssh-clients sudo

# 设置时区
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
 && ssh-keygen -N '' -f /root/.ssh/id_rsa \
 && ssh-keygen -t dsa -P '' -f /etc/ssh/ssh_host_dsa_key \
 && ssh-keygen -t rsa -P '' -f /etc/ssh/ssh_host_rsa_key \
 && sed -i 's/.*session.*required.*pam_loginuid.so.*/session optional pam_loginuid.so/g' /etc/pam.d/sshd

# 添加登录
ADD authorized_keys /root/.ssh/

RUN chmod 600 /root/.ssh/authorized_keys

CMD /usr/sbin/sshd -D
