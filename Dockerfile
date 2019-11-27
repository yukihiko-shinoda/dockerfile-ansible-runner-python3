FROM ansible/ansible-runner:1.4.4
# Hot-fix, waiting for next version
# @see https://github.com/ansible/ansible/issues/56629
RUN yum remove -y python2-ansible-runner python2-daemon python2-lockfile python2-pexpect python2-psutil python2-ptyprocess
RUN pip uninstall -y --no-cache-dir ansible
# sshpass           : requirement to ssh host with password by Ansible
#                     @see https://github.com/ansible/ansible-runner/commit/7453c10a377bfc007ad99bf9dec6023bbaaee44e
# python3-devel     : requirement to install Ansible with Python 3
# gcc               : requirement to install psutil (Ansible) with Python 3
# gcc-python3-plugin: requirement to compile psutil by Python 3
# which             : requirement to run pipenv install --system --deploy
RUN yum install -y sshpass python3-devel gcc gcc-python3-plugin which && yum clean all
# psutil: @see https://github.com/giampaolo/psutil/issues/1143#issuecomment-406513376
RUN pip3 install --no-cache-dir pipenv ansible ansible-runner
