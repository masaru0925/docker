# Dockernizing Anaconda(python3.5) w/ openCV3: Dockerfile for building images

# Based on ubuntu:latest

# Format: FROM		repositoray[:version]
FROM	ubuntu:latest

# Maintainer
MAINTAINER	Masaru <masaru.0925@gmail.com>

# Environment vriables
ENV PATH /root/anaconda3/bin:$PATH

# Directories for notebooks
RUN	mkdir /opt/notebooks
RUN	chmod a+rw /opt/notebooks
	# Don't forget adding /opt/notebooks in “File Sharing” of “Docker preferences…” 

# Installation:
# ubuntu packages
RUN	apt-get update && apt-get --assume-yes install \
	bzip2 \
	libgtk2.0-0 \
	libpng12-0 \
	libgomp1 \
	vim \
	wget 
# Anaconda3
RUN	wget https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh \
	&& bash ./Anaconda3-4.2.0-Linux-x86_64.sh -b -p /root/anaconda3 \
	&& rm -f ./Anaconda3-4.2.0-Linux-x86_64.sh 


# OpenCV3
RUN	conda install -y -c https://conda.anaconda.org/menpo opencv3

# Configure Jupyter notebook
RUN	jupyter notebook --generate-config && \
	echo "c.NotebookApp.token = ''" 			>> /root/.jupyter/jupyter_notebook_config.py && \
	echo "c.NotebookApp.open_browser = False"		>> /root/.jupyter/jupyter_notebook_config.py && \
	echo "c.NotebookApp.ip = '*'"				>> /root/.jupyter/jupyter_notebook_config.py && \
	echo "c.NotebookApp.port = 8888"			>> /root/.jupyter/jupyter_notebook_config.py && \
	echo "c.NotebookApp.notebook_dir = '/opt/notebooks'"	>> /root/.jupyter/jupyter_notebook_config.py

# Startup
CMD	jupyter notebook
#CMD	jupyter notebook >/dev/null 2>&1 &
