#!/bin/bash
# by default userdata get sudo user

dnf install ansible -y 
cd /tmp
git clone https://github.com/nallamsrikanth12/expense-ansible-roles.git
cd expense-ansible-roles
ansible-playbook main.yaml -e component=backend -e login_password=ExpenseApp1
ansible-playbook main.yaml -e component=frontend


