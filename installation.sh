sudo apt-get update
sudo apt-get upgrade

sudo apt-get install openjdk-8-jdk

java -version

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre

wget https://downloads.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz

sudo tar zxvf hadoop-3.3.6.tar.gz -C /usr/local

sudo mv /usr/local/hadoop-3.3.6 /usr/local/hadoop


