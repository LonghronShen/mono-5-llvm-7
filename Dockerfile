FROM mono:5

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
	rm -fR /var/lib/apt/lists/* && \
	mkdir -p /var/lib/apt/lists/partial && \
	mv /etc/apt/sources.list.d/mono-official-stable.list /etc/apt/sources.list.d/mono-official-stable.list.bak && \
	wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
	echo deb http://apt.llvm.org/jessie/ llvm-toolchain-jessie-7 main > /etc/apt/sources.list.d/llvm.list && \
	echo deb-src http://apt.llvm.org/jessie/ llvm-toolchain-jessie-7 main >> /etc/apt/sources.list.d/llvm.list && \
	echo deb http://mirrors.tuna.tsinghua.edu.cn/debian/ jessie main contrib non-free > /etc/apt/sources.list && \
	echo deb http://mirrors.tuna.tsinghua.edu.cn/debian/ jessie-updates main contrib non-free >> /etc/apt/sources.list && \
	echo deb http://mirrors.tuna.tsinghua.edu.cn/debian/ jessie-backports main contrib non-free >> /etc/apt/sources.list && \
	echo deb http://mirrors.tuna.tsinghua.edu.cn/debian-security jessie/updates main contrib non-free >> /etc/apt/sources.list && \
	apt-get clean && apt-get update --fix-missing && \
	apt-get install -y python-setuptools build-essential vim wget git curl llvm-7.0 clang-7.0 lldb-7.0 liblldb-7.0-dev libunwind8 libunwind8-dev gettext libicu-dev liblttng-ust-dev libcurl4-openssl-dev libssl-dev libkrb5-dev libnuma-dev && \
	rm -rf /var/lib/apt/lists/* /tmp/* && \
	easy_install -U pip && \
	pip install cmake
	
RUN echo fs.file-max = 100000 >> /etc/sysctl.conf && sysctl -p
