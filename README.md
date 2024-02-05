# Implementing MapReduce with Hadoop

Environment Setup
1. **Install Hadoop**: Download and install Hadoop on your local machine. 
Detailed instructions can be found on the Apache Hadoop official website.
https://hadoop.apache.org/releases.html

2. **Configuration**: Configure Hadoop's core-site.xml, hdfs-site.xml, and mapred-site.xml as per your local setup. 
You typically need to set up the filesystem and specify the temporary directories.

Installing Hadoop on a Linux system involves several steps. Below is a simplified guide to help you set up Hadoop in a standalone mode, which is suitable for running MapReduce jobs on a single node (useful for development and testing). This guide assumes you're using a Debian-based Linux system like Ubuntu.

	### Step 1: Update Your System

	First, ensure your package lists and installed packages are updated.

	```bash
	sudo apt-get update
	sudo apt-get upgrade
	```

	### Step 2: Install Java

	Hadoop requires Java to be installed on your machine.

	```bash
	sudo apt-get install openjdk-8-jdk
	```

	Verify the Java installation by checking the version:

	```bash
	java -version
	```
	
	Set `JAVA_HOME` temporarily
	
	```bash
	export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
	```


	### Step 3: Download Hadoop

	Go to the [Apache Hadoop official website](https://hadoop.apache.org/releases.html) to find the download link for the version you want to install. You can use `wget` to download Hadoop directly to your machine. Replace the URL in the command below with the latest version's URL.

	```bash
	wget https://downloads.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz
	```

	### Step 4: Extract Hadoop

	Extract the Hadoop tar file to a location of your choice. `/usr/local/hadoop` is commonly used.

	```bash
	sudo tar zxvf hadoop-3.3.6.tar.gz -C /usr/local
	```

	Move and rename the Hadoop folder for convenience:

	```bash
	sudo mv /usr/local/hadoop-3.3.6 /usr/local/hadoop
	```

	### Step 5: Configure Hadoop Environment

	Edit your `~/.bashrc` or `~/.profile` file to include Hadoop binaries in your path and set up necessary environment variables.

	```bash
	nano ~/.bashrc
	```

	Append the following lines to the file:

	```bash
	# Hadoop Related Options
	export HADOOP_HOME=/usr/local/hadoop
	export PATH=$PATH:$HADOOP_HOME/bin
	export PATH=$PATH:$HADOOP_HOME/sbin
	export HADOOP_MAPRED_HOME=$HADOOP_HOME
	export HADOOP_COMMON_HOME=$HADOOP_HOME
	export HADOOP_HDFS_HOME=$HADOOP_HOME
	export YARN_HOME=$HADOOP_HOME
	export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
	export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
	```

	Load the new environment variables:

	```bash
	source ~/.bashrc
	```

	### Step 6: Configure Hadoop

	Edit Hadoop configuration files located in `$HADOOP_HOME/etc/hadoop/` to set up the standalone mode. For a basic setup, minimal configuration is required, but you might want to start with `core-site.xml`, `hdfs-site.xml`, `mapred-site.xml`, and `yarn-site.xml`.

	As an example, you can set your `core-site.xml` as follows:

	```xml
	<configuration>
	    <property>
		<name>fs.defaultFS</name>
		<value>hdfs://localhost:9000</value>
	    </property>
	</configuration>
	```
	
		To edit Hadoop configuration files on Ubuntu CLI (Command Line Interface) for setting up standalone mode, you will primarily work with the terminal and a text editor. `nano` is a simple, user-friendly text editor available on most Linux distributions. If you prefer, you can use `vi` or `vim` instead of `nano`, but for beginners, `nano` might be easier.

		First, ensure you've set the `HADOOP_HOME` environment variable correctly. This variable should point to the directory where Hadoop is installed. For example, if you've installed Hadoop in `/usr/local/hadoop`, you can set `HADOOP_HOME` like this:

		```bash
		export HADOOP_HOME=/usr/local/hadoop
		```

		You might want to add this line to your `~/.bashrc` or `~/.profile` file to make the setting persistent across sessions.

		Now, follow these steps to edit the Hadoop configuration files:

		### 1. Editing `core-site.xml`

		Navigate to the Hadoop configuration directory:

		```bash
		cd $HADOOP_HOME/etc/hadoop/
		```

		Open `core-site.xml` for editing with `nano`:

		```bash
		nano core-site.xml
		```

		Inside the editor, you will either find an empty `configuration` block or some pre-existing configuration properties. You need to add or update the `fs.defaultFS` property within the `configuration` tags, like so:

		```xml
		<configuration>
		    <property>
			<name>fs.defaultFS</name>
			<value>hdfs://localhost:9000</value>
		    </property>
		</configuration>
		```

		If other properties exist, make sure to add your new property block outside those existing blocks but still inside the `<configuration>` tags.

		Press `Ctrl+O`, then `Enter` to save the file, and `Ctrl+X` to exit `nano`.

		### 2. Editing Other Configuration Files

		The process to edit `hdfs-site.xml`, `mapred-site.xml`, and `yarn-site.xml` is similar. For a basic standalone setup, you may not need to add much to these files, but here are some general guidelines for what they're used for:

		- `hdfs-site.xml`: Configurations specific to HDFS, such as replication factor and storage directories.
		- `mapred-site.xml`: Configurations for MapReduce jobs, such as the framework name (`yarn`) and memory settings.
		- `yarn-site.xml`: Configurations for YARN, the resource manager, including resource allocation settings and scheduler configurations.

		For each file, repeat the steps used to edit `core-site.xml`, adapting the properties to your needs based on Hadoop documentation or specific instructions you're following.

		### Note

		- These changes configure Hadoop to run in standalone mode using the default filesystem (HDFS) on `localhost` port `9000`.
		- Ensure Hadoop and Java paths are correctly set in your `hadoop-env.sh` file, which is also located in the `$HADOOP_HOME/etc/hadoop/` directory.
		- After configuration, you can start Hadoop services and test your setup by running a MapReduce job or accessing HDFS with the CLI tools provided by Hadoop.

		Remember, the exact configurations might vary based on the Hadoop version and the specific requirements of your project. Always refer to the official Hadoop documentation for the most accurate and detailed information.

	**Note**: Configuration details can vary based on your specific requirements and Hadoop version. Please refer to the official Hadoop documentation for detailed configuration options.

	### Step 7: Format the Hadoop Filesystem

	Before starting Hadoop for the first time, format the Hadoop filesystem (HDFS):

	```bash
	hdfs namenode -format
	```

	### Step 8: Start Hadoop
	
	Start HDFS by executing:

	```bash
	$HADOOP_HOME/sbin/start-dfs.sh

	```

	Start all Hadoop daemons with the following script:

	```bash
	start-all.sh
	```

	Check the running Java processes to confirm Hadoop is running:

	```bash
	jps
	```

	You should see processes like `Namenode`, `Datanode`, `ResourceManager`, and `NodeManager`.

	### Step 9: Access Hadoop Web Interfaces

	You can access Hadoop's web interfaces for the Namenode and the ResourceManager using your web browser:

	- Namenode: `http://localhost:9870/`
	- ResourceManager: `http://localhost:8088/`

	These URLs may vary depending on your configuration and Hadoop version.

	**Note**: This guide is for setting up Hadoop in standalone mode for development and testing purposes. For production environments, especially for clustered setups, additional configuration and considerations are necessary.


# Implementation Sample Code: WordCount.java
```
// WordCount.java
import java.io.IOException;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class WordCount {
    public static class TokenizerMapper
       extends Mapper<Object, Text, Text, IntWritable>{
        private final static IntWritable one = new IntWritable(1);
        private Text word = new Text();
        public void map(Object key, Text value, Context context
                        ) throws IOException, InterruptedException {
          String[] words = value.toString().split("\\s+");
          for (String str : words) {
            word.set(str);
            context.write(word, one);
          }
        }
    }

    public static class IntSumReducer
       extends Reducer<Text,IntWritable,Text,IntWritable> {
        private IntWritable result = new IntWritable();
        public void reduce(Text key, Iterable<IntWritable> values,
                           Context context
                           ) throws IOException, InterruptedException {
          int sum = 0;
          for (IntWritable val : values) {
            sum += val.get();
          }
          result.set(sum);
          context.write(key, result);
        }
    }

    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        Job job = Job.getInstance(conf, "word count");
        job.setJarByClass(WordCount.class);
        job.setMapperClass(TokenizerMapper.class);
        job.setCombinerClass(IntSumReducer.class);
        job.setReducerClass(IntSumReducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);
        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
}
```

To run a simple WordCount program in Hadoop, you'll need to follow several steps from writing the code to executing it on your Hadoop cluster. Here's a detailed guide on how to achieve this, including where to place files and how to prepare the environment.

### Step 1: Writing the Code

- **File Name**: `WordCount.java`
- **Location**: Create a directory for your Hadoop projects. For example, `~/hadoop_projects/WordCount/`.
- **Content**: Copy the provided Java code into `WordCount.java`.

### Step 2: Compiling the Code and Creating a JAR

1. **Compilation**: Navigate to the directory containing your `WordCount.java` file. Compile the code using the Hadoop libraries. You might need to specify the classpath to include Hadoop's jar files, which are located in the `$HADOOP_HOME/share/hadoop/mapreduce/` and `$HADOOP_HOME/share/hadoop/common/` directories.

    Example command (adjust paths as necessary for your Hadoop installation and JDK):
    ```bash
    javac -classpath `$HADOOP_HOME/bin/hadoop classpath` -d ./ WordCount.java
    ```

2. **Creating a JAR File**: After compilation, create a JAR file from the compiled classes. Assuming you're in the directory containing your compiled `.class` files:
    ```bash
    jar cf wordcount.jar *.class
    ```

### Step 3: Preparing Input Data

1. **Creating Input Directory in HDFS**: Before running the WordCount program, you need an input directory in HDFS and some text data to process.
    ```bash
    hdfs dfs -mkdir /input
    ```

2. **Adding Sample Data**: Place a text file containing the data you want to process in the `/input` directory. You can create a sample text file on your local filesystem and then copy it to HDFS.
    ```bash
    echo "Hello Hadoop. Welcome to the world of big data." > sample.txt
    hdfs dfs -put sample.txt /input
    ```

### Step 4: Running the WordCount Program

- **Ensure Hadoop Services Are Started**: Make sure Hadoop's `NameNode`, `DataNode`, `ResourceManager`, and `NodeManager` are running. You've already checked this using the `jps` command.

- **Executing the Job**:
    Navigate to the directory containing your `wordcount.jar` file. Run the WordCount program by specifying the input and output directories in HDFS.
    ```bash
    hadoop jar wordcount.jar WordCount /input /output
    ```
    **Note**: The `/output` directory should not exist before you run this command. Hadoop will create it and store the result of the word count operation there.

### Step 5: Checking the Output

After the job completes, you can check the output in the `/output` directory in HDFS.
```bash
hdfs dfs -cat /output/*
```
This command prints the content of the output files, where you should see the counted words and their frequencies.

### Conclusion

Following these steps, you've compiled and run a simple WordCount Java program on Hadoop, dealing with input and output data in HDFS. This process involves writing Java code, compiling it with Hadoop libraries, managing data in HDFS, and finally executing the MapReduce job on your cluster.

## Instructions for Local Implementation

- For **Hadoop MapReduce**, ensure Java and Hadoop are correctly installed and configured on your machine. Compile the WordCount Java program, upload a sample text file to HDFS, and run the MapReduce job.
