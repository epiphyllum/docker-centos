all: build

build:
	@cat ${HOME}/.ssh/id_rsa.pub > authorized_keys
	@docker build --tag=hary/centos:6.6 .

